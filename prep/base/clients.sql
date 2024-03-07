SELECT id AS client_id
     , name
     , plan_type AS plan_type_id
     , partnership_manager_id AS client_manager_id
     , created AS created_at
     , CAST(created AS DATE) AS created_date
     , modified AS modified_at
     , CAST(modified AS DATE) AS most_recent_modified_date
     , archived AS is_archived
     , CASE WHEN archived = TRUE
            THEN DATE(modified)
            ELSE NULL
       END AS archived_date
     , covered_lives AS number_of_covered_lives
     , CAST(covered_lives_effective_date AS DATE) AS covered_lives_effective_date
     , CASE WHEN eligibility_file = '' THEN NULL
            ELSE eligibility_file
       END AS eligibility_file
     , prompt_members_for_group
     , require_eligibility_id
     , CASE WHEN slug = ''
            THEN NULL
            ELSE slug
       END AS client_slug
     , CASE WHEN verification_type = ''
            THEN NULL
            ELSE verification_type
       END AS verification_type
     , _fivetran_synced AS synced_at
  FROM {{ source('wellthy', 'partnerships_client') }}
 WHERE _fivetran_deleted = FALSE