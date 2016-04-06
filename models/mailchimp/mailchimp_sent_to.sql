select distinct
	list_id, campaign_id, email_id, email_address, status, send_time as sent_date
from demo_data.mailchimp_sent_to a
-- add information about when the campaign was sent
inner join demo_data.mailchimp_campaigns b
	on a.campaign_id = b.id
	and a.list_id = b.recipients__list_id