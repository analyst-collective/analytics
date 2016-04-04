select
	'visitoractivity_fresher_than_one_day' as name,
	'Most recent visitoractivity entry is no more than one day old' as description,
	max("@timestamp"::timestamp) > current_date - '1 day'::interval as result
from {{env.schema}}.pardot_visitoractivity







/*

Other tests I want to do:
- make sure there are records from every day since the first day we see any records
- make sure all prospect ids from visitoractivity show up in prospects
- make sure there are no unmapped types

*/
