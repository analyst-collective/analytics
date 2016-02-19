--status: not yet incorporated

-- originally sourced from URL:
-- http://www.getvero.com/resources/graphing-net-churn-using-redshift-sql/


with all_payments as (
  select
    p.customer   as customer,
    p.date       as payment_date,
    p.total      as total,
    row_number() over(partition by p.customer
      order by p.date desc) as first_row,
    row_number() over(partition by p.customer
      order by p.date asc) as last_row
  from vero_stripe_production.stripe_invoices p
  where p.period_end - p.period_start <= 2678400
),

all_payments_by_month as (
  select
    vero_stripe_production.stripe_invoices.customer             as customer,
    vero_stripe_production.stripe_invoices.period_start         as period_start,
    vero_stripe_production.stripe_invoices.period_start         as period_end,
    vero_stripe_production.stripe_invoices.total                as total,
    vero_stripe_production.stripe_subscriptions.plan__interval  as plan__interval,
    date_trunc('month',
      (timestamp 'epoch' + vero_stripe_production.stripe_invoices.date * interval '1 Second ')
    ) as date_of_invoice
  from vero_stripe_production.stripe_invoices
  join vero_stripe_production.stripe_subscriptions
    on vero_stripe_production.stripe_subscriptions.id = vero_stripe_production.stripe_invoices.subscription
),

plan_changes as (
  select
    vero_stripe_production.stripe_invoices.customer as customer,
    date_trunc('month',
      (timestamp 'epoch' + vero_stripe_production.stripe_invoices.date * interval '1 Second ')
    ) as month,
    case vero_stripe_production.stripe_subscriptions.plan__interval
      when 'year'
      then vero_stripe_production.stripe_invoices.total/100/12
      else vero_stripe_production.stripe_invoices.total/100
      end as now,
    coalesce(
      case all_payments_by_month.plan__interval
        when 'year'
        then all_payments_by_month.total/100/12
        else all_payments_by_month.total/100
        end,
      0) as before,
    (case vero_stripe_production.stripe_subscriptions.plan__interval
      when 'year'
      then vero_stripe_production.stripe_invoices.total/100/12
      else vero_stripe_production.stripe_invoices.total/100
      end) - (coalesce(
        case all_payments_by_month.plan__interval
        when 'year'
        then all_payments_by_month.total/100/12
        else all_payments_by_month.total/100
        end,
      0)) as change
  from vero_stripe_production.stripe_invoices
  left outer join all_payments_by_month
    on date_trunc('month', add_months((timestamp 'epoch' + vero_stripe_production.stripe_invoices.date * interval '1 Second '),-1)) = all_payments_by_month.date_of_invoice
    and all_payments_by_month.customer = vero_stripe_production.stripe_invoices.customer
  join vero_stripe_production.stripe_subscriptions
    on vero_stripe_production.stripe_subscriptions.id = vero_stripe_production.stripe_invoices.subscription
  where vero_stripe_production.stripe_invoices.forgiven is not true
    and vero_stripe_production.stripe_invoices.paid is true
    and coalesce(all_payments_by_month.total/100,0) <> 0
    and vero_stripe_production.stripe_invoices.period_end - vero_stripe_production.stripe_invoices.period_start <= 2678400
),

news AS (
  select sum(all_payments.total)/100 as total,
    date_trunc('month',
      (timestamp 'epoch' + all_payments.payment_date * interval '1 Second ')
    ) as month
  from all_payments
  where all_payments.last_row = 1
  group by date_trunc('month',
    (timestamp 'epoch' + all_payments.payment_date * interval '1 Second ')
  )
),

churns AS (
  select
    sum(all_payments.total)/100 as total,
    date_trunc('month',
      (timestamp 'epoch' + all_payments.payment_date * interval '1 Second ')
    ) as month
  from all_payments
  where all_payments.first_row = 1
  and date_trunc('month',
    (timestamp 'epoch' + all_payments.payment_date * interval '1 Second ')
    ) < (('now'::timestamp) - '1 months'::interval)
  group by date_trunc('month',
    (timestamp 'epoch' + all_payments.payment_date * interval '1 Second ')
  )
),

upgrades as (
  select
    plan_changes.month        as month,
    sum(plan_changes.change)  as total
  from plan_changes
  where plan_changes.change > 0
  group by plan_changes.month
),

downgrades as (
  select
    plan_changes.month        as month,
    sum(plan_changes.change)  as total
  from plan_changes
  where plan_changes.change < 0
  group by plan_changes.month
)

select
  upgrades.month,
  upgrades.total                as upgrades,
  coalesce(downgrades.total,0)  as downgrades,
  coalesce(churns.total,0)*-1   as churn,
  coalesce(news.total,0)        as news
from upgrades
left outer join downgrades
  on upgrades.month = downgrades.month
left outer join churns
  on upgrades.month = churns.month
left outer join news
  on upgrades.month = news.month
where upgrades.month < (select date_trunc('month', current_date))
