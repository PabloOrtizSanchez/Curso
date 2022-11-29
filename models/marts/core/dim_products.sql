{{ config(materialized="table") }}

with stg_sql_server_dbo_products as (select * from {{ ref('stg_sql_server_dbo_products') }})
,

dim_products as (
  select

      product_id
    , inventory
    , price_USD
    , name
    , _fivetran_deleted
    , _fivetran_synced
    
from stg_sql_server_dbo_products
)

select * from dim_products