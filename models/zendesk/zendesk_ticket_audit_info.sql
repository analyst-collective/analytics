select
    a.ticket_id, t.ticket_date, a.audit_date,
    e.audit_type, e.value as audit_value,
    e.is_audit_public, e.author_id as audit_author_id
from {{ref("zendesk_audits")}} a
inner join {{ref("zendesk_audits_events")}} e
    on a.audit_id = e.audit_id
inner join {{ref("zendesk_tickets")}} t
    on a.ticket_id = t.ticket_id