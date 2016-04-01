create or replace view {{env.schema}}.mixpanel_engage as
(
	select
		mp_reserved_created			as user_created,
		mp_reserved_distinct_id		as user_id
	from demo_data.mixpanel_engage
);


create or replace view {{env.schema}}.mixpanel_export as
(
	select
		(timestamp 'epoch' + time * interval '1 Second') as event_date,
		event, distinct_id as user_id
	from demo_data.mixpanel_export
);



create or replace view {{env.schema}}.mixpanel_export_with_sessions as
(
	-- a new session is defined after 30 minutes of inactivity
	with new_sessions as
	(
		select
	        case
	            when extract(epoch from event_date) - lag(extract(epoch from event_date)) 
	                 over (partition by user_id order by event_date) >= 30 * 60 
	            then 1
	            else 0
	        end as new_session, *
	    from {{env.schema}}.mixpanel_export
	)

	-- make sure the first sessions is marked 1 and not 0
	select sum(new_session)
	       over (partition by  user_id order by event_date rows unbounded preceding) + 1 as session_idx, *
	from new_sessions
);


