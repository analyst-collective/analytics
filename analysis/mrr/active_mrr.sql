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


charges_for_active_plans as
(
	select *
	from rate_plan_charges
	where
		-- make sure the subscription is active
		subscr_status = 'Active'
		and
		(
			-- make sure the rate plan charge is current
			(
				rpc_start <= current_date
				and
				rpc_end >= current_date
			)
			or subscr_term_type = 'EVERGREEN'
		)
		and rpc_last_segment = TRUE
)


-- get the active mrr per account
select account_number, round(sum(mrr),2) as active_mrr
from charges_for_active_plans
group by account_number

