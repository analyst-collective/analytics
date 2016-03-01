create or replace view pardot_analysis.visitoractivity_transformed as (
  --this table has a bunch of types that really should be event actions but are very poorly formulated.
  --the custom logic in this view is an attempt to fix that.
  --not all of the various type / type_name combinations have been accounted for yet; I still need to determine exactly what some of them mean.
  select
    -- event_stream interface
    va.created_at       as timestamp,
    t.type_decoded      as event_type,
    e.event_name        as event_name

    va.campaign_id      as campaign_id,
    va.form_handler_id  as form_handler_id,
    va.id               as id,
    va.email_id         as email_id,
    va.type_name        as type_name,
    va."type"           as "type",
    va.details          as details,
    va.created_at       as created_at,
    va.prospect_id      as prospect_id,
    va.visitor_id       as visitor_id,
    va.opportunity_id   as opportunity_id,
  from
    pardot_analysis.visitoractivity_filtered va
    inner join pardot_analysis.visitoractivity_events_meta e
      on va."type" = e."type" and va.type_name = e.type_name
    inner join pardot_analysis.visitoractivity_types_meta t
      on va."type" = t."type"
);

COMMENT ON VIEW pardot_analysis.visitoractivity_transformed IS 'timeseries,funnel,cohort';


create or replace view pardot_analysis.prospect_transformed as (

  select
    id                  as id,
    campaign_id         as campaign_id,
    salutation          as salutation,
    first_name          as first_name,
    last_name           as last_name,
    email               as email,
    company             as company,
    prospect_account_id as prospect_account_id,
    website             as website,
    job_title           as job_title,
    department          as department,
    country             as country,
    address_one         as address_one,
    address_two         as address_two,
    city                as city,
    state               as state,
    territory           as territory,
    zip                 as zip,
    phone               as phone,
    fax                 as fax,
    source              as source,
    annual_revenue      as annual_revenue,
    employees           as employees,
    industry            as industry,
    years_in_business   as years_in_business,
    comments            as comments,
    notes               as notes,
    score               as score,
    grade               as grade,
    last_activity_at    as last_activity_at,
    recent_interaction  as recent_interaction,
    crm_lead_fid        as crm_lead_fid,
    crm_contact_fid     as crm_contact_fid,
    crm_owner_fid       as crm_owner_fid,
    crm_account_fid     as crm_account_fid,
    crm_last_sync       as crm_last_sync,
    crm_url             as crm_url,
    is_do_not_email     as is_do_not_email,
    is_do_not_call      as is_do_not_call,
    opted_out           as opted_out,
    is_reviewed         as is_reviewed,
    is_starred          as is_starred,
    created_at          as created_at,
    updated_at          as updated_at
  from
    olga_pardot_analysis.prospect

);


create or replace view pardot_analysis.campaign_transformed as (

  select
    id   as id,
    cost as cost,
    name as name
  from
    olga_pardot_analysis.campaign

);


create or replace view pardot_analysis.opportunity_transformed as (

  select
    probability   as probability,
    campaign_id   as campaign_id,
    id            as id,
    name          as name,
    value         as value,
    updated_at    as updated_at,
    status        as status,
    created_at    as created_at,
    closed_at     as closed_at,
    stage         as stage,
    "type"        as "type"
  from
    olga_pardot_analysis.opportunity

);


create or replace view pardot_analysis.visit_transformed as (

  select
    duration_in_seconds         as duration_in_seconds,
    id                          as id,
    last_visitor_page_view_at   as last_visitor_page_view_at,
    updated_at                  as updated_at,
    first_visitor_page_view_at  as first_visitor_page_view_at,
    visitor_page_view_count     as visitor_page_view_count,
    created_at                  as created_at,
    visitor_id                  as visitor_id,
    content_parameter           as content_parameter,
    term_parameter              as term_parameter,
    medium_parameter            as medium_parameter,
    source_parameter            as source_parameter,
    prospect_id                 as prospect_id,
    campaign_parameter          as campaign_parameter
  from
    olga_pardot_analysis.visit

);


create or replace view pardot_analysis.visitor_transformed as (

  select
    id           as id,
    prospect_id  as prospect_id
  from
    olga_pardot_analysis.visitor_filtered

);


create or replace view pardot_analysis.visitor_pageview_transformed as (

  select
    url         as url,
    id          as id,
    visit_id    as visit_id,
    title       as title,
    created_at  as created_at,
    visitor_id  as visitor_id
  from
    pardot_analysis.visitor_pageview_filtered

);


create or replace view pardot_analysis.visitor_referrer_transformed as (

  select
    vendor        as vendor,
    referrer      as referrer,
    id            as id,
    "type"        as "type",
    visitor_id    as visitor_id,
    query         as query,
    prospect_id   as prospect_id
  from
    pardot_analysis.visitor_referrer_filtered

);
