select campaign_id, email_id, action_date as clicked_date
from {{env.schema}}.mailchimp_email_actions
where action = 'click'