create or replace view pardot_analysis.visitor_activity_filtered as (

  select
    *
  from
    pardot_analysis.visitor_activity_base
  --where

);



create or replace view pardot_analysis.prospect_filtered as (

  select
    *
  from
    pardot_analysis.prospect_base
  --where

);




create or replace view pardot_analysis.campaign_filtered as (

  select
    *
  from
    pardot_analysis.campaign_base
  --where

);



create or replace view pardot_analysis.campaign_filtered as (

  select
    *
  from
    pardot_analysis.campaign_base
  --where

);



create or replace view pardot_analysis.visit_filtered as (

  select
    *
  from
    pardot_analysis.visit_base
  --where

);



create or replace view pardot_analysis.visitor_filtered as (

  select
    *
  from
    pardot_analysis.visitor_base
  --where

);



create or replace view pardot_analysis.visitor_pageview_filtered as (

  select
    *
  from
    pardot_analysis.visitor_pageview_base
  --where

);



create or replace view pardot_analysis.visitor_referrer_filtered as (

  select
    *
  from
    pardot_analysis.visitor_referrer_base
  --where

);
