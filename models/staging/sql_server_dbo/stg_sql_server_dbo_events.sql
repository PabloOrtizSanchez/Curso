{{ config(materialized="view") }}

with base_sql_server_dbo_events as (select * from {{ ref('base_sql_server_dbo_events') }})
,
base_sql_server_dbo_users as (select * from {{ ref('base_sql_server_dbo_users') }})
,
base_sql_server_dbo_products as (select * from {{ ref('base_sql_server_dbo_products') }})
,

stg_events as (
  
  select
      event_id
    , b.user_id
    , c.product_id
    , session_id
    , order_id
    , page_url
    , event_type
    , a.created_at_id
    , a._fivetran_deleted
    , a._fivetran_synced

from base_sql_server_dbo_events as a
left join
base_sql_server_dbo_users as b
on a.user_id = b.user_NK_id
left join
base_sql_server_dbo_products as c
on a.product_id = c.product_NK_id
)

select * from stg_events