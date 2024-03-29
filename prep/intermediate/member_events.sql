SELECT events.event_id
     , events.event_name
     , events.event_version

     -- Snowplow-generated IDs
     , events.domain_userid
     , events.domain_sessionid

     -- member dimensions
     , events.user_id
     , members.member_name
     , events.user_role
     , member.is_eligibility_verified
     , member.account_creation_date
     , members.member_country
     , events.user_ipaddress 
     , members.member_email
     , members.is_deleted_member
     , members.profile_deleted_at

     -- event dimensions
     , events.funnel_name
     , events.funnel_step_name
     , events.domain_userid

     -- session info
     , events.geo_country
     , events.geo_city
     , events.geo_zipcode
     , events.geo_latitude
     , events.geo_longitude
     , events.geo_timezone
     , events.device_type
     , events.is_mobile_device

     -- page details
     , events.page_url
     , events.page_title
     , events.page_referrer
     , events.page_urlpath
     , events.refr_urlpath

     -- timestamps
     , events.collector_tstamp
     , events.derived_tstamp

FROM {{ ref('events') }} AS events
JOIN {{ ref('members') }} AS members ON members.member_id = events.user_id