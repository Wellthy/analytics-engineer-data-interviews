-- BASE MODEL: snowplow raw events
-- something about incremental models?
{{ 
    config( materialized = 'incremental'
          , unique_key = ['event_id']
          , on_schema_change = 'sync_all_columns'
          )
}}

{%- set additional_columns_to_exclude = ['page_title'
                                        ,'mkt_medium'
                                        ,'mkt_source'
                                        ,'mkt_term'
                                        ,'mkt_content'
                                        ,'mkt_campaign'
                                        ,'mkt_clickid'
                                        ,'geo_latitude'
                                        ,'geo_longitude'
                                        ,'geo_region'
                                        ,'geo_city'
                                        ,'geo_timezone'
                                        ,'geo_zipcode'
                                        ,'ip_isp'
                                        ,'ip_organization'
                                        ,'ip_domain'
                                        ,'ip_netspeed'
                                        ,'page_url'
                                        ]
-%}


SELECT * EXCLUDE({%- for column in additional_columns_to_exclude -%}
                 {{ column }},
                 {% endfor %}  

FROM {{ source('snowplow', 'atomic_events')}}
{% if is_incremental() %}
 WHERE derived_tstamp >= (SELECT MAX(derived_tstamp) FROM {{ this }} )
{% endif %}
  QUALIFY ROW_NUMBER() OVER (PARTITION BY event_id ORDER BY collector_tstamp ASC) = 1