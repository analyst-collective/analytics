drop schema if exists snowplow_analysis cascade;
create schema snowplow_analysis;


/*
CREATE OR REPLACE VIEW snowplow_analysis.link_click as (
  SELECT
    "root_id"          as "root_id",
    "target_url"       as "target_url",
    "element_target"   as "element_target",
    "element_classes"  as "element_classes",
    "element_id"       as "element_id",
    "ref_parent"       as "ref_parent",
    "ref_tree"         as "ref_tree",
    "ref_root"         as "ref_root",
    "schema_version"   as "schema_version",
    "schema_format"    as "schema_format",
    "schema_name"      as "schema_name",
    "schema_vendor"    as "schema_vendor",
    "root_tstamp"      as "root_tstamp"
  FROM
    atomic.com_snowplowanalytics_snowplow_link_click_1
);

COMMENT ON TABLE snowplow_analysis.link_click IS 'timeseries,funnel,cohort';


CREATE OR REPLACE VIEW snowplow_analysis.change_form as (
  SELECT
    "root_id"          as "root_id",
    "value"            as "value",
    "element_classes"  as "element_classes",
    "type"             as "type",
    "node_name"        as "node_name",
    "element_id"       as "element_id",
    "form_id"          as "form_id",
    "ref_parent"       as "ref_parent",
    "ref_tree"         as "ref_tree",
    "ref_root"         as "ref_root",
    "schema_version"   as "schema_version",
    "schema_format"    as "schema_format",
    "schema_name"      as "schema_name",
    "schema_vendor"    as "schema_vendor",
    "root_tstamp"      as "root_tstamp"
  FROM
    atomic.com_snowplowanalytics_snowplow_change_form_1
);

COMMENT ON TABLE snowplow_analysis.change_form IS 'timeseries,funnel,cohort';


CREATE OR REPLACE VIEW snowplow_analysis.submit_form as (
  SELECT
    "root_id"         as "root_id",
    "elements"        as "elements",
    "form_classes"    as "form_classes",
    "form_id"         as "form_id",
    "ref_parent"      as "ref_parent",
    "ref_tree"        as "ref_tree",
    "ref_root"        as "ref_root",
    "schema_version"  as "schema_version",
    "schema_format"   as "schema_format",
    "schema_name"     as "schema_name",
    "schema_vendor"   as "schema_vendor",
    "root_tstamp"     as "root_tstamp"
  FROM
    atomic.com_snowplowanalytics_snowplow_submit_form_1
);

COMMENT ON TABLE snowplow_analysis.submit_form IS 'timeseries,funnel,cohort';
*/


CREATE OR REPLACE VIEW snowplow_analysis.events as (
  SELECT
    "collector_tstamp"          as "timestamp",
    "event"                     as "event_name",
    "event_name"                as "event_type",

    "dvce_ismobile"             as "dvce_ismobile",
    "br_cookies"                as "br_cookies",
    "br_features_silverlight"   as "br_features_silverlight",
    "br_features_gears"         as "br_features_gears",
    "br_features_windowsmedia"  as "br_features_windowsmedia",
    "br_features_realplayer"    as "br_features_realplayer",
    "br_features_quicktime"     as "br_features_quicktime",
    "br_features_director"      as "br_features_director",
    "br_features_java"          as "br_features_java",
    "br_features_flash"         as "br_features_flash",
    "br_features_pdf"           as "br_features_pdf",
    "domain_sessionidx"         as "domain_sessionidx",
    "doc_height"                as "doc_height",
    "doc_width"                 as "doc_width",
    "dvce_screenheight"         as "dvce_screenheight",
    "dvce_screenwidth"          as "dvce_screenwidth",
    "br_viewheight"             as "br_viewheight",
    "br_viewwidth"              as "br_viewwidth",
    "pp_yoffset_max"            as "pp_yoffset_max",
    "pp_yoffset_min"            as "pp_yoffset_min",
    "pp_xoffset_max"            as "pp_xoffset_max",
    "pp_xoffset_min"            as "pp_xoffset_min",
    "ti_quantity"               as "ti_quantity",
    "refr_urlport"              as "refr_urlport",
    "page_urlport"              as "page_urlport",
    "txn_id"                    as "txn_id",
    "se_value"                  as "se_value",
    "geo_longitude"             as "geo_longitude",
    "geo_latitude"              as "geo_latitude",
    "domain_sessionid"          as "domain_sessionid",
    "base_currency"             as "base_currency",
    "ti_currency"               as "ti_currency",
    "tr_currency"               as "tr_currency",
    "geo_region"                as "geo_region",
    "geo_country"               as "geo_country",
    "event_id"                  as "event_id",
    "event_fingerprint"         as "event_fingerprint",
    "event_version"             as "event_version",
    "event_format"              as "event_format",
    "event_name"                as "event_name",
    "event_vendor"              as "event_vendor",
    "refr_domain_userid"        as "refr_domain_userid",
    "etl_tags"                  as "etl_tags",
    "mkt_network"               as "mkt_network",
    "mkt_clickid"               as "mkt_clickid",
    "geo_timezone"              as "geo_timezone",
    "doc_charset"               as "doc_charset",
    "dvce_type"                 as "dvce_type",
    "os_timezone"               as "os_timezone",
    "os_manufacturer"           as "os_manufacturer",
    "os_family"                 as "os_family",
    "os_name"                   as "os_name",
    "br_colordepth"             as "br_colordepth",
    "br_lang"                   as "br_lang",
    "br_renderengine"           as "br_renderengine",
    "br_type"                   as "br_type",
    "br_version"                as "br_version",
    "br_family"                 as "br_family",
    "br_name"                   as "br_name",
    "useragent"                 as "useragent",
    "ti_category"               as "ti_category",
    "ti_name"                   as "ti_name",
    "ti_sku"                    as "ti_sku",
    "ti_orderid"                as "ti_orderid",
    "tr_country"                as "tr_country",
    "tr_state"                  as "tr_state",
    "tr_city"                   as "tr_city",
    "tr_affiliation"            as "tr_affiliation",
    "tr_orderid"                as "tr_orderid",
    "se_property"               as "se_property",
    "se_label"                  as "se_label",
    "se_action"                 as "se_action",
    "se_category"               as "se_category",
    "mkt_campaign"              as "mkt_campaign",
    "mkt_content"               as "mkt_content",
    "mkt_term"                  as "mkt_term",
    "mkt_source"                as "mkt_source",
    "mkt_medium"                as "mkt_medium",
    "refr_term"                 as "refr_term",
    "refr_source"               as "refr_source",
    "refr_medium"               as "refr_medium",
    "refr_urlfragment"          as "refr_urlfragment",
    "refr_urlquery"             as "refr_urlquery",
    "refr_urlpath"              as "refr_urlpath",
    "refr_urlhost"              as "refr_urlhost",
    "refr_urlscheme"            as "refr_urlscheme",
    "page_urlfragment"          as "page_urlfragment",
    "page_urlquery"             as "page_urlquery",
    "page_urlpath"              as "page_urlpath",
    "page_urlhost"              as "page_urlhost",
    "page_urlscheme"            as "page_urlscheme",
    "page_referrer"             as "page_referrer",
    "page_title"                as "page_title",
    "page_url"                  as "page_url",
    "ip_netspeed"               as "ip_netspeed",
    "ip_domain"                 as "ip_domain",
    "ip_organization"           as "ip_organization",
    "ip_isp"                    as "ip_isp",
    "geo_region_name"           as "geo_region_name",
    "geo_zipcode"               as "geo_zipcode",
    "geo_city"                  as "geo_city",
    "network_userid"            as "network_userid",
    "domain_userid"             as "domain_userid",
    "user_fingerprint"          as "user_fingerprint",
    "user_ipaddress"            as "user_ipaddress",
    "user_id"                   as "user_id",
    "v_etl"                     as "v_etl",
    "v_collector"               as "v_collector",
    "v_tracker"                 as "v_tracker",
    "name_tracker"              as "name_tracker",
    "event"                     as "event",
    "platform"                  as "platform",
    "app_id"                    as "app_id",
    "true_tstamp"               as "true_tstamp",
    "derived_tstamp"            as "derived_tstamp",
    "refr_dvce_tstamp"          as "refr_dvce_tstamp",
    "dvce_sent_tstamp"          as "dvce_sent_tstamp",
    "dvce_created_tstamp"       as "dvce_created_tstamp",
    "collector_tstamp"          as "collector_tstamp",
    "etl_tstamp"                as "etl_tstamp",
    "ti_price_base"             as "ti_price_base",
    "tr_shipping_base"          as "tr_shipping_base",
    "tr_tax_base"               as "tr_tax_base",
    "tr_total_base"             as "tr_total_base",
    "ti_price"                  as "ti_price",
    "tr_shipping"               as "tr_shipping",
    "tr_tax"                    as "tr_tax",
    "tr_total"                  as "tr_total"
  FROM
    atomic.events
);

COMMENT ON TABLE snowplow_analysis.event IS 'timeseries,funnel,cohort';