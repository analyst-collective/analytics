select campaign_id, email_id, action_date as opened_date
from {{ref('mailchimp_email_actions')}}
where action = 'open'