create table trello_cards
(
	id varchar(255),
	idboard varchar(255),
	idlist varchar(255),
	idshort bigint,
	"name" varchar(255),
	"desc" varchar(255),
	closed boolean,
	datelastactivity varchar(255)
);

create table trello_lists
(
	id varchar(255),
	idboard varchar(255),
	name varchar(255),
	closed boolean
);

create table trello_actions
(
	id varchar(255),
	idmembercreator varchar(255),
	membercreator__username varchar(255),
	membercreator__id varchar(255),
	membercreator__avatarhash varchar(255),
	membercreator__fullname varchar(255),
	data__board__name varchar(255),
	data__board__shortlink varchar(255),
	data__board__id varchar(255),
	data__card__id varchar(255),
	data__card__idshort bigint,
	data__card__closed boolean,
	data__card__name varchar(255),
	data__card__idlist varchar(255),
	data__card__shortlink varchar(255),
	data__list__id varchar(255),
	data__list__name varchar(255),
	data__listbefore__id varchar(255),
	data__listbefore__name varchar(255),
	data__listafter__id varchar(255),
	data__listafter__name varchar(255),
	data__old__closed boolean,
	date varchar(255),
	"type" varchar(255)
);
