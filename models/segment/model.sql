drop schema if exists segment_analysis cascade;
create schema segment_analysis;

CREATE OR REPLACE VIEW segment_analysis.track as (
  SELECT
    "timestamp"  as "timestamp",
    "event"      as "event",
    "userid"     as "user_id",
    *

  FROM
    segment.track
);

COMMENT ON VIEW segment_analysis."track" IS 'timeseries,funnel,cohort';