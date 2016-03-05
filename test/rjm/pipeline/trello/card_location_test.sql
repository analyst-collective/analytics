select id
  from analyst_collective.trello_card_location
where
  data__card__closed = true
  and data__list__id is not null; -- assertEmpty
