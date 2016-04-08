with events as (
  	select
	  	campaign_id, email_id, sent_date,
	  	decode(hard_bounced_date, null, 0, 1) as hard_bounced,
		decode(first_opened_date, null, 0, 1) as opened,
		decode(first_clicked_date, null, 0, 1) as clicked,
    	decode(unsubscribed_date, null, 0, 1) as unsubscribed
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