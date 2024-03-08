SELECT user_id AS member_id
     , user_name AS member_name
     , created AS created_at
     , DATE(created) AS signup_date
     , modified AS most_recent_modified_at
     , DATE(modified) AS most_recent_modified_date
     , DATEDIFF('days', created_date, CURRENT_DATE) AS days_since_signup
     , client_id
     , eligibility_verified AS is_eligibility_verified
     , {{ get_age_in_years('birthdate') }} AS member_age_in_years
     , referral_source
     , country AS member_country
     , CASE WHEN email = ''
            THEN NULL
            ELSE email
       END AS member_email
     , CASE WHEN REGEXP_COUNT(email,'@') = 1
            THEN SPLIT_PART(email,'@',2)
            ELSE NULL
        END AS member_email_domain
     , CASE WHEN caregiving_goal = 1
            THEN 'Create a Care Plan'
            WHEN caregiving_goal = 2
            THEN 'Create a Community Account'
            WHEN caregiving_goal = 3
            THEN 'Create a Care Project'
            WHEN caregiving_goal = 4
            THEN 'Just Looking Around'
            WHEN caregiving_goal IS NULL
            THEN NULL
            ELSE 'Undefined'
        END AS caregiving_goal
     , _fivetran_deleted AS is_deleted_member
     , CASE WHEN _fivetran_deleted = TRUE
            THEN _fivetran_synced
            ELSE NULL
        END AS profile_deleted_at
     , _fivetran_synced AS synced_at
FROM {{ source('wellthy', 'profiles_member') }}