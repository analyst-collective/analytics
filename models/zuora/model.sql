create or replace view {{env.schema}}.account as
(
    select
        id as account_id,
        accountnumber as account_number,
        *
    from zuora.zuora_account
);


create or replace view {{env.schema}}.subscription as
(
    select
        id                                  as subscr_id,
        status                              as subscr_status,
        termtype                            as subscr_term_type,
        accountid                           as account_id,
        contracteffectivedate::timestamp    as subscr_start,
        subscriptionenddate::timestamp      as subscr_end,
        name                                as subscr_name,
        "version#392c30e6081c24fb78ddf6d622de4f33"::integer 
                                            as subscr_version,
        *
    from zuora.zuora_subscription
);

create or replace view {{env.schema}}.rate_plan as
(
    select
        id              as rate_plan_id,
        subscriptionid  as subscr_id,
        *
    from zuora.zuora_rate_plan
);


create or replace view {{env.schema}}.rate_plan_charge as
(
    select
        rateplanid                      as rate_plan_id,
        effectivestartdate::timestamp   as rpc_start,
        effectiveenddate::timestamp     as rpc_end,
        mrr                             as "@mrr",
        islastsegment                   as rpc_last_segment,
        *
    from zuora.zuora_rate_plan_charge
);


create or replace view {{env.schema}}.amendment as
(
    select
        id                          as amend_id,
        subscriptionid              as subscr_id,
        effectivedate::timestamp    as amend_start,
        *
    from zuora.zuora_amendment
);



create or replace view {{env.schema}}.rate_plan_charges as
(
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
    )

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
);




