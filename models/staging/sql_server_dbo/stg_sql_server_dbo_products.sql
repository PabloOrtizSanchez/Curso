{{ config(materialized="view") }}

with src_sql_server_dbo_products as (select * from {{ source("sql_server_dbo", "products") }})
,

stg_products as (
  select

       {{ dbt_utils.surrogate_key(['product_id', '_fivetran_synced']) }} as product_id
    , product_id as product_NK_id
    , inventory as inventario
    , price as precio_USD
    , name as nombre
    , _fivetran_deleted
    , _fivetran_synced
    
from src_sql_server_dbo_products
)

select * from stg_products