create or replace view {{env.schema}}.snowplow_events as (
  select
    "collector_tstamp"          as "@timestamp",
    "event_name"                as "@event",
    "domain_userid"             as "@user_id",
    *
  from
    atomic.events
);

comment on view {{env.schema}}.snowplow_events is 'timeseries,funnel,cohort';
