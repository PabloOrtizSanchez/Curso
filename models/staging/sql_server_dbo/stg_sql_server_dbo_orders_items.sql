{{ config(materialized="view") }}

with base_sql_server_dbo_orders_items as (select * from {{ ref('base_sql_server_dbo_orders_items') }})
,
base_sql_server_dbo_orders as (select * from {{ ref('base_sql_server_dbo_orders') }})
,
base_sql_server_dbo_products as (select * from {{ ref('base_sql_server_dbo_products') }})
,
base_sql_server_dbo_users as (select * from {{ ref('base_sql_server_dbo_users') }})
,


stg_orders_items as (

  select
   order_item_id as order_details_id
 , order_items_NK_id as order_details_NK_id
 , b.order_id
 , d.user_id
 , c.product_id
 , a.quantity
 , c.prize_USD
 , b.shipping_service
 , b.created_at_id
 , a._fivetran_deleted
 , a._fivetran_synced

from base_sql_server_dbo_orders_items as a
join
base_sql_server_dbo_orders as b
on a.order_id = b.order_NK_id
join 
base_sql_server_dbo_products as c
on a.product_id = c.product_NK_id
join
base_sql_server_dbo_users as d
on b.user_id = d.user_NK_id
)

select * from stg_orders_items
order by order_id