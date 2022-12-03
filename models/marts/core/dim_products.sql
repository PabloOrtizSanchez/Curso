{{ config(materialized="table") }}

with stg_sql_server_dbo_products as (select * from {{ ref('stg_sql_server_dbo_products') }})
,

dim_products as (

  select

      product_id
    , product_NK_id
    , inventory
    , prize_USD
    , name
    , _fivetran_deleted
    , _fivetran_synced
    
from stg_sql_server_dbo_products
)

select * from dim_products