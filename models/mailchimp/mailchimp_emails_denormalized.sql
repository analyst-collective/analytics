with email_actions as (
    select *
    from {{env.schema}}.mailchimp_email_actions
),

sends as (
    select campaign_id, email_id, sent_date
    from {{env.schema}}.mailchimp_sent_to
),

bounces as
(
    select campaign_id, email_id, min(action_date) as bounced_date
    from email_actions
    where action = 'bounce'
    group by campaign_id, email_id
),

opens as (
    -- look at the first open date
    select campaign_id, email_id, min(action_date) as opened_date
    from email_actions
    where action = 'open'
    group by campaign_id, email_id
),

clicks as
(
    -- look at the first click data
    select campaign_id, email_id, min(action_date) as clicked_date
    from email_actions
    where action = 'click'
    group by campaign_id, email_id
)

select
    s.email_id, sent_date, bounced_date, opened_date, clicked_date,
    decode(bounced_date, null, 0, 1) as bounced,
    decode(opened_date, null, 0, 1) as opened,
    decode(clicked_date, null, 0, 1) as clicked
from sends s
left outer join bounces b
    on s.email_id = b.email_id and
    s.campaign_id = b.campaign_id
left outer join opens o
    on s.email_id = o.email_id and
    s.campaign_id = o.campaign_id
left outer join clicks c
    on s.email_id = c.email_id and
    s.campaign_id = c.campaign_id
order by 1, 2


