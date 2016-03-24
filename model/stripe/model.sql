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
    where paid is true
      and forgiven is false

  ), d1 as (

    select (min(period_start) over () + row_number() over ())::date as date_day
    from invoices

  ), dates as (

    select distinct date_trunc('month', date_day)::date as date_month
    from d1
    where date_day <= current_date

  ), customers as (

    select customer, min(period_start) as active_from, max(period_end) as active_to
    from invoices
    where period_start <= current_date
    group by 1

  ), customer_dates as (

    select date_month, customer
    from dates d
      inner join customers c
        on d.date_month >= date_trunc('month', c.active_from)
          and d.date_month < date_trunc('month', c.active_to)

  ), data as (

    select date_month, d.customer, period_start, period_end,
      "interval" as period,
      case "interval"
        when 'yearly'
          then coalesce(i.total, 0)::float / 12 / 100
        else
          coalesce(i.total, 0)::float / 100
      end as total,
      first_value(date_month)
        over (partition by d.customer
        order by date_month
        rows between unbounded preceding and unbounded following
        ) as first_purchase_month,
      last_value(date_month)
        over (partition by d.customer
        order by date_month
        rows between unbounded preceding and unbounded following
        ) as last_purchase_month
    from customer_dates d
      left outer join invoices i
        on d.date_month >= date_trunc('month', i.period_start)
        and d.date_month < date_trunc('month', i.period_end)
        and d.customer = i.customer
      left outer join {{env.schema}}.stripe_subscriptions s on i.subscription_id = s.id
      left outer join {{env.schema}}.stripe_plans p on s.plan_id = p.id

  )

  select customer, date_month, total, period_end, period,
    case first_purchase_month
      when date_month then 1
      else 0
    end as first_payment,
    case last_purchase_month
      when date_month then 1
      else 0
    end as last_payment
  from data

);
