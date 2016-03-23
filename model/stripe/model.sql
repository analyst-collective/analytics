create or replace view {{env.schema}}.stripe_invoices as (

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

);

create or replace view {{env.schema}}.stripe_invoices_cleaned as (

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
    {{env.schema}}.stripe_invoices

);

create or replace view {{env.schema}}.stripe_subscriptions as (

  select
    id,
    plan__id as plan_id
  from
    demo_data.stripe_subscriptions

);

create or replace view {{env.schema}}.stripe_plans as (

  select
    id,
    interval
  from
    demo_data.stripe_plans

);




create or replace view {{env.schema}}.stripe_invoices_transformed as (

  with invoices as (

    select *
    from {{env.schema}}.stripe_invoices_cleaned

  ), d1 as (

    select (min(period_start) over () + row_number() over ())::date as date_day
    from invoices

  ), dates as (

    select distinct date_trunc('month', date_day)::date as date_month
    from d1
    where date_day <= current_date

  ), data as (

    select date_month, period_start, period_end,
      "interval" as period, customer,
      case  "interval"
        when 'yearly'
        then i.total::float / 12 / 100
        else i.total::float / 100
      end as total,
      row_number() over(
        partition by i.customer
        order by d.date_month) as payment_number
    from dates d
      inner join invoices i
        on d.date_month::timestamp >= date_trunc('month', i.period_start)
        and d.date_month::timestamp < date_trunc('month', i.period_end)
      inner join {{env.schema}}.stripe_subscriptions s on i.subscription_id = s.id
      inner join {{env.schema}}.stripe_plans p on s.plan_id = p.id
    where paid is true
      and forgiven is false
    order by customer, date_month

  )

    select customer, date_month, total, payment_number, period_end, period,
      case
        when date_month = last_value(date_month)
          over (partition by customer
              order by payment_number
              rows between unbounded preceding and unbounded following)
        then 1
        else 0
      end as last_payment,
      case payment_number
        when 1 then 1
        else 0
      end as first_payment
    from data

);
