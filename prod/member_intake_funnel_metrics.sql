WITH funnel_events AS (
  SELECT user_id AS member_id,
         is_eligibility_verified,
         account_creation_date,
         member_email,
         funnel_step_name,
         derived_tstamp,
         account_creation_date,
         DATEDIFF('days', account_creation_date, CURRENT_DATE) AS days_since_account_creation,
         is_mobile_device,
         client_id,
         client_name,
         client_size,
         client_industry,
         client_launch_date,
         DATEDIFF('days', client_launch_date, CURRENT_DATE) AS days_since_launch,
         eligibility_verification_method,
         page_urlpath,
         page_referrer,
         row_number() over (partition by member_id order by derived_tstamp) AS step_order
    FROM {{ ref('member_events') }}
   WHERE funnel_name = 'MEMBER_INTAKE'
),
 max_step_completed AS (
  SELECT user_id,
         max(step_order) as max_step_completed
  from calculate_steps
  GROUP BY ALL
)

SELECT funnel_events.member_id,
       funnel_events.member_email,
       funnel_events.is_eligibility_verified,
       funnel_events.days_since_account_creation,
       funnel_events.client_id,
       funnel_events.client_name,
       funnel_events.days_since_launch
       funnel_events.client_size,
       funnel_events.client_industry,
       funnel_events.eligibility_verification_method,
       funnel_events.step_name AS most_recent_step_completed,
       funnel_events.step_order AS most_recent_step_order_completed,
       funnel_events.is_mobile_device,
       funnel_events.derived_tstamp AS most_recent_step_completed_at,
       funnel_events.page_urlpath AS most_recent_page_url,
       funnel_events.page_referrer AS previous_page_url,
       CASE WHEN funnel_events.step_name = 'CREATE_PROJECT' THEN TRUE
            ELSE FALSE
       END AS completed_intake_funnel
FROM funnel_events
LEFT JOIN max_step_completed AS max_step ON max_step.user_id = funnel_events.user_id 
                                        AND funnel_events.step_order = max_step.max_step_completed
WHERE max_step.user_id IS NOT NULL