create or replace view {schema}.events as (
  select
    "collector_tstamp"          as "@timestamp",
    "event_name"                as "@event",
    "domain_userid"             as "@user_id",
    *
  from
    atomic.events
);

comment on view {schema}.events is 'timeseries,funnel,cohort';