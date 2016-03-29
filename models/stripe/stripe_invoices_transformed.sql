
  with invoices as (

    select *
    from {{env.schema}}.stripe_invoices_cleaned
    where paid is true
      and forgiven is false

  ), days as (

    select (min(period_start) over () + row_number() over ())::date as date_day
    from invoices

  ), months as (

    select distinct date_trunc('month', date_day)::date as date_month
    from days
    where date_day <= current_date

  ), customers as (

    select customer, min(period_start) as active_from, max(period_end) as active_to
    from invoices
    where period_start <= current_date
    group by customer

  ), customer_dates as (

    select m.date_month, c.customer
    from months m
      inner join customers c
        on m.date_month >= date_trunc('month', c.active_from)
          and m.date_month < date_trunc('month', c.active_to)

  )

  select date_month, d.customer, period_start, period_end,
    "interval" as period,
    case "interval"
      when 'yearly'
        then coalesce(i.total, 0)::float / 12 / 100
      else
        coalesce(i.total, 0)::float / 100
    end as total,
    case min(date_month) over(partition by d.customer)
      when date_month then 1
      else 0
      end as first_payment,
    case max(date_month) over(partition by d.customer)
      when date_month then 1
      else 0
    end as last_payment
  from customer_dates d
    left outer join invoices i
      on d.date_month >= date_trunc('month', i.period_start)
      and d.date_month < date_trunc('month', i.period_end)
      and d.customer = i.customer
    left outer join {{env.schema}}.stripe_subscriptions s on i.subscription_id = s.id
    left outer join {{env.schema}}.stripe_plans p on s.plan_id = p.id


