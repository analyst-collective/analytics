with

subscriptions as
(
	select *
	from {{env.schema}}.zuora_subscriptions_w_charges_and_amendments
),

-- genereate calendar dates, starting with the first subscription date
dates as
(
	select date_day, date_trunc('month',date_day)::date as date_month
	from
	(
		select (first_subscr + row_number() over (order by true))::date as date_day
		from subscriptions
	)
	where date_day <= current_date
),


-- get all charges up to each date in the calendar
charges_up_to_each_date as
(
	select
		date_day, date_month, account_number, mrr, rpc_start, rpc_end, rpc_last_segment,
		amend_start, amend_id, sub_term_type, sub_start_date, sub_end_date, sub_id,
		sub_name, sub_version,
		dateadd(month,1,date_month) as date_month_plus_one,
		max(date_day) over (partition by sub_name, dateadd(month,1,date_month)) as max_subscr_trunc_date,
		max(sub_version) over (partition by sub_name, date_month) as max_subscr_version_within_date
	from dates a
	left join subscriptions b
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
			sub_term_type = 'EVERGREEN'
			and sub_start_date <= dateadd(month, 1, date_month)
			and
			(
				sub_end_date is null
				or
				sub_end_date >= dateadd(month, 1, date_month)
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
	and sub_version = max_subscr_version_within_date
	and dateadd(month, 1, date_month) <= current_date
)



-- get mrr for each month
select date_month, sum(mrr) as total_mrr
from all_charges_by_month
group by date_month
order by date_month


