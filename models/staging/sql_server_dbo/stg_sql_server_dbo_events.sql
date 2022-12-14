{{ config(materialized="view") }}

with base_sql_server_dbo_events as (select * from {{ ref('base_sql_server_dbo_events') }})
,
base_sql_server_dbo_users as (select * from {{ ref('base_sql_server_dbo_users') }})
,
base_sql_server_dbo_products as (select * from {{ ref('base_sql_server_dbo_products') }})
,
base_sql_server_dbo_orders as (select * from {{ ref('base_sql_server_dbo_orders') }})
,

stg_events as (
  
  select
      event_id
    , event_NK_id
    , b.user_id
    , c.product_id
    , session_id
    , d.order_id
    , page_url
    , event_type
    , a.created_at_id
    , a.created_at
    , a._fivetran_deleted
    , a._fivetran_synced

from base_sql_server_dbo_events as a
left join
base_sql_server_dbo_users as b
on a.user_id = b.user_NK_id
left join
base_sql_server_dbo_products as c
on a.product_id = c.product_NK_id
left join base_sql_server_dbo_orders as d
on a.order_id = d.order_NK_id
)

select * from stg_events