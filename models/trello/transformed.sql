create or replace view trello.cards as (

	select
		c.id,
		c.idlist,
		c.idboard,
		c.idshort,
		c.name,
		c.datelastactivity,
		c.due,
		c.closed,
		created_action.date as created_at
	from
		trello.cards_base c
  join
		trello.actions_base created_action
		on
			created_action.cardid = c.id
			and created_action.cardid is not null
			and created_action.type = 'createCard'

);
