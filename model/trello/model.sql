create or replace view {{env.schema}}.trello_card_location as (
  select
    id,
    idmembercreator,
    date,
    "type",
    data__card__id,
    data__card__name,
    coalesce(data__list__id,
	  data__listafter__id,
	  lag(coalesce(data__list__id, data__listafter__id)) ignore nulls over (partition by data__card__id order by date)) as data__list__id,
    coalesce(data__boardtarget__id, data__board__id) as data__board__id,
    coalesce(data__card__closed,
      lag(data__card__closed) ignore nulls over (partition by data__card__id order by date),
	  false) as data__card__closed
  from trello_growth.trello_actions
  where
    data__card__id is not null
    and "type" in ('createCard', 'updateCard', 'moveCardFromBoard', 'moveCardToBoard', 'commentCard')
);
