SELECT id AS client_id
     , name
     , CAST(created AS DATE) AS client_launch_date
     , client_size
     , client_industry
     , client_landing_page_url
     , CASE WHEN verification_type = ''
            THEN NULL
            ELSE verification_type
       END AS eligibility_verification_method
     , is_archived
     , CASE WHEN archived = TRUE
            THEN DATE(modified)
            ELSE NULL
       END AS archived_date
     , _fivetran_synced AS synced_at
  FROM {{ source('wellthy', 'partnerships_client') }}
 WHERE _fivetran_deleted = FALSE