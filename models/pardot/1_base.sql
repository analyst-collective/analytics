drop schema if exists pardot_analysis cascade;
create schema pardot_analysis;


create or replace view pardot_analysis.visitor_activity_base as (

  select
    campaign_id        as campaign_id,
    form_handler_id    as form_handler_id,
    id                 as id,
    email_id           as email_id,
    type_name          as type_name,
    "type"             as "type",
    details            as details,
    created_at         as created_at,
    prospect_id        as prospect_id,
    visitor_id         as visitor_id,
    opportunity_id     as opportunity_id
  from
    olga_pardot_analysis.visitoractivity

);


create or replace view pardot_analysis.prospect_base as (

  select
    id                   as id,
    campaign_id          as campaign_id,
    salutation           as salutation,
    first_name           as first_name,
    last_name            as last_name,
    email                as email,
    company              as company,
    prospect_account_id  as prospect_account_id,
    website              as website,
    job_title            as job_title,
    department           as department,
    country              as country,
    address_one          as address_one,
    address_two          as address_two,
    city                 as city,
    state                as state,
    territory            as territory,
    zip                  as zip,
    phone                as phone,
    fax                  as fax,
    source               as source,
    annual_revenue       as annual_revenue,
    employees            as employees,
    industry             as industry,
    years_in_business    as years_in_business,
    comments             as comments,
    notes                as notes,
    score                as score,
    grade                as grade,
    last_activity_at     as last_activity_at,
    recent_interaction   as recent_interaction,
    crm_lead_fid         as crm_lead_fid,
    crm_contact_fid      as crm_contact_fid,
    crm_owner_fid        as crm_owner_fid,
    crm_account_fid      as crm_account_fid,
    crm_last_sync        as crm_last_sync,
    crm_url              as crm_url,
    is_do_not_email      as is_do_not_email,
    is_do_not_call       as is_do_not_call,
    opted_out            as opted_out,
    is_reviewed          as is_reviewed,
    is_starred           as is_starred,
    created_at           as created_at,
    updated_at           as updated_at
  from
    olga_pardot_analysis.prospect

);


create or replace view pardot_analysis.campaign_base as (

  select
    id    as id,
    cost  as cost,
    name  as name
  from
    olga_pardot_analysis.campaign

);


create or replace view pardot_analysis.opportunity_base as (

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


create or replace view pardot_analysis.visit_base as (

  select
    duration_in_seconds        as duration_in_seconds,
    id                         as id,
    last_visitor_page_view_at  as last_visitor_page_view_at,
    updated_at                 as updated_at,
    first_visitor_page_view_at as first_visitor_page_view_at,
    visitor_page_view_count    as visitor_page_view_count,
    created_at                 as created_at,
    visitor_id                 as visitor_id,
    content_parameter          as content_parameter,
    term_parameter             as term_parameter,
    medium_parameter           as medium_parameter,
    source_parameter           as source_parameter,
    prospect_id                as prospect_id,
    campaign_parameter         as campaign_parameter
  from
    olga_pardot_analysis.visit

);


create or replace view pardot_analysis.visitor_base as (

  select
    id           as id,
    prospect_id  as prospect_id
  from
    olga_pardot_analysis.visitor

);


create or replace view pardot_analysis.visitor_pageview_base as (

  select
    url         as url,
    id          as id,
    visit_id    as visit_id,
    title       as title,
    created_at  as created_at,
    visitor_id  as visitor_id
  from
    olga_pardot_analysis.visitorpageview

);


create or replace view pardot_analysis.visitor_referrer_base as (

  select
    vendor       as vendor,
    referrer     as referrer,
    id           as id,
    "type"       as "type",
    visitor_id   as visitor_id,
    query        as query,
    prospect_id  as prospect_id
  from
    olga_pardot_analysis.visitorreferrer

);
