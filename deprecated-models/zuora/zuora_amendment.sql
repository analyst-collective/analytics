select
    id                          as amend_id,
    subscriptionid              as subscr_id,
    effectivedate::timestamp    as amend_start,
    *
from zuora.zuora_amendment
