with events as 
(
	-- can change 'week' to 'day', 'month', 'qtr', etc.
	-- Make sure to make corresponding everywhere below
	select date_trunc('week', event_date)::date as event_date, event, user_id
	from {{env.schema}}.mixpanel_export
),

users as
(
	select user_id, min(date_trunc('week', user_created)::date) as user_created
	from {{env.schema}}.mixpanel_engage
	group by user_id
),

overall_retention as
(
	select *, retained_users::float/active_users as overall_retention
	from
	(
		select
			events.event_date,
			count(distinct events.user_id) as active_users,
			count(distinct future_events.user_id) as retained_users
		from events
		-- join future events 
		left outer join events as future_events
			on events.user_id = future_events.user_id
			and events.event_date = future_events.event_date - interval '1 week'
		group by events.event_date
	)
),

new_retention as
(
	select *, retained_users::float/active_users as new_retention
	from
	(
		select
			events.event_date,
			count(distinct events.user_id) as active_users,
			count(distinct future_events.user_id) as retained_users
		from events
		left outer join events as future_events
			on events.user_id = future_events.user_id
			and events.event_date = future_events.event_date - interval '1 week'
		inner join users
			on events.user_id = users.user_id 
			and events.event_date = users.user_created
		group by events.event_date
	)
),

old_retention as
(
	select *, retained_users::float/active_users as old_retention
	from
	(
		select
			events.event_date,
			count(distinct events.user_id) as active_users,
			count(distinct future_events.user_id) as retained_users
		from events
		left outer join events as future_events
			on events.user_id = future_events.user_id
			and events.event_date = future_events.event_date - interval '1 week'
		inner join users
			on events.user_id = users.user_id 
			and events.event_date != users.user_created
		group by events.event_date
	)
)

select
	overall_retention.event_date, overall_retention as overall_retention_pcnt,
	new_retention as new_retention_pcnt, old_retention as old_retention_pcnt
from overall_retention
left outer join new_retention
	on overall_retention.event_date = new_retention.event_date
left outer join old_retention
	on overall_retention.event_date = old_retention.event_date



