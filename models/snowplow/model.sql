drop schema if exists snowplow_analysis cascade;
create schema snowplow_analysis;

CREATE OR REPLACE VIEW snowplow_analysis.events as (
  SELECT
    "collector_tstamp"          as "timestamp",
    "event"                     as "event",
    "domain_userid"             as "user_id",
    *
  FROM
    atomic.events
);

COMMENT ON VIEW snowplow_analysis.event IS 'timeseries,funnel,cohort';