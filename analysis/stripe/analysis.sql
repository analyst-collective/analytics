with invoices as (

  select *
  from {{env.schema}}.stripe_invoices_transformed

), all_months as (

  select distinct date_month from invoices

), plan_changes as (

  select
    *,
    lag(total) over (partition by customer order by date_month) as prior_month_total,
    total - coalesce(lag(total) over (partition by customer order by date_month), 0) as change,
    lag(period_end) over (partition by customer order by date_month) as prior_month_period_end
  from invoices

), data as (

  select *,
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
      end revenue_category,
      case
        when prior_month_total < total then prior_month_total
        else total
      end renewal_component_of_change
  from plan_changes

), news as (

  select date_month, sum(total) as value
  from data
  where revenue_category = 'new'
  group by 1

), renewals as (

  select date_month, sum(renewal_component_of_change) as value
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
order by 1
