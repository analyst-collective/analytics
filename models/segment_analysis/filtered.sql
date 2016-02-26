
CREATE OR REPLACE VIEW segment_analysis.track_filtered as (
  SELECT
    *
  FROM
    segment_analysis.track_base
  --WHERE
);



CREATE OR REPLACE VIEW segment_analysis.group_filtered as (
  SELECT
    *
  FROM
    segment_analysis.group_base
  --WHERE
);



CREATE OR REPLACE VIEW segment_analysis.identify_filtered as (
  SELECT
    *
  FROM
    segment_analysis.identify_base
  --WHERE
);



CREATE OR REPLACE VIEW segment_analysis.page_filtered as (
  SELECT
    *
  FROM
    segment_analysis.page_base
  --WHERE
);