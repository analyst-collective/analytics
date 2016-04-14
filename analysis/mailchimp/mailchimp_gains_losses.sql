with
gains as (
	select date_trunc('month', signup_date) as month, count(*) total_gains
	from {{env.schema}}.mailchimp_members
	group by date_trunc('month', signup_date)
),

hard_bounces as
(
	-- get the first hard bounce date for each email
	select email_id, min(bounced_date) as event_date
    from {{env.schema}}.mailchimp_bounces
    where bounce_type = 'hard'
    group by email_id
),

unsubscribes as
(
	-- get the first unsubscribed date for each email
    select email_id, min(unsubscribed_date) as event_date
    from {{env.schema}}.mailchimp_unsubscribes
    group by email_id
),

losses as (
	-- count losses for each month
	select date_trunc('month', event_date) as month, count(*) as total_losses
	from
	(
		-- select the first of unsubscribe or hard bounce
		select email_id, min(event_date) as event_date
		from
		(
		  	select email_id, event_date
		  	from hard_bounces
		  	union
		  	select email_id, event_date
		  	from unsubscribes
		)
		group by email_id
	)
	group by month
),

months as (
	select month
	from gains
	union
	select month
	from losses
),

monthly_gains_and_losses as (

  select
  	months.month, nvl(total_gains,0) as month_gains,
  	nvl(total_losses,0) as month_losses
  from months
  left outer join gains
  	on months.month = gains.month
  left outer join losses
  	on months.month = losses.month
  order by months.month

)

select month, month_gains, month_losses * -1 as month_losses, month_gains - month_losses as net_member_growth,
	sum(month_gains) over (order by month rows unbounded preceding) as cum_gains,
	sum(month_losses) over (order by month rows unbounded preceding) as cum_losses,
	sum(month_gains) over (order by month rows unbounded preceding) -
	sum(month_losses) over (order by month rows unbounded preceding) as active_members
from monthly_gains_and_losses
