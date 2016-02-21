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




create or replace view pardot.campaign_filtered as (

	select
		*
	from
		pardot.campaign_base
  --where

);



create or replace view pardot.campaign_filtered as (

	select
		*
	from
		pardot.campaign_base
  --where

);



create or replace view pardot.visit_filtered as (

	select
		*
	from
		pardot.visit_base
  --where

);



create or replace view pardot.visitor_filtered as (

	select
		*
	from
		pardot.visitor_base
  --where

);



create or replace view pardot.visitor_pageview_filtered as (

	select
		*
	from
		pardot.visitor_pageview_base
  --where

);



create or replace view pardot.visitor_referrer_filtered as (

	select
		*
	from
		pardot.visitor_referrer_base
  --where

);
