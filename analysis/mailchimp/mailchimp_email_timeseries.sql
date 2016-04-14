with events as (
  	select *
  	from {{env.schema}}.mailchimp_email_summary
)

select
	date_trunc('month', sent_date) as month,
	count(*) as sends,
	sum(opened) as opens,
	sum(clicked) as clicks,
	avg(opened::float) as open_rate,
	avg(clicked::float) as click_rate
from events
group by month
order by month
