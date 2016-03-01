
CREATE OR REPLACE VIEW snowplow_analysis.com_snowplowanalytics_snowplow_desktop_context_1_base as (
  SELECT
    "os_is_64_bit"            as "os_is_64_bit",
    "device_processor_count"  as "device_processor_count",
    "root_id"                 as "root_id",
    "device_model"            as "device_model",
    "device_manufacturer"     as "device_manufacturer",
    "os_service_pack"         as "os_service_pack",
    "os_version"              as "os_version",
    "os_type"                 as "os_type",
    "ref_parent"              as "ref_parent",
    "ref_tree"                as "ref_tree",
    "ref_root"                as "ref_root",
    "schema_version"          as "schema_version",
    "schema_format"           as "schema_format",
    "schema_name"             as "schema_name",
    "schema_vendor"           as "schema_vendor",
    "root_tstamp"             as "root_tstamp"
  FROM
    atomic.com_snowplowanalytics_snowplow_desktop_context_1
);



CREATE OR REPLACE VIEW snowplow_analysis.maxmind_ip_isp_base as (
  SELECT
    "ip_stop"   as "ip_stop",
    "ip_start"  as "ip_start",
    "key"       as "key",
    "isp_name"  as "isp_name"
  FROM
    atomic.maxmind_ip_isp
);



CREATE OR REPLACE VIEW snowplow_analysis.com_snowplowanalytics_snowplow_geolocation_context_1_base as (
  SELECT
    "speed"                        as "speed",
    "bearing"                      as "bearing",
    "altitude_accuracy"            as "altitude_accuracy",
    "altitude"                     as "altitude",
    "latitude_longitude_accuracy"  as "latitude_longitude_accuracy",
    "longitude"                    as "longitude",
    "latitude"                     as "latitude",
    "root_id"                      as "root_id",
    "ref_parent"                   as "ref_parent",
    "ref_tree"                     as "ref_tree",
    "ref_root"                     as "ref_root",
    "schema_version"               as "schema_version",
    "schema_format"                as "schema_format",
    "schema_name"                  as "schema_name",
    "schema_vendor"                as "schema_vendor",
    "root_tstamp"                  as "root_tstamp"
  FROM
    atomic.com_snowplowanalytics_snowplow_geolocation_context_1
);



CREATE OR REPLACE VIEW snowplow_analysis.maxmind_isp_names_recaptured_by_yev_base as (
  SELECT
    "isp_name"  as "isp_name"
  FROM
    atomic.maxmind_isp_names_recaptured_by_yev
);



CREATE OR REPLACE VIEW snowplow_analysis.com_snowplowanalytics_snowplow_link_click_1_base as (
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



CREATE OR REPLACE VIEW snowplow_analysis.visitors_with_company_name_base as (
  SELECT
    "user_ipaddress_int"  as "user_ipaddress_int",
    "lower_company_name"  as "lower_company_name",
    "company_name"        as "company_name",
    "user_ipaddress"      as "user_ipaddress",
    "visitor_id"          as "visitor_id",
    "last_visit_date"     as "last_visit_date",
    "first_visit_date"    as "first_visit_date"
  FROM
    atomic.visitors_with_company_name
);



CREATE OR REPLACE VIEW snowplow_analysis.events_hackathon_base as (
  SELECT
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
    "derived_contexts"          as "derived_contexts",
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
    "unstruct_event"            as "unstruct_event",
    "se_property"               as "se_property",
    "se_label"                  as "se_label",
    "se_action"                 as "se_action",
    "se_category"               as "se_category",
    "contexts"                  as "contexts",
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
    "derived_tstamp"            as "derived_tstamp",
    "refr_dvce_tstamp"          as "refr_dvce_tstamp",
    "dvce_sent_tstamp"          as "dvce_sent_tstamp",
    "dvce_tstamp"               as "dvce_tstamp",
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
    atomic.events_hackathon
);



CREATE OR REPLACE VIEW snowplow_analysis.com_snowplowanalytics_snowplow_change_form_1_base as (
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



CREATE OR REPLACE VIEW snowplow_analysis.maxmind_investors_lower_names_base as (
  SELECT
    "lower_company_name"  as "lower_company_name"
  FROM
    atomic.maxmind_investors_lower_names
);



CREATE OR REPLACE VIEW snowplow_analysis.com_snowplowanalytics_snowplow_submit_form_1_base as (
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



CREATE OR REPLACE VIEW snowplow_analysis.maxmind_ip_org_base as (
  SELECT
    "ip_stop"   as "ip_stop",
    "ip_start"  as "ip_start",
    "key"       as "key",
    "org_name"  as "org_name"
  FROM
    atomic.maxmind_ip_org
);



CREATE OR REPLACE VIEW snowplow_analysis.com_snowplowanalytics_snowplow_add_to_cart_1_base as (
  SELECT
    "quantity"        as "quantity",
    "root_id"         as "root_id",
    "currency"        as "currency",
    "category"        as "category",
    "name"            as "name",
    "sku"             as "sku",
    "ref_parent"      as "ref_parent",
    "ref_tree"        as "ref_tree",
    "ref_root"        as "ref_root",
    "schema_version"  as "schema_version",
    "schema_format"   as "schema_format",
    "schema_name"     as "schema_name",
    "schema_vendor"   as "schema_vendor",
    "root_tstamp"     as "root_tstamp",
    "unit_price"      as "unit_price"
  FROM
    atomic.com_snowplowanalytics_snowplow_add_to_cart_1
);



CREATE OR REPLACE VIEW snowplow_analysis.maxmind_ip_org_distinct_lower_names_base as (
  SELECT
    "org_name"  as "org_name"
  FROM
    atomic.maxmind_ip_org_distinct_lower_names
);



CREATE OR REPLACE VIEW snowplow_analysis.replay_events_base as (
  SELECT
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
    "derived_contexts"          as "derived_contexts",
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
    "unstruct_event"            as "unstruct_event",
    "se_property"               as "se_property",
    "se_label"                  as "se_label",
    "se_action"                 as "se_action",
    "se_category"               as "se_category",
    "contexts"                  as "contexts",
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
    "derived_tstamp"            as "derived_tstamp",
    "refr_dvce_tstamp"          as "refr_dvce_tstamp",
    "dvce_sent_tstamp"          as "dvce_sent_tstamp",
    "dvce_tstamp"               as "dvce_tstamp",
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
    atomic.replay_events
);



CREATE OR REPLACE VIEW snowplow_analysis.maxmind_ip_isp_distinct_lower_names_base as (
  SELECT
    "isp_name"  as "isp_name"
  FROM
    atomic.maxmind_ip_isp_distinct_lower_names
);



CREATE OR REPLACE VIEW snowplow_analysis.events_of_visitors_with_legit_company_names_base as (
  SELECT
    "user_ipaddress_int"        as "user_ipaddress_int",
    "event_id"                  as "event_id",
    "page_referrer"             as "page_referrer",
    "page_title"                as "page_title",
    "page_url"                  as "page_url",
    "event"                     as "event",
    "company_category"          as "company_category",
    "company_name"              as "company_name",
    "user_ipaddress"            as "user_ipaddress",
    "sf_account_name"           as "sf_account_name",
    "account_id"                as "account_id",
    "visitor_id"                as "visitor_id",
    "last_visit_date"           as "last_visit_date",
    "first_visit_date"          as "first_visit_date",
    "collector_tstamp_eastern"  as "collector_tstamp_eastern",
    "_updated_at"               as "_updated_at"
  FROM
    atomic.events_of_visitors_with_legit_company_names
);



CREATE OR REPLACE VIEW snowplow_analysis.com_snowplowanalytics_snowplow_ua_parser_context_1_base as (
  SELECT
    "root_id"            as "root_id",
    "device_family"      as "device_family",
    "os_version"         as "os_version",
    "os_patch_minor"     as "os_patch_minor",
    "os_patch"           as "os_patch",
    "os_minor"           as "os_minor",
    "os_major"           as "os_major",
    "os_family"          as "os_family",
    "useragent_version"  as "useragent_version",
    "useragent_patch"    as "useragent_patch",
    "useragent_minor"    as "useragent_minor",
    "useragent_major"    as "useragent_major",
    "useragent_family"   as "useragent_family",
    "ref_parent"         as "ref_parent",
    "ref_tree"           as "ref_tree",
    "ref_root"           as "ref_root",
    "schema_version"     as "schema_version",
    "schema_format"      as "schema_format",
    "schema_name"        as "schema_name",
    "schema_vendor"      as "schema_vendor",
    "root_tstamp"        as "root_tstamp"
  FROM
    atomic.com_snowplowanalytics_snowplow_ua_parser_context_1
);



CREATE OR REPLACE VIEW snowplow_analysis.transformed_snowplow_events_base as (
  SELECT
    "dvce_ismobile"             as "dvce_ismobile",
    "user_ipaddress_int"        as "user_ipaddress_int",
    "domain_sessionidx"         as "domain_sessionidx",
    "refr_urlport"              as "refr_urlport",
    "page_urlport"              as "page_urlport",
    "geo_latitude"              as "geo_latitude",
    "domain_sessionid"          as "domain_sessionid",
    "geo_country"               as "geo_country",
    "event_id"                  as "event_id",
    "geo_timezone"              as "geo_timezone",
    "dvce_type"                 as "dvce_type",
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
    "page_urlquery"             as "page_urlquery",
    "page_urlpath"              as "page_urlpath",
    "page_urlhost"              as "page_urlhost",
    "page_urlscheme"            as "page_urlscheme",
    "page_referrer"             as "page_referrer",
    "page_title"                as "page_title",
    "page_url"                  as "page_url",
    "ip_domain"                 as "ip_domain",
    "ip_organization"           as "ip_organization",
    "ip_isp"                    as "ip_isp",
    "geo_region_name"           as "geo_region_name",
    "geo_zipcode"               as "geo_zipcode",
    "geo_city"                  as "geo_city",
    "network_userid"            as "network_userid",
    "domain_userid"             as "domain_userid",
    "user_fingerprint"          as "user_fingerprint",
    "event"                     as "event",
    "user_ipaddress"            as "user_ipaddress",
    "visitor_id"                as "visitor_id",
    "derived_tstamp"            as "derived_tstamp",
    "dvce_tstamp_eastern"       as "dvce_tstamp_eastern",
    "collector_tstamp_eastern"  as "collector_tstamp_eastern",
    "etl_tstamp_eastern"        as "etl_tstamp_eastern",
    "_upated_at"                as "_upated_at"
  FROM
    atomic.transformed_snowplow_events
);



CREATE OR REPLACE VIEW snowplow_analysis.events_base as (
  SELECT
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



CREATE OR REPLACE VIEW snowplow_analysis.maxmind_law_firms_lower_names_base as (
  SELECT
    "lower_company_name"  as "lower_company_name"
  FROM
    atomic.maxmind_law_firms_lower_names
);