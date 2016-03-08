create or replace view {schema}.track as (
  select
    "timestamp"::timestamp  as "@timestamp",
    "event"                 as "@event",
    "userid"                as "@user_id",
    *

  from
    segment.track
);

comment on view {schema}.track is 'timeseries,funnel,cohort';