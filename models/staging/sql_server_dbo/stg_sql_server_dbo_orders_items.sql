{{ config(materialized="view") }}

with src_sql_server_dbo_orders_items as (select * from {{ source("sql_server_dbo", "order_items") }})
,

stg_orders_items as(
  select
  {{ dbt_utils.surrogate_key(['order_id', 'product_id']) }} as orders_items_id
 , md5(order_id) as order_id
 , md5(product_id) as product_id
 , quantity as cantidad
 , _fivetran_deleted
 , _fivetran_synced

from src_sql_server_dbo_orders_items
)


select * from stg_orders_items
-- si quiero añadir la columna producto como meto esos datos
