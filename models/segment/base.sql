drop schema if exists segment_analysis cascade;
create schema segment_analysis;

CREATE OR REPLACE VIEW segment_analysis.track_base as (
  SELECT
    "properties__target_id"               as "properties__target_id",
    "version"                             as "version",
    "properties__dashboard_id"            as "properties__dashboard_id",
    "properties__extras__dashboard_name"  as "properties__extras__dashboard_name",
    "properties__chart_name"              as "properties__chart_name",
    "properties__target_id"               as "properties__target_id",
    "properties__export_name"             as "properties__export_name",
    "originaltimestamp"                   as "originaltimestamp",
    "sentat"                              as "sentat",
    "context__useragent"                  as "context__useragent",
    "properties__dashboard_name"          as "properties__dashboard_name",
    "properties__name"                    as "properties__name",
    "projectid"                           as "projectid",
    "anonymousid"                         as "anonymousid",
    "channel"                             as "channel",
    "type"                                as "type",
    "messageid"                           as "messageid",
    "context__page__referrer"             as "context__page__referrer",
    "context__library__name"              as "context__library__name",
    "userid"                              as "userid",
    "context__page__path"                 as "context__page__path",
    "context__page__search"               as "context__page__search",
    "event"                               as "event",
    "timestamp"                           as "timestamp",
    "receivedat"                          as "receivedat",
    "context__page__url"                  as "context__page__url",
    "context__page__title"                as "context__page__title",
    "context__library__version"           as "context__library__version",
    "context__ip"                         as "context__ip"
  FROM
    segment.track
);



CREATE OR REPLACE VIEW segment_analysis.group_base as (
  SELECT
    "version"                    as "version",
    "originaltimestamp"          as "originaltimestamp",
    "sentat"                     as "sentat",
    "context__useragent"         as "context__useragent",
    "projectid"                  as "projectid",
    "anonymousid"                as "anonymousid",
    "channel"                    as "channel",
    "type"                       as "type",
    "messageid"                  as "messageid",
    "context__page__referrer"    as "context__page__referrer",
    "context__library__name"     as "context__library__name",
    "traits__name"               as "traits__name",
    "userid"                     as "userid",
    "context__page__path"        as "context__page__path",
    "context__page__search"      as "context__page__search",
    "timestamp"                  as "timestamp",
    "receivedat"                 as "receivedat",
    "context__page__url"         as "context__page__url",
    "context__page__title"       as "context__page__title",
    "context__library__version"  as "context__library__version",
    "context__ip"                as "context__ip",
    "groupid"                    as "groupid"
  FROM
    segment.group
);



CREATE OR REPLACE VIEW segment_analysis.identify_base as (
  SELECT
    "version"                    as "version",
    "traits__widget__activator"  as "traits__widget__activator",
    "traits__created"            as "traits__created",
    "originaltimestamp"          as "originaltimestamp",
    "sentat"                     as "sentat",
    "context__useragent"         as "context__useragent",
    "projectid"                  as "projectid",
    "anonymousid"                as "anonymousid",
    "channel"                    as "channel",
    "traits__user_hash"          as "traits__user_hash",
    "traits__email"              as "traits__email",
    "traits__is_readonly"        as "traits__is_readonly",
    "type"                       as "type",
    "messageid"                  as "messageid",
    "context__page__referrer"    as "context__page__referrer",
    "context__library__name"     as "context__library__name",
    "traits__client_id"          as "traits__client_id",
    "traits__name"               as "traits__name",
    "userid"                     as "userid",
    "traits__batcheetahflag"     as "traits__batcheetahflag",
    "context__page__path"        as "context__page__path",
    "context__page__search"      as "context__page__search",
    "timestamp"                  as "timestamp",
    "receivedat"                 as "receivedat",
    "traits__templogin"          as "traits__templogin",
    "traits__is_admin"           as "traits__is_admin",
    "traits__app_id"             as "traits__app_id",
    "context__page__url"         as "context__page__url",
    "context__page__title"       as "context__page__title",
    "traits__user_id"            as "traits__user_id",
    "context__library__version"  as "context__library__version",
    "context__ip"                as "context__ip",
    "traits__demouserflag"       as "traits__demouserflag"
  FROM
    segment.identify
);



CREATE OR REPLACE VIEW segment_analysis.page_base as (
  SELECT
    "version"                    as "version",
    "originaltimestamp"          as "originaltimestamp",
    "sentat"                     as "sentat",
    "context__useragent"         as "context__useragent",
    "projectid"                  as "projectid",
    "anonymousid"                as "anonymousid",
    "channel"                    as "channel",
    "properties__search"         as "properties__search",
    "type"                       as "type",
    "messageid"                  as "messageid",
    "context__page__referrer"    as "context__page__referrer",
    "context__library__name"     as "context__library__name",
    "properties__path"           as "properties__path",
    "userid"                     as "userid",
    "properties__url"            as "properties__url",
    "context__page__path"        as "context__page__path",
    "context__page__search"      as "context__page__search",
    "properties__title"          as "properties__title",
    "timestamp"                  as "timestamp",
    "receivedat"                 as "receivedat",
    "properties__referrer"       as "properties__referrer",
    "context__page__url"         as "context__page__url",
    "context__page__title"       as "context__page__title",
    "context__library__version"  as "context__library__version",
    "context__ip"                as "context__ip"
  FROM
    segment.page
);