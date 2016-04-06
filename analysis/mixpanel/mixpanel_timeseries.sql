select
	-- use second, minute, hour, day, week, month, quarter, etc
  	date_trunc('day', event_date) as period, count(*) period_count
from {{env.schema}}.mixpanel_export
/*
--select the time horizon and specific events here
where
	--event_date > getdate() - interval '1 week'
	--and ac_event = 'event_1'
*/
group by period
order by period asc
