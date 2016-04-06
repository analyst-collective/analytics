with events as (
  select * from {{env.schema}}.mailchimp_emails_denormalized
)

select
	  date_trunc('month', sent_date) as mnth,
	  count(*) as sends,
	  sum(opened) as opens,
	  sum(clicked) as clicks,
	  avg(opened::float) as open_rate,
	  avg(clicked::float) as click_rate
from events
group by 1
order by 1