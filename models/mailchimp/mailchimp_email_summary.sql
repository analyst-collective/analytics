with
sends as (
    select campaign_id, email_id, sent_date
    from {{ref('mailchimp_sends')}}
),

hard_bounces as (
    select campaign_id, email_id, min(bounced_date) as hard_bounced_date
    from {{ref('mailchimp_bounces')}}
    where bounce_type = 'hard'
    group by campaign_id, email_id
),

opens as (
    select
        campaign_id, email_id, min(opened_date) as first_opened_date,
        max(opened_date) as last_opened_date, count(*) as total_opens
    from {{ref('mailchimp_opens')}}
    group by campaign_id, email_id
),

clicks as (
    select
        campaign_id, email_id, min(clicked_date) as first_clicked_date,
        max(clicked_date) as last_clicked_date, count(*) as total_clicks
    from {{ref('mailchimp_clicks')}}
    group by campaign_id, email_id
),

unsubscribes as (
    select campaign_id, email_id, unsubscribed_date
    from {{ref('mailchimp_unsubscribes')}}
)

select
    s.campaign_id, s.email_id, sent_date, hard_bounced_date, first_opened_date,
    last_opened_date, total_opens, first_clicked_date, last_clicked_date,
    total_clicks, unsubscribed_date,
    decode(hard_bounced_date, null, 0, 1) as hard_bounced,
    decode(first_opened_date, null, 0, 1) as opened,
    decode(first_clicked_date, null, 0, 1) as clicked,
    decode(unsubscribed_date, null, 0, 1) as unsubscribed
from sends s
left outer join hard_bounces b
    on s.email_id = b.email_id and
    s.campaign_id = b.campaign_id
left outer join opens o
    on s.email_id = o.email_id and
    s.campaign_id = o.campaign_id
left outer join clicks c
    on s.email_id = c.email_id and
    s.campaign_id = c.campaign_id
left outer join unsubscribes u
    on s.email_id = u.email_id and
    s.campaign_id = u.campaign_id
order by email_id, sent_date
