{{ config(materialized="table") }}

with products as (select * from {{ source("sql_server_dbo", "products") }})

alter table products rename column price to price_($)  -- como se hace eso :(

select

      md5(product_id) as product_id
    , inventory
    , price_($)
    , name
    , _fivetran_deleted
    , _fivetran_synced
    
from products