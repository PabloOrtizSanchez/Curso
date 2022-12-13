{{
   config(materialized="incremental",
unique_key = 'product_NK_id'
) 
}}
 

with stg_sql_server_dbo_products as (select * from {{ ref('stg_sql_server_dbo_products') }})
,

dim_products as (

  select

      product_id
    , product_NK_id
    , inventory
    , price_USD
    , name
    , _fivetran_deleted
    , _fivetran_synced
    
from stg_sql_server_dbo_products
)

select * from dim_products

{% if is_incremental() %}

  where _fivetran_synced > (select max(_fivetran_synced) from {{ this }})

{% endif %}