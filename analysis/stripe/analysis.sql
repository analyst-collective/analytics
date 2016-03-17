with

invoices as (
  select
    *
  from
    {{env.schema}}.stripe_invoices_transformed
),

plan_changes as (
  select
    invoices.company_id as company_id,
    invoices.customer as customer,
    date_trunc('month', invoices.date) as month,
    invoices.total as now,
    prior_month_invoices.total as before,
    invoices.total - prior_month_invoices.total as change
  from
    invoices
  left outer join
    prior_month_invoices
    on
      date_trunc('month', add_months(invoices.date, -1)) = date_trunc('month', prior_month_invoices.date)
      and invoices.customer = prior_month_invoices.customer
  where
    invoices.forgiven is not true
    and invoices.paid is true
),

news as (
  select
    date_trunc('month', date) as month,
    sum(total) as total
  from
    invoices
  where
    first_payment = 1
  group by
    1
),

churns AS (
  select
    date_trunc('month', invoices.date) as month,
    sum(total) as total
  from
    invoices
  where
    last_payment = 1
  and
    date_trunc('month', date) <
      (select date_trunc('month', current_date - interval '1 month')
    )
  group by
    1
),

upgrades as (
  select
    month,
    sum(change) as total
  from
    plan_changes
  where
    change > 0
  group by
    1
),

downgrades as (
  select
    month          as month,
    sum(change)    as total
  from
    plan_changes
  where
    change < 0
  group by
    1
)

select
  upgrades.month,
  upgrades.total as upgrades,
  coalesce(downgrades.total,0) as downgrades,
  coalesce(churns.total,0)*-1 as churn,
  coalesce(news.total,0) as news,
  case upgrades.month
    when (select date_trunc('month', current_date - interval '1 month'))
    then 0
    else case coalesce(churns.total,0)
         when 0
         then 20
         else coalesce(news.total,0)::float / coalesce(churns.total,0)::float
         end
    end as quickratio
from upgrades
left outer join downgrades
  on upgrades.month = downgrades.month
left outer join churns
  on upgrades.month = churns.month
join news
  on upgrades.month = news.month
where upgrades.month < (select date_trunc('month', current_date))
