SELECT user_id AS member_id
     , user_name AS member_name
     , DATE(created) account_creation_date
     , client_id
     , is_eligibility_verified
     , {{ get_age_in_years('birthdate') }} AS member_age_in_years
     , country AS member_country
     , CASE WHEN email = ''
            THEN NULL
            ELSE email
       END AS member_email
     , _fivetran_deleted AS is_deleted_member
     , CASE WHEN _fivetran_deleted = TRUE
            THEN _fivetran_synced
            ELSE NULL
        END AS profile_deleted_at
FROM {{ source('wellthy', 'profiles_member') }}