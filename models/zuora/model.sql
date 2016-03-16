create or replace view {schema}.account as
(
    select
        id as account_id,
        accountnumber as account_number,
        *
    from zuora.zuora_account
);


create or replace view {schema}.subscription as
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

create or replace view {schema}.rate_plan as
(
    select
        id              as rate_plan_id,
        subscriptionid  as subscr_id,
        *
    from zuora.zuora_rate_plan
);


create or replace view {schema}.rate_plan_charge as
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


create or replace view {schema}.amendment as
(
    select
        id                          as amend_id,
        subscriptionid              as subscr_id,
        effectivedate::timestamp    as amend_start,
        *
    from zuora.zuora_amendment
);






