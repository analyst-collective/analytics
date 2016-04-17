select
  sum(mrr) as gross_new_mrr,
  sum(mrr)-lag(sum(mrr),1) over (order by date_trunc('month',contract_effective_date)) as delta_gross_new_mrr,
  ((sum(mrr)-lag(sum(mrr),1) over (order by date_trunc('month',contract_effective_date)))/lag(sum(mrr),1) over (order by date_trunc('month',contract_effective_date)))*100 as percent_gross_new_mrr_growth,
  sum(mrr)*12 as gross_new_arr,
  sum(tcv) as gross_new_bookings,
  count(1) as gross_new_subscriptions,
  count(distinct account_id) as gross_new_accounts,
  avg(mrr) as avg_new_subscription_mrr,
  avg(tcv) as avg_contract_value,
  avg(datediff(months,sub_start_date,sub_end_date)) as avg_new_subscription_length,
  date_trunc('month',contract_effective_date) as date
from {{env.schema}}.zuora_subscription
where sub_version = 1
group by date_trunc('month',contract_effective_date)
order by date_trunc('month',contract_effective_date)
