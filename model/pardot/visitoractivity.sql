--this table has a bunch of types that really should be event actions but are very poorly formulated.
--the custom logic in this view is an attempt to fix that.
--not all of the various type / type_name combinations have been accounted for yet; I still need to determine exactly what some of them mean.
select
	-- event_stream interface
	va.created_at       as "@timestamp",
	e.event_name        as "@event",
	va.prospect_id      as "@user_id",
	va.*
from
	olga_pardot.visitoractivity va
	inner join {{env.schema}}.visitoractivity_events_meta e
		on va."type" = e."type" and va.type_name = e.type_name
	inner join {{env.schema}}.visitoractivity_types_meta t
		on va."type" = t."type"
