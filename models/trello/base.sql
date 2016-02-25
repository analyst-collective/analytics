drop schema if exists trello cascade;
create schema trello;

create or replace view trello.cards_base as (

	select
		id,
		idlist,
		idboard,
		idshort,
		name,
		datelastactivity,
		due,
		closed
	from
		trello_growth.trello_cards

);

create or replace view trello.lists_base as (

	select
		id,
		idboard,
		name,
		closed
	from
		trello_growth.trello_lists

);

create or replace view trello.actions_base as (

	select
		id,
		idmembercreator,
		data__board__id,
		data__list__id,
		data__card__id,
		date,
		"type"
	from trello_growth.trello_actions

);
