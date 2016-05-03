with null_boards_or_lists as
(
  select id
    from {{load('trello_card_location')}}
  where
  data__board__id is null
    or data__list__id is null
)
select
  'no_null_boards_or_lists' as name,
  'All location entries have a non-null board and list id' as description,
count(*) = 0 as result
from null_boards_or_lists

union all

select
  'fresher_than_one_day',
  'Most recent entry is no more than one day old',
max(date::timestamp) > current_date - '1 day'::interval
from {{load('trello_card_location')}}
