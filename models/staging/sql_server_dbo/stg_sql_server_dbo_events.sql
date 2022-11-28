{{ config(materialized="view") }}

with stg_sql_server_dbo_events as (select * from {{ source("sql_server_dbo", "events") }})
,

events as (
  select

      md5(event_id) as event_id
    , md5(user_id) as user_id
    , md5(product_id) as product_id
    , md5(session_id) as session_id
    , md5(order_id) as order_id
    , page_url
    , event_type
    , created_at
    , _fivetran_deleted
    , _fivetran_synced

from stg_sql_server_dbo_events
)

select * from events