select a.campaign_id, a.email_id, sent_date
from {{env.schema}}.mailchimp_sent_to a
-- add information about when the campaign was sent
inner join {{env.schema}}.mailchimp_campaigns b
	on a.campaign_id = b.campaign_id
	and a.list_id = b.list_id