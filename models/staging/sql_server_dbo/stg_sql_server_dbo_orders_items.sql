{{ config(materialized="view") }}

with order_items as (select * from {{ source("sql_server_dbo", "order_items") }})

select

  md5(order_id) as order_id
 , md5(product_id) as product_id
 , quantity
 , _fivetran_deleted
 , _fivetran_synced

from order_items

-- si quiero añadir la columna producto como meto esos datos
