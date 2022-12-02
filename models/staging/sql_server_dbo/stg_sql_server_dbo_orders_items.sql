{{ config(materialized="view") }}

with src_sql_server_dbo_orders_items as (select * from {{ source("sql_server_dbo", "order_items") }})
,
stg_sql_server_dbo_orders as (select * from {{ ref('stg_sql_server_dbo_orders') }})
,
stg_sql_server_dbo_products as (select * from {{ ref('stg_sql_server_dbo_products') }})
,


stg_orders_items as (
  select
  {{ dbt_utils.surrogate_key(['a.order_id', 'a.product_id']) }} as order_item_id
 , concat(a.order_id,a.product_id) as order_items_NK_id
 , b.order_id
 , c.product_id
 , a.quantity
 , a._fivetran_deleted
 , a._fivetran_synced

from src_sql_server_dbo_orders_items as a
join
stg_sql_server_dbo_orders as b
on a.order_id = b.order_NK_id
join 
stg_sql_server_dbo_products as c
on a.product_id = c.product_NK_id
)


select * from stg_orders_items
-- si quiero añadir la columna producto como meto esos datos
