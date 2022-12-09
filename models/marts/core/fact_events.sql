{{
   config(materialized="incremental",
unique_key = 'event_NK_id'
) 
}}

with stg_sql_server_dbo_events as (select * from {{ ref('stg_sql_server_dbo_events') }})
,

fact_events as (
  
  select
      event_id
    , event_NK_id
    , user_id
    , product_id
    , session_id
    , order_id
    , page_url
    , event_type
    , created_at_id
    , created_at
    , _fivetran_deleted
    , _fivetran_synced

from stg_sql_server_dbo_events
)



select * from fact_events

{% if is_incremental() %}

  where _fivetran_synced > (select max(_fivetran_synced) from {{ this }})

{% endif %}