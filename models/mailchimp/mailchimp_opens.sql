select campaign_id, email_id, action_date as opened_date
from {{load('mailchimp_email_actions')}}
where action = 'open'