{{ config(materialized="view") }}

with src_sql_server_dbo_orders_items as (select * from {{ source("sql_server_dbo", "order_items") }})
,

base_orders_items as (
  select
  {{ dbt_utils.surrogate_key(['order_id', 'product_id']) }} as order_item_id
 , concat(order_id,product_id) as order_items_NK_id
 , order_id
 , product_id
 , quantity
 , _fivetran_deleted
 , _fivetran_synced

from src_sql_server_dbo_orders_items
)


select * from base_orders_items