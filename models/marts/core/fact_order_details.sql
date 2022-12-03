{{ config(materialized="table") }}


with stg_sql_server_dbo_orders_items as (select * from {{ ref('stg_sql_server_dbo_orders_items') }})
,
stg_sql_server_dbo_orders as (select * from {{ ref('stg_sql_server_dbo_orders') }})
,
stg_sql_server_dbo_users as (select * from {{ ref('stg_sql_server_dbo_users') }})
,
stg_sql_server_dbo_products as (select * from {{ ref('stg_sql_server_dbo_products') }})
,

fact_order_details as (
  
  select
   a.order_details_id
 , a.order_details_NK_id
 , c.user_id
 , d.product_id
 , a.order_id
 , a.quantity
 , a.quantity * d.prize_USD
 , b.shipping_service
 , b.created_at_id
 , a._fivetran_deleted
 , a._fivetran_synced

from stg_sql_server_dbo_orders_items as a
join
stg_sql_server_dbo_orders as b
on a.order_id = b.order_tracking_NK_id
join
stg_sql_server_dbo_users as c
on b.user_id = c.user_id
join
stg_sql_server_dbo_products as d
on b.product_id = d.product_id
)

select * from fact_order_details