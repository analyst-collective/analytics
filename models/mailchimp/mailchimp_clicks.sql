select campaign_id, email_id, action_date as clicked_date
from {{load('mailchimp_email_actions')}}
where action = 'click'