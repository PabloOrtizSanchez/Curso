{{ config(materialized="view") }}

with stg_sql_server_dbo_products as (select * from {{ source("sql_server_dbo", "products") }})
,

products as (
  select

      md5(product_id) as product_id
    , inventory
    , price as price_USD
    , name
    , _fivetran_deleted
    , _fivetran_synced
    
from stg_sql_server_dbo_products
)

select * from products