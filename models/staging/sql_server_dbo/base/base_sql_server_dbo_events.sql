{{ config(materialized="view") }}

with src_sql_server_dbo_events as (select * from {{ source('sql_server_dbo', 'events') }})
,

base_events as (
  select

     {{ dbt_utils.surrogate_key(['event_id', '_fivetran_synced']) }} as event_id
    , event_id as event_NK_id
    , user_id
    , product_id
    , session_id
    , order_id
    , page_url
    , event_type
    , year(cast(created_at as date))*10000+month(cast(created_at as date))*100+day(cast(created_at as date)) as created_at_id
    , created_at
    , _fivetran_deleted
    , _fivetran_synced

from src_sql_server_dbo_events
)

select * from base_events