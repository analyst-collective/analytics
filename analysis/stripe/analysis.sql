with

invoices as (
  select *
  from {{env.schema}}.stripe_invoices_transformed
),

plan_changes as (
  select
    invoices.customer as customer,
    date_trunc('month', invoices.date) as month,
    invoices.total as now,
    prior_month_invoices.total as before,
    invoices.total - prior_month_invoices.total as change
  from
    invoices
    left outer join
      invoices prior_month_invoices
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
  from invoices
  where first_payment = 1
  group by 1
),

churns AS (
  select
    date_trunc('month', invoices.date) as month,
    sum(total) as total
  from invoices
  where last_payment = 1
  and date_trunc('month', date) < date_trunc('month', date_trunc('month', current_date) - 1)
  group by 1
),

upgrades as (
  select
    month,
    sum(change) as total
  from plan_changes
  where change > 0
  group by 1
),

downgrades as (
  select
    month          as month,
    sum(change)    as total
  from plan_changes
  where change < 0
  group by 1
)


select
  news.month,
  coalesce(news.total,0) as news,
  coalesce(churns.total,0)*-1 as churn,
  upgrades.total as upgrades,
  coalesce(downgrades.total,0) as downgrades,
  case news.month
    when date_trunc('month', date_trunc('month', current_date) - 1)
      then 0
    else
      case coalesce(churns.total, 0)
      when 0
        then 20
      else
        coalesce(news.total, 0)::float / coalesce(churns.total, 0)::float
      end
    end as quickratio
from news
  left outer join upgrades on news.month = upgrades.month
  left outer join downgrades on news.month = downgrades.month
  left outer join churns on news.month = churns.month
where news.month < (select date_trunc('month', current_date))
order by month
