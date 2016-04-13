with
charges_for_active_plans as
(
	select *
	from {{env.schema}}.zuora_subscriptions_w_charges_and_amendments
	where
		-- make sure the subscription is active
		sub_status = 'Active'
		and
		(
			-- make sure the rate plan charge is current
			(
				rpc_start <= current_date
				and
				rpc_end >= current_date
			)
			or sub_term_type = 'EVERGREEN'
		)
		and rpc_last_segment = TRUE
)


-- get the active mrr per account
select account_number, round(sum(mrr),2) as active_mrr
from charges_for_active_plans
group by account_number

