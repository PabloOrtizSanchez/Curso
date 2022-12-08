{{
   config(materialized="incremental",
unique_key = 'event_NK_id'
) 
}}

with stg_sql_server_dbo_events as (select * from {{ ref('stg_sql_server_dbo_events') }})
,
int_events_session as (select * from {{ ref('int_events_session') }})
,
fact_events as (
  
  select
      a.event_id
    , a.event_NK_id
    , a.user_id
    , a.product_id
    , a.session_id
    , b.duracion_sesion_segundos
    , a.order_id
    , a.page_url
    , a.event_type
    , a.created_at_id
    , a.created_at
    , a._fivetran_deleted
    , a._fivetran_synced

from stg_sql_server_dbo_events as a
left join
int_events_session as b
on a.session_id = b.session_id
)



select * from fact_events

{% if is_incremental() %}

  where _fivetran_synced > (select max(_fivetran_synced) from {{ this }})

{% endif %}