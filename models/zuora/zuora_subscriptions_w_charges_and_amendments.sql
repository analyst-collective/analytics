-- get all subscriptions with possible ammendments for all accounts
with subscr_w_amendments as
(
    select
        account_number, acc.account_id, sub.sub_id,
        sub_name, sub.status, sub.termtype, 
        sub_start_date, sub_end_date, sub_version, amend_id, amend_start
    from {{env.schema}}.zuora_account acc
    inner join {{env.schema}}.zuora_subscription sub
        on acc.account_id = sub.accountid
    -- add ammendments
    left outer join {{env.schema}}.zuora_amendment amend
        on sub.sub_id = amend.subscr_id
)

select
    account_number, sub.account_id, sub.sub_id,
    sub.sub_name, sub.status, sub.termtype, 
    sub.sub_start_date, sub.sub_end_date, sub.sub_version, amend_id, amend_start,
    rpc_start, rpc_end, rpc_last_segment,
    min(sub.sub_start_date) over() as first_subscr,
    "@mrr" as mrr
from subscr_w_amendments sub
inner join {{env.schema}}.zuora_rate_plan rp
    on rp.subscr_id = sub.sub_id
inner join {{env.schema}}.zuora_rate_plan_charge rpc
    on rpc.rate_plan_id = rp.rate_plan_id
