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
     , members.is_eligibility_verified
     , members.account_creation_date
     , members.country
     , events.user_ipaddress
     , members.member_email
     , members.is_deleted_member
     , members.profile_deleted_date

     -- client dimensions
     , client.name
     , client.client_launch_date
     , client.days_since_launch
     , client.client_size
     , client.client_industry
     , client.eligibility_verification_method
     , client.is_archived
     , client.archived_date

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

FROM {{ ref('events') }}
JOIN {{ ref('members') }} ON members.member_id = events.user_id
LEFT JOIN {{ ref('clients') }} ON clients.client_id = members.client_id
