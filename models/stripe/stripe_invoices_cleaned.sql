
select
  customer,
  timestamp 'epoch' + date * interval '1 Second' as date,
  forgiven,
  subscription_id,
  paid,
  total,
  timestamp 'epoch' + period_start * interval '1 Second' as period_start,
  timestamp 'epoch' + period_end * interval '1 Second' as period_end
from
  {{load('stripe_invoices')}}


