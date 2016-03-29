create or replace view {{env.schema}}.pardot_model_tests
 (name, description, result)
 as (

   select
     'visitoractivity_fresher_than_one_day',
     'Most recent visitoractivity entry is no more than one day old',
 	max("@timestamp"::timestamp) > current_date - '1 day'::interval
 	from {{env.schema}}.pardot_visitoractivity

 );







 /*

Other tests I want to do:
 - make sure there are records from every day since the first day we see any records
 - make sure all prospect ids from visitoractivity show up in prospects
 - make sure there are no unmapped types

 */
