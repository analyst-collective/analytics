create or replace view {schema}.adwords_summary as (
  with ad_data as
    (
    select 
      lower(addestinationurl) as cleanurl,
      * 
    from 
      adwords.adwords12218869_v2 -- How do I make this work regardless of the extension?
    )
  select 
    REPLACE(REGEXP_SUBSTR(cleanurl,'utm_source=[^&]*'),'utm_source=','') as "@utm_source",
    REPLACE(REGEXP_SUBSTR(cleanurl,'utm_medium=[^&]*'),'utm_medium=','') as "@utm_medium",
    REPLACE(REGEXP_SUBSTR(cleanurl,'utm_campaign=[^&]*'),'utm_campaign=','') as "@utm_campaign",
    REPLACE(REGEXP_SUBSTR(cleanurl,'utm_content=[^&]*'),'utm_content=','') as "@utm_content",
    REPLACE(REGEXP_SUBSTR(cleanurl,'utm_term=[^&]*'),'utm_term=','') as "@utm_term",
    campaign as "@campaign_name"
    impressions::integer as "@impressions",
    adcost::float as "@cost",
    date::date as "@date",
    adclicks::integer as "@clicks",
    SPLIT_PART(cleanurl,'?',1) as "@base_url",
    SPLIT_PART(cleanurl,'?',2) as querystring,
    *
  from 
    ad_data
  )
