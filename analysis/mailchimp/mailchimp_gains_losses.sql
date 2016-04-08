with
email_summary as
(
	select *
	from {{env.schema}}.mailchimp_email_summary
),

gains as (
	select date_trunc('month', signup_date) as month, count(*) total_gains
	from {{env.schema}}.mailchimp_members
	group by date_trunc('month', signup_date)
),

losses as (
	select month, count(*) as total_losses
	from
	(
		-- find everyone who unsubscribed
	  	select date_trunc('month', unsubscribed_date) as month
	  	from email_summary
	  	where unsubscribed_date is not null
	  	-- add everyone with a hard bounce
	  	union
	  	select date_trunc('month', hard_bounced_date) as month
	  	from email_summary
	  	where hard_bounced_date is not null
	)
	group by month
),

months as (
	select month
	from gains
	union
	select month
	from losses
)

select
	months.month, nvl(total_gains,0) as total_gains,
	nvl(total_losses,0) as total_losses
from months
left outer join gains
	on months.month = gains.month
left outer join losses
	on months.month = losses.month
order by months.month