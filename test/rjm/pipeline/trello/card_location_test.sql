select id
  from card_locations
where
  data_card_closed = true
  and data__list__id is not null; -- assertEmpty
