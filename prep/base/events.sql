{{ 
    config( materialized = 'incremental'
          , unique_key = ['event_id']
          , on_schema_change = 'sync_all_columns'
          )
}}

SELECT  -- event details
        event_id
	  , event_name
	  , event_format
	  , event_version
	  , event_fingerprint
	  , user_ipaddress 
	  , user_fingerprint

	  -- Snowplow-generated IDs
	  , domain_userid 
	  , domain_sessionid
	  , network_userid

      -- session info
      , app_id
	  , platform 
	  , txn_id 
	  , name_tracker 
	  , v_tracker 
	  , v_collector 
	  , v_etl
	  , geo_country
	  , geo_region
	  , geo_city
	  , geo_zipcode
	  , geo_latitude
	  , geo_longitude
	  , geo_region_name 
	  , ip_isp 
	  , ip_organization 
	  , ip_domain 
	  , ip_netspeed
	  , useragent
	  , dvce_type
	  , dvce_ismobile
	  , dvce_screenwidth
	  , dvce_screenheight

	  -- page details
	  , page_url
	  , page_title
	  , page_referrer 
	  , page_urlschem
	  , page_urlhost
	  , page_urlport
	  , page_urlpath 
	  , page_urlquery 
	  , page_urlfragment 
	  , refr_urlschem
	  , refr_urlhost
	  , refr_urlport
	  , refr_urlpath 
	  , refr_urlquery 
	  , refr_urlfragment 
	  , refr_mediu
	  , refr_sourc
	  , refr_term
	  , doc_charset
	  , doc_width
	  , doc_height
	  , geo_timezone
	  , etl_tags

      -- flattened JSON fields
	  , base_funnel_funnel_name
	  , base_funnel_step_name
	  , base_funnel_step_action
	  , user_id 
	  , user_role
	  , user_is_eligibility_verifield

	  --timestamps
	  , dvce_sent_tstamp
	  , refr_domain_userid
	  , refr_dvce_tstamp
	  , true_tstamp
	  , load_tstamp
	  , etl_tstamp
	  , collector_tstamp
	  , dvce_created_tstamp
	  , derived_tstamp

FROM {{ source('snowplow', 'atomic_events')}}
{% if is_incremental() %}
 WHERE derived_tstamp >= (SELECT MAX(derived_tstamp) FROM {{ this }} )
{% endif %}
  QUALIFY ROW() OVER (PARTITION BY event_id ORDER BY collector_tstamp ASC) = 1