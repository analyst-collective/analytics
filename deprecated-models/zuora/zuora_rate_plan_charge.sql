select
    rateplanid                      as rate_plan_id,
    effectivestartdate::timestamp   as rpc_start,
    effectiveenddate::timestamp     as rpc_end,
    mrr                             as "@mrr",
    islastsegment                   as rpc_last_segment,
    *
from zuora.zuora_rate_plan_charge
