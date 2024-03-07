SELECT id AS client_id
     , name
     , contract_type
     , partnership_manager_id AS client_manager_id
     , created AS created_at
     , CAST(created AS DATE) AS client_launch_date
     , DATEDIFF('days', client_launch_date, CURRENT_DATE) AS days_since_launch
     , covered_lives AS client_size
     , client_industry
     , client_landing_page_url
     , CASE WHEN slug = ''
            THEN NULL
            ELSE slug
       END AS client_slug
     , CASE WHEN verification_type = ''
            THEN NULL
            ELSE verification_type
       END AS eligibility_verification_method
     , modified AS modified_at
     , archived AS is_archived
     , CASE WHEN archived = TRUE
            THEN DATE(modified)
            ELSE NULL
       END AS archived_date
     , _fivetran_synced AS synced_at
  FROM {{ source('wellthy', 'partnerships_client') }}
 WHERE _fivetran_deleted = FALSE