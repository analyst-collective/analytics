with sub_mrr as (
select
  c.id as sub_id,
  sum(cast(a.mrr as decimal(18,2))) as mrr,
  sum(cast(a.tcv as decimal(18,2))) as tcv
from zuora.zuora_rate_plan_charge a
join zuora.zuora_rate_plan b
on a.rateplanid = b.id
join zuora.zuora_subscription c
on b.subscriptionid = c.id
where a.islastsegment = TRUE
group by 1
),

sub_billing_periods AS (
SELECT 
  listagg(billingperiod,', ') WITHIN GROUP (ORDER BY billingperiod) AS billing_periods,
  subscriptionid
FROM (
SELECT
  DISTINCT b.subscriptionid,a.billingperiod
FROM zuora.zuora_rate_plan_charge a
JOIN zuora.zuora_rate_plan b
ON a.rateplanid = b.id
where a.islastsegment = TRUE
order by a.mrr desc
)
GROUP BY 2
),

sub_charge_types AS (
SELECT 
  listagg(chargetype,', ') WITHIN GROUP (ORDER BY chargetype) AS charge_types,
  subscriptionid
FROM (
SELECT
  DISTINCT b.subscriptionid,a.chargetype
FROM zuora.zuora_rate_plan_charge a
JOIN zuora.zuora_rate_plan b
ON a.rateplanid = b.id
where a.islastsegment = TRUE
order by a.mrr desc
)
GROUP BY 2
),

sub_charge_models AS (
SELECT 
  listagg(chargemodel,', ') WITHIN GROUP (ORDER BY chargemodel) AS charge_models,
  subscriptionid
FROM (
SELECT
  DISTINCT b.subscriptionid,a.chargemodel
FROM zuora.zuora_rate_plan_charge a
JOIN zuora.zuora_rate_plan b
ON a.rateplanid = b.id
where a.islastsegment = TRUE
order by a.mrr desc
)
GROUP BY 2
),

sub_distinct_rate_plans as (
select
  listagg(name,', ') WITHIN GROUP (ORDER BY name DESC) AS distinct_rate_plans,
  subscriptionid
from (
SELECT
  DISTINCT b.subscriptionid,
  b.name
FROM zuora.zuora_rate_plan_charge a
JOIN zuora.zuora_rate_plan b
ON a.rateplanid = b.id
where a.islastsegment = TRUE
)
group by 2
),

sub_distinct_products as (
select
  listagg(name,', ') WITHIN GROUP (ORDER BY name DESC) AS distinct_products,
  subscriptionid
from (
SELECT
  DISTINCT b.subscriptionid,
  e.name
FROM zuora.zuora_rate_plan_charge a
JOIN zuora.zuora_rate_plan b
ON a.rateplanid = b.id
join zuora.zuora_product_rate_plan_charge c
on a.productrateplanchargeid = c.id
join zuora.zuora_product_rate_plan d
on c.productrateplanid = d.id
join zuora.zuora_product e
on d.productid = e.id
where a.islastsegment = TRUE
)
group by 2
)

select
  a.id as sub_id,
  a.name as sub_name,
  a.termtype as term_type,
  a.status,
  a.renewalsetting as renewal_setting,
  a.isinvoiceseparate as is_invoice_separate,
  a.currenttermperiodtype as current_term_period_type,
  coalesce(lag(cast(b.effectivedate as date),1) over (partition by a.name order by cast(a.version#392c30e6081c24fb78ddf6d622de4f33 as integer)),cast(a.subscriptionstartdate as date)) as sub_effective_date,
  cast(a.contractacceptancedate as date) as contract_acceptance_date,
  cast(a.contracteffectivedate as date) as contract_effective_date,
  cast(a.subscriptionstartdate as date) as sub_start_date,
  cast(a.subscriptionenddate as date) as sub_end_date,
  cast(a.termstartdate as date) as term_start_date,
  cast(a.termenddate as date) as term_end_date,
  cast(a.cancelleddate as date) as cancelled_date,
  cast(a.createddate as timestamp) as created_date,
  cast(a.updateddate as timestamp) as updated_date,
  cast(a.originalcreateddate as timestamp) as original_created_date,
  cast(a.serviceactivationdate as date) as service_activation_date,
  cast(a.version#392c30e6081c24fb78ddf6d622de4f33 as integer) as sub_version,
  coalesce(c.mrr,0) as mrr,
  coalesce(c.tcv,0) as tcv,
  d.billing_periods,
  f.charge_types,
  g.charge_models,
  h.distinct_products,
  e.distinct_rate_plans,
  a.accountid as account_id,
  a.invoiceownerid as invoice_owner_id,
  a.createdbyid as created_by_id,
  a.updatedbyid as updated_by_id,
  a.autorenew as auto_renew,
  a.renewaltermperiodtype as renewal_term_period_type,
  cast(a."renewalterm#d6921dfe0b38e14b10fb11fbb53af737" as integer) as renewal_term,
  cast(a."currentterm#43cd92dff45a80fd1ab8e39f16b6af51" as integer) as current_term,
  a.initialtermperiodtype as initial_term_period_type,
  cast(a."initialterm#58b70e8fe6414e59d8d03a9eb211ab74" as integer) as initial_term,
  a.previoussubscriptionid as previous_subscription_id,
  a.originalid as original_id,
  a.notes,
  a.creatoraccountid as creator_account_id,
  a.creatorinvoiceownerid as creator_invoice_owner_id
from zuora.zuora_subscription a
left join zuora.zuora_amendment b
on a.id = b.subscriptionid
left join sub_mrr c
on a.id = c.sub_id
left join sub_billing_periods d
on a.id = d.subscriptionid
left join sub_distinct_rate_plans e
on a.id = e.subscriptionid
left join sub_charge_types f
on a.id = f.subscriptionid
left join sub_charge_models g
on a.id = g.subscriptionid
left join sub_distinct_products h
on a.id = h.subscriptionid
