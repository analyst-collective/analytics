drop schema if exists segment_analysis cascade;
create schema segment_analysis;

CREATE OR REPLACE VIEW segment_analysis.track as (
  SELECT
    "timestamp"                  as "timestamp",
    "event"                      as "event_name",
    "type"                       as "event_type",

    "anonymousid"                as "anonymousid",
    "channel"                    as "channel",
    "context__library__version"  as "context__library__version"
    "context__page__path"        as "context__page__path",
    "context__page__search"      as "context__page__search",
    "context__page__title"       as "context__page__title",
    "context__page__url"         as "context__page__url",
    "event"                      as "event",
    "messageid"                  as "messageid",
    "originaltimestamp"          as "originaltimestamp",
    "projectid"                  as "projectid",
    "receivedat"                 as "receivedat",
    "sentat"                     as "sentat",
    "type"                       as "type",
    "userid"                     as "userid",
    "version"                    as "version",
  FROM
    segment.track
);

COMMENT ON VIEW segment_analysis."track" IS 'timeseries,funnel,cohort';


CREATE OR REPLACE VIEW segment_analysis."group" as (
  SELECT
    "anonymousid"                as "anonymousid",
    "channel"                    as "channel",
    "context__library__version"  as "context__library__version"
    "context__page__path"        as "context__page__path",
    "context__page__search"      as "context__page__search",
    "context__page__title"       as "context__page__title",
    "context__page__url"         as "context__page__url",
    "groupid"                    as "groupid",
    "messageid"                  as "messageid",
    "originaltimestamp"          as "originaltimestamp",
    "projectid"                  as "projectid",
    "receivedat"                 as "receivedat",
    "sentat"                     as "sentat",
    "timestamp"                  as "timestamp",
    "traits__name"               as "traits__name",
    "type"                       as "type",
    "userid"                     as "userid",
    "version"                    as "version",
  FROM
    segment."group"
);



CREATE OR REPLACE VIEW segment_analysis.identify as (
  SELECT
    "anonymousid"                as "anonymousid",
    "channel"                    as "channel",
    "context__library__version"  as "context__library__version"
    "context__page__path"        as "context__page__path",
    "context__page__search"      as "context__page__search",
    "context__page__title"       as "context__page__title",
    "context__page__url"         as "context__page__url",
    "messageid"                  as "messageid",
    "originaltimestamp"          as "originaltimestamp",
    "projectid"                  as "projectid",
    "receivedat"                 as "receivedat",
    "sentat"                     as "sentat",
    "timestamp"                  as "timestamp",
    "type"                       as "type",
    "userid"                     as "userid",
    "version"                    as "version",
  FROM
    segment.identify
);



CREATE OR REPLACE VIEW segment_analysis.page as (
  SELECT
    "timestamp"                  as "timestamp",
    "type"                       as "event_type",
    'pageview'                   as "event_name",

    "anonymousid"                as "anonymousid",
    "channel"                    as "channel",
    "context__library__version"  as "context__library__version"
    "context__page__path"        as "context__page__path",
    "context__page__search"      as "context__page__search",
    "context__page__title"       as "context__page__title",
    "context__page__url"         as "context__page__url",
    "messageid"                  as "messageid",
    "originaltimestamp"          as "originaltimestamp",
    "projectid"                  as "projectid",
    "receivedat"                 as "receivedat",
    "sentat"                     as "sentat",
    "timestamp"                  as "timestamp",
    "type"                       as "type",
    "userid"                     as "userid",
    "version"                    as "version",
  FROM
    segment.page
);

COMMENT ON VIEW segment_analysis."page" IS 'timeseries,funnel,cohort';