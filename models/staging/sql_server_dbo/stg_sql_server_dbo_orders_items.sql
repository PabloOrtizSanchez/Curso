{{ config(materialized="view") }}

with stg_sql_server_dbo_orders_items as (select * from {{ source("sql_server_dbo", "order_items") }})
,

orders_items as(
  select

  md5(order_id) as order_id
 , md5(product_id) as product_id
 , quantity
 , _fivetran_deleted
 , _fivetran_synced

from stg_sql_server_dbo_orders_items
)


select * from orders_items
-- si quiero añadir la columna producto como meto esos datos
