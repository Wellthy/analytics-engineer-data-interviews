SELECT id AS group_id
     , name AS group_name
     , client_id
     , care_recipient_countries
     , country
     , created AS created_at
     , CASE WHEN group_status = 1
            THEN 'Implementation'
            WHEN group_status = 2
            THEN 'Pre-launch'
            WHEN group_status = 3
            THEN 'Pilot'
            WHEN group_status = 4
            THEN 'Sales Trials'
            WHEN group_status = 5
            THEN 'Active'
            WHEN group_status = 6
            THEN 'Decommisioning'
            WHEN group_status = 7
            THEN 'Terminated'
            WHEN group_status IS NULL
            THEN NULL
            ELSE 'Undefined'
        END AS group_status
     , is_default
     , modified AS modified_at
     , offers_community_access
     , covered_lives AS number_of_covered_lives
     , DATE(covered_lives_effective_date) AS covered_lives_effective_date
     , _fivetran_synced AS synced_at
  FROM {{ source('wellthy', 'partnerships_group') }}
 WHERE _fivetran_deleted = FALSE