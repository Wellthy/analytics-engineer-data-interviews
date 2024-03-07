SELECT events.app_id
	, events.platform 
	, events.etl_tstamp
	, events.collector_tstamp
	, events.dvce_created_tstamp
	, events.event 
	, events.event_id
	, events.txn_id 
	, events.name_tracker 
	, events.v_tracker 
	, events.v_collector 
	, events.v_etl
	, events.user_id 
	, events.user_ipaddress 
	, events.user_fingerprint 
	, events.domain_userid 
	, events.domain_sessionidx 
	, events.network_userid 
	, events.geo_country
	, events.geo_region
	, events.geo_city
	, events.geo_zipcode
	, events.geo_latitude
	, events.geo_longitude
	, events.geo_region_name 
	, events.ip_isp 
	, events.ip_organization 
	, events.ip_domain 
	, events.ip_netspeed 
	, events.page_url
	, events.page_title
	, events.page_referrer 
	, events.page_urlschem
	, events.page_urlhost
	, events.page_urlport
	, events.page_urlpath 
	, events.page_urlquery 
	, events.page_urlfragment 
	, events.refr_urlschem
	, events.refr_urlhost
	, events.refr_urlport
	, events.refr_urlpath 
	, events.refr_urlquery 
	, events.refr_urlfragment 
	, events.refr_mediu
	, events.refr_sourc
	, events.refr_term
	, events.useragent
	, events.dvce_type
	, events.dvce_ismobile
	, events.dvce_screenwidth
	, events.dvce_screenheight
	, events.doc_charset
	, events.doc_width
	, events.doc_height
	, events.geo_timezone
	, events.etl_tags
	, events.dvce_sent_tstamp
	, events.refr_domain_userid
	, events.refr_dvce_tstamp
	, events.domain_sessionid
	, events.derived_tstamp
	, events.event_vendor
	, events.event_name
	, events.event_format
	, events.event_version
	, events.event_fingerprint
	, events.true_tstamp
	, events.load_tstamp
	, events.unstruct_event_com_wellthy_member_intake_funnel
	, events.contexts_com_wellthy_user
     , members.client_group_id
     , members.user_type
     , member.user_name
     , member.signup_date
     , members.client_group_id
     , members.is_eligibility_verified
     , members.member_age_in_years
     , members.gender_name
     , referral_source
     , members.country
     , members.member_email
     , members.member_email_domain
     , members.caregiving_goal
     , members.is_deleted_member
     , members.profile_deleted_date
FROM {{ ref('events') }}
JOIN {{ ref('members') }} members.member_id = events.user_id