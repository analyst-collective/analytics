create or replace view {{ schema }}.{{ model }}_model_tests
(name, description, result)
as (
  with null_boards_or_lists as
  (
    select id
      from analyst_collective.trello_card_location
    where
	  data__board__id is null
      or data__list__id is null
  )
  select
    'no_null_boards_or_lists',
    'All location entries have a non-null board and list id',
	count(*) = 0
	from null_boards_or_lists

  union all

  select
    'fresher_than_one_day',
    'Most recent entry is no more than one day old',
	max(date::timestamp) > current_date - '1 day'::interval
	from analyst_collective.trello_card_location
);
