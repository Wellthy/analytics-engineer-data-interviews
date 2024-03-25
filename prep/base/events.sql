SELECT  event_id
      , event_name
	  , event_version

	  -- Snowplow-generated IDs
	  , domain_userid
	  , domain_sessionid

      -- session info
      , user_ipaddress 
	  , geo_country
	  , geo_city
	  , geo_zipcode
	  , geo_latitude
	  , geo_longitude
	  , geo_timezone
	  , dvce_type AS device_type
	  , dvce_ismobile AS is_mobile_device

	  -- page details
	  , page_url
	  , page_title
	  , page_referrer
	  , page_urlpath
	  , refr_urlpath

      -- flattened JSON fields
	  , funnel_funnel_name AS funnel_name
	  , funnel_step_name
	  , user_id
	  , user_role
	  , user_is_eligibility_verified

	  --timestamps
	  , collector_tstamp
	  , derived_tstamp

FROM {{ source('snowplow', 'events') }}
QUALIFY ROW() OVER (PARTITION BY event_id ORDER BY collector_tstamp ASC) = 1