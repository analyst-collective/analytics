with events as 
(
	-- can change 'week' to 'day', 'month', 'qtr', etc.
	-- Make sure to make corresponding everywhere below
	select date_trunc('week', ac_timestamp)::date as ac_date, *
	from {{env.schema}}.mixpanel_export
),

users as
(
	select ac_user_id, min(date_trunc('week', ac_user_created)::date) as ac_user_created
	from {{env.schema}}.mixpanel_engage
	group by ac_user_id
),

overall_retention as
(
	select *, 100.0*retained_users/active_users as overall_retention
	from
	(
		select
			events.ac_date,
			count(distinct events.ac_user_id) as active_users,
			count(distinct future_events.ac_user_id) as retained_users
		from events
		-- join future events 
		left outer join events as future_events
			on events.ac_user_id = future_events.ac_user_id
			and events.ac_date = future_events.ac_date - interval '1 week'
		group by events.ac_date
	)
),

new_retention as
(
	select *, 100.0*retained_users/active_users as new_retention
	from
	(
		select
			events.ac_date,
			count(distinct events.ac_user_id) as active_users,
			count(distinct future_events.ac_user_id) as retained_users
		from events
		left outer join events as future_events
			on events.ac_user_id = future_events.ac_user_id
			and events.ac_date = future_events.ac_date - interval '1 week'
		inner join users
			on events.ac_user_id = users.ac_user_id 
			and events.ac_date = users.ac_user_created
		group by events.ac_date
	)
),

old_retention as
(
	select *, 100.0*retained_users/active_users as old_retention
	from
	(
		select
			events.ac_date,
			count(distinct events.ac_user_id) as active_users,
			count(distinct future_events.ac_user_id) as retained_users
		from events
		left outer join events as future_events
			on events.ac_user_id = future_events.ac_user_id
			and events.ac_date = future_events.ac_date - interval '1 week'
		inner join users
			on events.ac_user_id = users.ac_user_id 
			and events.ac_date != users.ac_user_created
		group by events.ac_date
	)
)

select
	overall_retention.ac_date, overall_retention as overall_retention_pcnt,
	new_retention as new_retention_pcnt, old_retention as old_retention_pcnt
from overall_retention
left outer join new_retention
	on overall_retention.ac_date = new_retention.ac_date
left outer join old_retention
	on overall_retention.ac_date = old_retention.ac_date



