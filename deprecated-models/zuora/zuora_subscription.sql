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
