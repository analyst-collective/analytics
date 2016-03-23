--bugs:
--for monthly customers who are missing payments, this query records the upgrade when they make the payment but not the prior downgrade when they miss the payment.
--i'm not confident that upgrades and downgrades are having the appropriate amount of revenue called 'renewal' and the appropriate called 'upgrade' or 'downgrade'.
--aka, if a person upgrades from 5 to 50, that's a 5 renewal and a 45 upgrade. from 50 to 5 that's a 45 downgrade and a 5 renewal.
--in general, i would greatly appreciate just some data validation here, making sure that we are extremely confident that the final query here is accurate.

with invoices as (

  select *
  from {{env.schema}}.stripe_invoices_transformed

), all_months as (

  select distinct date_month from invoices

), plan_changes as (

  select
    i.*,
    pmi.total as prior_month_total,
    i.total - coalesce(pmi.total, 0) as change,
    pmi.period_end as prior_month_period_end
  from
    invoices i
    left outer join invoices pmi
    on i.date_month = dateadd('month', 1, pmi.date_month)
      and i.customer = pmi.customer

), data as (

  select date_month, total, change,
    case
      when first_payment = 1
        then 'new'
      when last_payment = 1
        and dateadd('month', 1, period_end) < current_date
        then 'churn'
      when change > 0
        then 'upgrade'
      when change < 0
        then 'downgrade'
      when period != 'monthly'
        and date_month < date_trunc('month', prior_month_period_end)
        then 'prepaid renewal'
      else
        'renewal'
      end revenue_category
  from plan_changes
  order by customer, payment_number

), news as (

  select date_month, sum(total) as value
  from data
  where revenue_category = 'new'
  group by 1

), renewals as (

  select date_month, sum(total) as value
  from data
  where revenue_category in ('renewal', 'downgrade', 'upgrade')
  group by 1

), prepaids as (

  select date_month, sum(total) as value
  from data
  where revenue_category = 'prepaid renewal'
  group by 1

), churns as (

  select date_month, sum(total) as value
  from data
  where revenue_category = 'churn'
  group by 1

), upgrades as (

  select date_month, sum(change) as value
  from data
  where revenue_category = 'upgrade'
  group by 1

), downgrades as (

  select date_month, sum(change) as value
  from data
  where revenue_category = 'downgrade'
  group by 1

)

select all_months.date_month,
  news.value as new,
  renewals.value as renewal,
  prepaids.value as committed,
  churns.value * -1 as churned,
  upgrades.value as upgrades,
  downgrades.value as downgrades
from all_months
  left outer join news on all_months.date_month = news.date_month
  left outer join renewals on all_months.date_month = renewals.date_month
  left outer join prepaids on all_months.date_month = prepaids.date_month
  left outer join churns on all_months.date_month = churns.date_month
  left outer join upgrades on all_months.date_month = upgrades.date_month
  left outer join downgrades on all_months.date_month = downgrades.date_month
order by 1;
