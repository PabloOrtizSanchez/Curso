{{ config(materialized="view") }}

with src_sql_server_dbo_promos as (select * from {{ source("sql_server_dbo", "promos") }})
,

base_promos as (
  select

      {{ dbt_utils.surrogate_key(['promo_id','_fivetran_synced']) }} as promo_id
    , promo_id as promo_NK_id
    , discount as discount_USD
    , status
    , _fivetran_deleted
    , _fivetran_synced

from src_sql_server_dbo_promos
)

select * from base_promos