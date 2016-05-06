with ticket_opens_closes as
(
    select
        ticket_id, ticket_date, date_trunc('week', ticket_date)::date as ticket_week,
        datediff(hour, ticket_date, audit_date) as hours_to_close
    from {{ref("zendesk_ticket_audit_info")}}
    where audit_value = 'closed'
)

-- find average time to close a ticket
select distinct ticket_week, avg(hours_to_close) avg_hours_to_close
from ticket_opens_closes
group by ticket_week
order by ticket_week