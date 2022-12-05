{{ config(materialized="table") }}


with stg_sql_server_dbo_orders_items as (select * from {{ ref('stg_sql_server_dbo_orders_items') }})
,

fact_order_details as (
  
  select
   order_details_id
 , order_details_NK_id
 , user_id
 , product_id
 , order_id
 , quantity
 , prize_USD
 , quantity * prize_USD as total_prize_USD
 , shipping_service
 , created_at_id
 , _fivetran_deleted
 , _fivetran_synced

from stg_sql_server_dbo_orders_items
)

select * from fact_order_details