{{ config(materialized="view") }}

with src_sql_server_dbo_events as (select * from {{ source("sql_server_dbo", "events") }})
,

srg_events as (
  select

      md5(event_id) as event_id
    , md5(user_id) as user_id
    , md5(product_id) as product_id
    , md5(session_id) as session_id
    , md5(order_id) as order_id
    , page_url
    , event_type as tipo_evento
    , cast(created_at as date) as created_at
    , _fivetran_deleted
    , _fivetran_synced

from src_sql_server_dbo_events
)

select * from stg_events