select
	id as ticket_id,
	status,
	type,
	via__channel as channel,
	created_at::datetime as ticket_date
from zendesk_pipeline.tickets