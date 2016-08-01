-- get all subscriptions with possible ammendments for all accounts
with subscr_w_amendments as
(
    select
        account_number, acc.account_id, sub.subscr_id,
        subscr_name, subscr_status, subscr_term_type, 
        subscr_start, subscr_end, subscr_version, amend_id, amend_start
    from {{ref('zuora_account')}} acc
    inner join {{ref('zuora_subscription')}} sub
        on acc.account_id = sub.account_id
    -- add ammendments
    left outer join {{ref('zuora_amendment')}} amend
        on sub.subscr_id = amend.subscr_id
)

select
    account_number, account_id, sub.subscr_id,
    subscr_name, subscr_status, subscr_term_type, 
    subscr_start, subscr_end, subscr_version, amend_id, amend_start,
    rpc_start, rpc_end, rpc_last_segment,
    min(subscr_start) over() as first_subscr,
    "@mrr" as mrr
from subscr_w_amendments sub
inner join {{ref('zuora_rate_plan')}} rp
    on rp.subscr_id = sub.subscr_id
inner join {{ref('zuora_rate_plan_charge')}} rpc
    on rpc.rate_plan_id = rp.rate_plan_id
