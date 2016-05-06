select
	id as event_id,
	type as audit_type,
	public as is_audit_public,
	author_id,
	_rjm_source_key_id as audit_id,
	value
from zendesk_pipeline.audits__events