create or replace view v_pardot_visitor_activity as (

  select
      campaign_id         as campaign_id
      form_handler_id     as form_handler_id
      id                  as id
      type_name           as type_name
      type                as type
      details             as details
      created_at          as created_at
      prospect_id         as prospect_id
      visitor_id          as visitor_id
      opportunity_id      as opportunity_id
  from
    olga_pardot.visitoractivity

)
