{{ config(materialized="view") }}

with base_sql_server_dbo_products as (select * from {{ ref('base_sql_server_dbo_products') }})
,

stg_products as (

  select

      product_id
    , product_NK_id
    , inventory
    , prize_USD
    , name
    , _fivetran_deleted
    , _fivetran_synced
    
from base_sql_server_dbo_products
)

select * from stg_products