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






create or replace view {{env.schema}}.mixpanel_cohort_data as
(
	with
	cohort_dates as
	(
		select
			user_id, first_event_date,
			-- get a cohort date for each user. Can use day, week, month, qtr, year
			date_trunc('week', first_event_date)::date as cohort_date
		from
		(
			select user_id, min(event_date) as first_event_date
			from {{env.schema}}.mixpanel_export
			where
				-- specifiy the cohort criterion, say based on event_1 being the user's first event
				event = 'event_1'
			group by user_id
		)
	),

	second_event_dates as
	(
		-- get a second event date
		select user_id, min(event_date) as second_event_date
		from {{env.schema}}.mixpanel_export
		where
			-- specify a second event of interest, say event_3 is a signup
			event = 'event_3'
		group by user_id
	)

	-- get a table of cohort dates and first and second event dates
	select cohort_date, first_event_date, second_event_date
	from cohort_dates
	left outer join second_event_dates
	on cohort_dates.user_id = second_event_dates.user_id
);




