drop schema if exists trello cascade;
create schema trello;

create or replace view trello.cards_base as (

	select
		id,
		idlist,
		idboard,
		idshort,
		name,
		datelastactivity::timestamp as datelastactivity,
		due::timestamp as due,
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
		data__board__id as idboard,
		data__list__id as idlist,
		data__card__id as idcard,
		date::timestamp as date,
		"type"
	from trello_growth.trello_actions

);
