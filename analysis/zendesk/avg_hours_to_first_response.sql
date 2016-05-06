with admins_and_agents as
(
    select distinct user_id
    from {{ref("zendesk_users")}}
    where role in ('admin', 'agent')
),

first_audit_dates as
(
    select ticket_id, ticket_date, min(audit_date) as first_audit_date
    from {{ref("zendesk_ticket_audit_info")}}
    where
        -- look at events from admins and agents only
        audit_author_id in (select * from admins_and_agents)
        -- look at comments only
        and audit_type = 'Comment'
        -- look at public audits only
        and is_audit_public = 1
    group by ticket_id, ticket_date
),

mins_to_reply as
(
    select
        ticket_id, ticket_date, date_trunc('week',ticket_date)::date as ticket_week,
        datediff(mins, ticket_date, first_audit_date) mins_to_reply
    from first_audit_dates
)

select ticket_week, avg(mins_to_reply)/60.0 avg_hours_to_first_responsea
from mins_to_reply
group by ticket_week
order by ticket_week asc


