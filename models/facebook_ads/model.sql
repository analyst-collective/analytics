create or replace view ac_hhund.facebook_ads_summary as (
  with ad_data as
    (
    select
      ag.name as "adgroup_name",
      lower(nvl(object_url,link_url,object_story_spec__link_data__link)) as addestinationurl,
      i.*
    from
      facebook.facebook_insights_101441173373823 i
      join
        facebook.facebook_adgroup_101441173373823 ag
      on
        ag.id = i.adgroup_id
      join
        facebook.facebook_adcreative_101441173373823 ac
      on 
        ag.creative__id = ac.id
    )
  select 
    REPLACE(REGEXP_SUBSTR(addestinationurl,'utm_source=[^&]*'),'utm_source=','') as "@utm_source",
    REPLACE(REGEXP_SUBSTR(addestinationurl,'utm_medium=[^&]*'),'utm_medium=','') as "@utm_medium",
    REPLACE(REGEXP_SUBSTR(addestinationurl,'utm_campaign=[^&]*'),'utm_campaign=','') as "@utm_campaign",
    REPLACE(REGEXP_SUBSTR(addestinationurl,'utm_content=[^&]*'),'utm_content=','') as "@utm_content",
    REPLACE(REGEXP_SUBSTR(addestinationurl,'utm_term=[^&]*'),'utm_term=','') as "@utm_term",
    adgroup_name as "@campaign_name",
    impressions::integer as "@impressions",
    spend::float as "@cost",
    date_start::date as "@date",
    clicks::integer as "@clicks",
    SPLIT_PART(addestinationurl,'?',1) as "@base_url",
    SPLIT_PART(addestinationurl,'?',2) as querystring,
    *
  from 
    ad_data
  )
