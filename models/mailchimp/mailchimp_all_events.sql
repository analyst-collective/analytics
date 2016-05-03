with 
sends as (
    select campaign_id, email_id, 'sent' as event_action, sent_date as event_date
    from {{ref('mailchimp_sends')}}
),

soft_bounces as (
    select campaign_id, email_id, 'soft bounce' as event_action, bounced_date as event_date
    from {{ref('mailchimp_bounces')}}
    where bounce_type = 'soft'
),

hard_bounces as (
    select campaign_id, email_id, 'hard bounce' as event_action, bounced_date as event_date
    from {{ref('mailchimp_bounces')}}
    where bounce_type = 'hard'
),

opens as (
    select campaign_id, email_id, 'opened' as event_action, opened_date as event_date
    from {{ref('mailchimp_opens')}}
),

clicks as (
    select campaign_id, email_id, 'clicked' as event_action, clicked_date as event_date
    from {{ref('mailchimp_clicks')}}
),

unsubscribes as (
    select campaign_id, email_id, 'unsubscribed' as event_action, unsubscribed_date as event_date
    from {{ref('mailchimp_unsubscribes')}}
)

select *
from sends
union
select *
from soft_bounces
union
select *
from hard_bounces
union
select *
from opens
union
select *
from clicks
union
select *
from unsubscribes


