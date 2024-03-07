SELECT id AS client_group_id
     , name AS client_group_name
     , client_id
     , created AS created_at
     , DATE(created) AS created_date
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
     , is_default AS is_default_group
     , modified AS modified_at
     , _fivetran_synced AS synced_at
  FROM {{ source('wellthy', 'partnerships_group') }}
 WHERE _fivetran_deleted = FALSE