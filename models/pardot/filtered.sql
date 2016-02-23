create or replace view pardot.visitor_activity_filtered as (

	select
		*
	from
		pardot.visitor_activity_base
  --where

);



create or replace view pardot.prospect_filtered as (

	select
		*
	from
		pardot.prospect_base
  --where

);




create or replace view pardot.opportunity_filtered as (

	select
		*
	from
		pardot.opportunity_base
  --where

);
