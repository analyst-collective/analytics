create or replace view trello.cards as (

	select
		c.id,
		c.data__board__id as idboard,
		c.data__list__id as idlist,
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
			created_action.cardid = c.id
			and created_action.cardid is not null
			and created_action.type = 'createCard'

);
