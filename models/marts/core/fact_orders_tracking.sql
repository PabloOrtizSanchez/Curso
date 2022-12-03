
{{ config(materialized="table") }}

with

stg_sql_server_dbo_orders as (select * from {{ ref('stg_sql_server_dbo_orders') }})
,



fact_orders_tracking as (
  
  select

      order_tracking_id
    , order_tracking_NK_id
    , shipping_address_id
    , user_id
    , tracking_id
    , promo_id
    , created_at_id
    , shipping_service
    , estimated_delivery_at_id
    , delivered_at_id
    , status
    , order_cost_USD
    , shipping_cost_USD
    , order_total_USD
    , _fivetran_deleted
    , _fivetran_synced

from stg_sql_server_dbo_orders
)

select * from fact_orders_tracking
