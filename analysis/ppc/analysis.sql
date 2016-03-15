create or replace view {schema}.ppc_consolidated_summary as (
  (
    select 
      *
    from
      (
        select
          'Google' as "@adnetwork",
          "@campaign_name",
          "@utm_source",
          "@utm_medium",
          "@utm_campaign",
          "@utm_content",
          "@utm_term",
          "@impressions"::integer,
          "@cost"::float,
          "@date"::date,
          "@clicks"::integer,
          "@base_url"
        from
          {schema}.adwords_summary
      )
  )
  -- union if other adnetworks present. can we make this happen automatically?
  union all
    (
      select
        *
      from
      (
        select
          'Facebook' as "@adnetwork",
          "@campaign_name",
          "@utm_source",
          "@utm_medium",
          "@utm_campaign",
          "@utm_content",
          "@utm_term",
          "@impressions"::integer,
          "@cost"::float,
          "@date"::date,
          "@clicks"::integer,
          "@base_url"
        from
          {schema}.facebook_summary
      )
    )
)
