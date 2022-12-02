{{ config(materialized="view") }}

with src_sql_server_dbo_events as (select * from {{ source("sql_server_dbo", "events") }})
,
stg_sql_server_dbo_users as (select * from {{ ref('stg_sql_server_dbo_users') }})
,
stg_sql_server_dbo_products as (select * from {{ ref('stg_sql_server_dbo_products') }})
,


stg_events as (
  select

     {{ dbt_utils.surrogate_key(['event_id', 'a._fivetran_synced']) }} as event_id
    , b.user_id
    , c.product_id
    , session_id
    , order_id
    , page_url
    , event_type
    , year(cast(a.created_at as date))*10000+month(cast(a.created_at as date))*100+day(cast(a.created_at as date)) as created_at_id
    , a._fivetran_deleted
    , a._fivetran_synced

from src_sql_server_dbo_events as a
join
stg_sql_server_dbo_users as b
on a.user_id = b.user_NK_id
join
stg_sql_server_dbo_products as c
on a.product_id = c.product_NK_id
)

select * from stg_events