create or replace view {{env.schema}}.stripe_invoices as (

  select
    customer,
    date,
    forgiven,
    subscription as subscription_id,
    paid,
    total
  from
    demo_data.stripe_invoices

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

  with data as (

    select
        i.customer                as customer,
        timestamp 'epoch' + i.date * interval '1 Second'        as date,
        i.forgiven                as forgiven,
        i.paid                    as paid,
        case  p.interval
          when 'yearly'
          then i.total::float / 12 / 100
          else i.total::float / 100
        end                                                       as total,
        row_number() over(
          partition by i.customer
          order by i.date desc
        )                                                         as inverse_payment_number,
        row_number() over(
          partition by i.customer
          order by i.date asc
        )                                                         as payment_number
      from
        {{env.schema}}.stripe_invoices i
      join
        {{env.schema}}.stripe_subscriptions s
      on
        i.subscription_id = s.id
      join
        {{env.schema}}.stripe_plans p
      on
        s.plan_id = p.id

  )

  select customer, date, total, payment_number,
    case inverse_payment_number
      when 1 then 1
      else 0
    end as last_payment,
    case payment_number
      when 1 then 1
      else 0
    end as first_payment
  from data
  where
    forgiven is not true
    and paid is true

);
