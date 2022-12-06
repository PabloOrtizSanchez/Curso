
{{ config(materialized="table") }}

with stg_sql_server_dbo_events as (select * from {{ ref('stg_sql_server_dbo_events') }})
,


fact_events as (
  
  select
      event_id
    , user_id
    , product_id
    , session_id
    , order_id
    , page_url
    , event_type
    , created_at_id
    , _fivetran_deleted
    , _fivetran_synced

from stg_sql_server_dbo_events
)

select * from fact_events
