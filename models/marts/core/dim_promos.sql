{{ config(materialized="table") }}

with stg_sql_server_dbo_promos as (select * from {{ ref('stg_sql_server_dbo_promos') }})
,

dim_promos as (
  select

      promo_id
    , nombre_promo
    , discount_dolares
    , status
    , _fivetran_deleted
    , _fivetran_synced

from stg_sql_server_dbo_promos
)

select * from dim_promos