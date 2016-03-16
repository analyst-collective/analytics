-- get all subscriptions with possible ammendments for all accounts
with subscr_w_amendments as
(
	select
		account_number, acc.account_id, sub.subscr_id,
		subscr_name, subscr_status, subscr_term_type, 
		subscr_start, subscr_end, subscr_version, amend_id, amend_start
	from ac_yevgeniy.zuora_account acc
	inner join ac_yevgeniy.zuora_subscription sub
		on acc.account_id = sub.account_id
	-- add ammendments
	left outer join ac_yevgeniy.zuora_amendment amend
		on sub.subscr_id = amend.subscr_id
),

-- get all rate plan charges
rate_plan_charges as
(
	select
		account_number, account_id, sub.subscr_id,
		subscr_name, subscr_status, subscr_term_type, 
		subscr_start, subscr_end, subscr_version, amend_id, amend_start,
		rpc_start, rpc_end, rpc_last_segment,
		min(subscr_start) over() as first_subscr,
		"@mrr" as mrr
	from subscr_w_amendments sub
	inner join ac_yevgeniy.zuora_rate_plan rp
		on rp.subscr_id = sub.subscr_id
	inner join ac_yevgeniy.zuora_rate_plan_charge rpc
		on rpc.rate_plan_id = rp.rate_plan_id
),

-- genereate calendar dates, starting with the first subscription date
dates as
(
	select date_day, date_trunc('month',date_day)::date as date_month
	from
	(
		select (first_subscr + row_number() over (order by true))::date as date_day
		from rate_plan_charges
	)
	where date_day <= current_date
),


-- get all charges up to each date in the calendar
charges_up_to_each_date as
(
	select
		date_day, date_month, account_number, mrr, rpc_start, rpc_end, rpc_last_segment,
		amend_start, amend_id, subscr_term_type, subscr_start, subscr_end, subscr_id,
		subscr_name, subscr_version,
		dateadd(month,1,date_month) as date_month_plus_one,
		max(date_day) over (partition by subscr_name, dateadd(month,1,date_month)) as max_subscr_trunc_date,
		max(subscr_version) over (partition by subscr_name, date_month) as max_subscr_version_within_date
	from dates a
	left join rate_plan_charges b
		on 1=1
		and rpc_start <= date_day
		and rpc_last_segment = 'TRUE'
),

all_charges_by_month as
(
	select date_month, mrr
	from charges_up_to_each_date
	where
	(
		-- make sure the subscriptions are EVERGREEN/falling into an appropriate bucket
		(
			(
				rpc_start <= dateadd(month, 1, date_month)
				and
				rpc_end >= dateadd(month, 1, date_month)
			)
			and
			(
				amend_start > dateadd(month, 1, date_month)
				or
				amend_start is null
			)
		)
		or
		(
			subscr_term_type = 'EVERGREEN'
			and subscr_start <= dateadd(month, 1, date_month)
			and
			(
				subscr_end is null
				or
				subscr_end >= dateadd(month, 1, date_month)
			)
			and
			(
				amend_start > dateadd(month, 1, date_month)
				or
				amend_start is null
			)
		)
	)
	and date_day = max_subscr_trunc_date
	and subscr_version = max_subscr_version_within_date
	and dateadd(month, 1, date_month) <= current_date
)



-- get mrr for each month
select date_month, sum(mrr) as total_mrr
from all_charges_by_month
group by date_month
order by date_month


