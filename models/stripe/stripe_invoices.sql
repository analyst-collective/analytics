
  select
    customer,
    date,
    forgiven,
    subscription as subscription_id,
    paid,
    total,
    period_start,
    period_end
  from
    demo_data.stripe_invoices


