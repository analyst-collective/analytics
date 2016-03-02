CREATE OR REPLACE VIEW {schema}.events as (
  SELECT
    "collector_tstamp"          as "@timestamp",
    "event"                     as "@event",
    "domain_userid"             as "@user_id",
    *
  FROM
    atomic.events
);

COMMENT ON VIEW {schema}.event IS 'timeseries,funnel,cohort';