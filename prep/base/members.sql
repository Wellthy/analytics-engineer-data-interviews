-- Exclude columns that may contain PII
WITH pii_filter AS 
(
    SELECT *
   EXCLUDE photo
      FROM {{ source('wellthy', 'profiles_customer') }}
)
SELECT user_id AS member_id
     , user_type
     , created AS created_at
     , DATE(created) AS created_date
     , {{ first_day_of_week('created') }}  AS created_week
     , modified AS most_recent_modified_at
     , DATE(modified) AS most_recent_modified_date
     , {{ first_day_of_week('modified') }}  AS most_recent_modified_week
     , first_assigned AS first_assigned_project_coordinator_at
     , DATE(first_assigned) AS first_assigned_project_coordinator_date
     , group_id
     , CAST(last_surveyed AS DATE) AS most_recent_surveyed_date
     , {{ get_age_in_years('birthdate') }} AS member_age_in_years
     -- The `gender` column has been changed to `gender_deprecated` in Postgres, so `gender` no longer exists in Aurora
     -- Adding this alias to avoid breaking downstream logic
     , gender_deprecated AS gender
     , {{ gender_type('gender_deprecated') }} AS gender_name
     , eligibility_verified AS is_eligibility_verified
     , referral_source_id
     , CASE WHEN eligibility_id = ''
            THEN NULL
            ELSE UPPER(eligibility_id)
        END AS eligibility_id
     , country
     , CASE WHEN secondary_email = ''
            THEN NULL
            ELSE secondary_email
       END AS secondary_email
     , CASE WHEN REGEXP_COUNT(secondary_email,'@') = 1 -- safety check to make sure we don't try to split any invalid email addresses
            THEN SPLIT_PART(secondary_email,'@',2) -- split the domain from the email
            ELSE NULL
        END AS secondary_email_domain
     , _fivetran_deleted AS is_deleted_member
     , CASE WHEN _fivetran_deleted = TRUE
            THEN _fivetran_synced
            ELSE NULL
        END AS profile_deleted_at
     , DATE(profile_deleted_at) AS profile_deleted_date
     , email_notifications AS has_enabled_email_notifications
     , history_changed_fields AS fields_modified_list
     , newsletter AS gets_newsletter
     , CASE WHEN caregiving_goal = 1
            THEN 'Care Plan'
            WHEN caregiving_goal = 2
            THEN 'Community'
            WHEN caregiving_goal = 3
            THEN 'Care Project'
            WHEN caregiving_goal = 4
            THEN 'Looking Around'
            WHEN caregiving_goal = 6
            THEN 'Omitted: Project Access Only'
            WHEN caregiving_goal = 7
            THEN 'Omitted: Webinar Signup'
            WHEN caregiving_goal = 8
            THEN 'Omitted: Question Disabled'
            WHEN caregiving_goal IS NULL
            THEN NULL
            ELSE 'Undefined'
        END AS caregiving_goal
     , _fivetran_synced AS synced_at
  FROM pii_filter