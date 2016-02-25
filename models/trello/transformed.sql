create or replace view trello.cards as (

	select
		c.id,
		c.idboard,
		c.idlist,
		c.idshort,
		c.name,
		c.datelastactivity::timestamp as datelastactivity,
		c.due::timestamp as due,
		c.closed,
		created_action.date::timestamp as created_at
	from
		trello.cards_base c
  join
		trello.actions_base created_action
		on
			created_action.data__card__id = c.id
			and created_action.data__card__id is not null
			and created_action.type = 'createCard'

);
