
{{ config(materialized="table") }}

with

stg_sql_server_dbo_orders as (select * from {{ ref('stg_sql_server_dbo_orders') }})
,
stg_sql_server_dbo_orders_items as (select * from {{ ref('stg_sql_server_dbo_orders_items') }})
,


fact_orders as (
  select
      b.orders_items_id
    , a.order_id
    , b.product_id
    , tracking_id
    , address_id
    , promo_id
    , user_id
    , status
    , delivered_at
    , estimated_delivery_at
    , cantidad
    , order_cost
    , shipping_cost
    , order_total
    , shipping_service
    , created_at
    , a._fivetran_deleted
    , a._fivetran_synced

from stg_sql_server_dbo_orders as a
join
stg_sql_server_dbo_orders_items as b
on a.order_id = b.order_id
)

select * from fact_orders
order by orders_items_id