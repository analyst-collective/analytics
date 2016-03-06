CREATE OR REPLACE VIEW {{ schema }}.{{ model }}_track as (
  SELECT
    "timestamp"::timestamp  as "@timestamp",
    "event"                 as "@event",
    "userid"                as "@user_id",
    *

  FROM
    segment.track
);

COMMENT ON VIEW {{ schema }}.{{ model }}_track IS 'timeseries,funnel,cohort';
