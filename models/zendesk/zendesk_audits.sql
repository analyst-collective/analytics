select
	id as audit_id,
    ticket_id,
    created_at::datetime as audit_date
FROM zendesk_pipeline.audits