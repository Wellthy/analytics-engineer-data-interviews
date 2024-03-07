SELECT raw_events.*
     , members.member_id
     , user_type
     , member_name
     , created AS created_at
     , DATE(created) AS created_date
     , modified AS most_recent_modified_at
     , DATE(modified) AS most_recent_modified_date
     , members.client_group_id
     , members.is_eligibility_verified
     , members.member_age_in_years
     , members.gender_name
     , referral_source_id
     , members.country
     , members.member_email
     , members.member_email_domain
     , members.has_enabled_email_notifications
     , members.gets_newsletter
     , members.caregiving_goal
     , members.is_deleted_member
     , members.profile_deleted_date
FROM {{ ref('snowplow_raw_events') }} AS raw_events
JOIN {{ ref('members') }} AS members ON members.member_id = raw_events.user_id