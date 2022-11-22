{{ config(materialized="view") }}

with products as (select * from {{ source("sql_server_dbo", "products") }})


select

      md5(product_id) as product_id
    , inventory, price
    , name
    , _fivetran_deleted
    , _fivetran_synced
    
from products