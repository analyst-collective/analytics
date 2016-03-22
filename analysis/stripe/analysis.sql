with

invoices as (
  select *
  from ac_jthandy.stripe_invoices_transformed
),

plan_changes as (
  select
    invoices.customer as customer,
    date_trunc('month', invoices.date) as month,
    lag(invoices.total) over (partition by invoices.customer order by invoices.date) as before,
    invoices.total as after,
    invoices.total - lag(invoices.total) over (partition by invoices.customer order by invoices.date) as change
  from
    invoices
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
  and date_trunc('month', date) < date_trunc('month', current_date)
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
where news.month < date_trunc('month', current_date)
order by month
