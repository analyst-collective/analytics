select campaign_id, email_id, action_date as clicked_date
from {{ref('mailchimp_email_actions')}}
where action = 'click'