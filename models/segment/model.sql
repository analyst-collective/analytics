CREATE OR REPLACE VIEW {schema}.track as (
  SELECT
    "timestamp"  as "@timestamp",
    "event"      as "@event",
    "userid"     as "@user_id",
    *

  FROM
    segment.track
);

COMMENT ON VIEW {schema}.track IS 'timeseries,funnel,cohort';