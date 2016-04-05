select
	-- convert unix time to timestamp
	(timestamp 'epoch' + time * interval '1 Second') as event_date,
	event, distinct_id as user_id
from demo_data.mixpanel_export