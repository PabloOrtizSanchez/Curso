{{ config(materialized="table") }}

with snp_sql_server_dbo_products as (select * from {{ ref('products_snapshot') }})
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
    , dbt_valid_from
    , dbt_valid_to
    
from snp_sql_server_dbo_products
)

select * from dim_products