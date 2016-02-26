with source_table as (
	select * from
		--snowplow_analysis.events_transformed
		segment_analysis.page_transformed
),
week_acquired as (
	select userid, date_trunc('week', min(timestamp)) as timestamp
	from source_table
	group by 1
),
weekly_activations as (
	select userid, date_trunc('week', timestamp) as timestamp
	from source_table
	group by 1, 2
),
analysis as (
	select
		week_acquired.timestamp as cohort,
		weekly_activations.timestamp as week,
		count(distinct weekly_activations.userid) as unique_users
	from week_acquired
		join weekly_activations on weekly_activations.timestamp >= week_acquired.timestamp and week_acquired.userid = weekly_activations.userid
	where week_acquired.timestamp > getdate() - interval '2 months'
	group by cohort, week
	order by cohort, week
)
select cohort, week, unique_users from analysis
