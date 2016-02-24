create or replace view pardot_analysis.visitoractivity_filtered as (

	select
		*
	from
		pardot_analysis.visitoractivity_base
  --where

);



create or replace view pardot_analysis.prospect_filtered as (

	select
		*
	from
		pardot_analysis.prospect_base
  --where

);




create or replace view pardot_analysis.opportunity_filtered as (

	select
		*
	from
		pardot_analysis.opportunity_base
  --where

);
