{{ config(materialized="view") }}

with base_sql_server_dbo_promos as (select * from {{ ref('base_sql_server_dbo_promos') }})
,



stg_promos as (
  
  select

      promo_id
    , promo_NK_id
    , discount_USD
    , status
    , _fivetran_deleted
    , _fivetran_synced

from base_sql_server_dbo_promos
)

select * from stg_promos


