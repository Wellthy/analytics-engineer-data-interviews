-- this model should allow for breaking out the funnel by different time periods and member dimensions
-
SELECT member_events.domain_userid,
       member_events.member_id,
       member_events.client_id,
       member_events.domain_sessionid AS session_id,
       member_events.derived_tstamp as "timestamp",
       funnel.funnel_name,
       funnel.funnel_step_name,
   from {{ ref('snowplow_member_events') }} AS member_events
   INNER JOIN {{ ref('funnel_definitions') }} AS funnel ON page_url = member_events.page_url
   WHERE member_events.event_name = 'page_view' 
     AND page_url IS NOT NULL
     AND funnel.funnel_name = 'Onboarding Funnel'