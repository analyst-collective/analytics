
CREATE OR REPLACE VIEW __ac_snowplow.com_snowplowanalytics_snowplow_link_click_1_filtered as (
  SELECT
    *
  FROM
    __ac_snowplow.com_snowplowanalytics_snowplow_link_click_1_base
  --WHERE
);



CREATE OR REPLACE VIEW __ac_snowplow.com_snowplowanalytics_snowplow_change_form_1_filtered as (
  SELECT
    *
  FROM
    __ac_snowplow.com_snowplowanalytics_snowplow_change_form_1_base
  --WHERE
);



CREATE OR REPLACE VIEW __ac_snowplow.com_snowplowanalytics_snowplow_submit_form_1_filtered as (
  SELECT
    *
  FROM
    __ac_snowplow.com_snowplowanalytics_snowplow_submit_form_1_base
  --WHERE
);



CREATE OR REPLACE VIEW __ac_snowplow.com_snowplowanalytics_snowplow_ua_parser_context_1_filtered as (
  SELECT
    *
  FROM
    __ac_snowplow.com_snowplowanalytics_snowplow_ua_parser_context_1_base
  --WHERE
);



CREATE OR REPLACE VIEW __ac_snowplow.events_filtered as (
  SELECT
    *
  FROM
    __ac_snowplow.events_base
  --WHERE
);