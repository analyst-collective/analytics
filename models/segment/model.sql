create or replace view {{env.schema}}.segment_track as (
  select
    "timestamp"::timestamp  as "@timestamp",
    "event"                 as "@event",
    "userid"                as "@user_id",
    *

  from
    segment.track
);

comment on view {{env.schema}}.segment_track is 'timeseries,funnel,cohort';
