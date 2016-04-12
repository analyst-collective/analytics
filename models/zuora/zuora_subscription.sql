with sub_mrr as (
select
  c.id as sub_id,
  sum(cast(a.mrr as decimal(18,2))) as mrr
from zuora.zuora_rate_plan_charge a
join zuora.zuora_rate_plan b
on a.rateplanid = b.id
join zuora.zuora_subscription c
on b.subscriptionid = c.id
where a.islastsegment = true
group by 1
),

sub_billing_periods as (
select 
  listagg(billingperiod,', ') within group (order by billingperiod) as billing_periods,
  subscriptionid
from (
select
  distinct b.subscriptionid,a.billingperiod
from zuora.zuora_rate_plan_charge a
join zuora.zuora_rate_plan b
on a.rateplanid = b.id
where a.islastsegment = true
order by a.mrr desc
)
group by 2
),

sub_product_list as (
select
  listagg(product_with_quantity,', ') within group (order by mrr desc) as product_list,
  subscriptionid
from (
select
  subscriptionid,
  mrr,
  name || ' (' || cast(quantity as integer) || ')' as product_with_quantity
from (
select
  distinct b.subscriptionid,
  b.name,
  a.mrr,
  case
    when a.quantity = 0 or a.quantity is null then 1
    else a.quantity
  end as quantity
from zuora.zuora_rate_plan_charge a
join zuora.zuora_rate_plan b
on a.rateplanid = b.id
where a.islastsegment = true
)
)
group by 2
)

select
  a.id as sub_id,
  a.name as sub_name,
  a.termtype,
  a.status,
  coalesce(lag(cast(b.effectivedate as date),1) over (partition by a.name order by cast(a."version#392c30e6081c24fb78ddf6d622de4f33" as integer)),cast(a.subscriptionstartdate as date)) as sub_effective_date,
  cast(a.contracteffectivedate as date) as contract_effective_date,
  cast(a.subscriptionstartdate as date) as sub_start_date,
  cast(a.subscriptionenddate as date) as sub_end_date,
  cast(a."version#392c30e6081c24fb78ddf6d622de4f33" as integer) as sub_version,
  coalesce(c.mrr,0) as mrr,
  d.billing_periods,
  e.product_list,
  a.accountid
from zuora.zuora_subscription a
left join zuora.zuora_amendment b
on a.id = b.subscriptionid
left join sub_mrr c
on a.id = c.sub_id
left join sub_billing_periods d
on a.id = d.subscriptionid
left join sub_product_list e
on a.id = e.subscriptionid
