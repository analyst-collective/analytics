drop schema if exists pardot cascade;
create schema pardot;



create or replace view pardot.campaigns as (

  select
    id                  as id,
    cost                as cost,
    name                as name
  from
    olga_pardot.campaign

);



create or replace view pardot.opportunities as (

  select
    probability         as probability,
    campaign_id         as campaign_id,
    id                  as id,
    name                as name,
    value               as value,
    updated_at          as updated_at,
    status              as status,
    created_at          as created_at,
    closed_at           as closed_at,
    stage               as stage,
    type                as type
  from
    olga_pardot.opportunity

);




create or replace view pardot.visits as (

  select
    duration_in_seconds             as duration_in_seconds,
    id                              as id,
    last_visitor_page_view_at       as last_visitor_page_view_at,
    updated_at                      as updated_at,
    first_visitor_page_view_at      as first_visitor_page_view_at,
    visitor_page_view_count         as visitor_page_view_count,
    created_at                      as created_at,
    visitor_id                      as visitor_id,
    content_parameter               as content_parameter,
    term_parameter                  as term_parameter,
    medium_parameter                as medium_parameter,
    source_parameter                as source_parameter,
    prospect_id                     as prospect_id,
    campaign_parameter              as campaign_parameter
  from
    olga_pardot.visit

);




create or replace view pardot.visitors as (

  select
    id                              as id,
    prospect_id                     as prospect_id
  from
    olga_pardot.visitor

);



create or replace view pardot.visitor_activities as (

  select
    campaign_id         as campaign_id,
    form_handler_id     as form_handler_id,
    id                  as id,
    type_name           as type_name,
    type                as type,
    details             as details,
    created_at          as created_at,
    prospect_id         as prospect_id,
    visitor_id          as visitor_id,
    opportunity_id      as opportunity_id
  from
    olga_pardot.visitoractivity

);




create or replace view pardot.visitor_pageviews as (

  select
    url                 as url,
    id                  as id,
    visit_id            as visit_id,
    title               as title,
    created_at          as created_at,
    visitor_id          as visitor_id
  from
    olga_pardot.visitorpageview

);



create or replace view pardot.visitor_referrers as (

  select
    vendor                as vendor,
    referrer              as referrer,
    id                    as id,
    type                  as type,
    visitor_id            as visitor_id,
    query                 as query,
    prospect_id           as prospect_id
  from
    olga_pardot.visitorreferrer

);
