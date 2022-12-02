{{ config(materialized="view") }}

with src_sql_server_dbo_promos as (select * from {{ source("sql_server_dbo", "promos") }})
,


stg_promos as (
  select

      md5(promo_id) as promo_id
    , promo_id as nombre_promo
    , discount as descuento_dolares
    , status as estado
    , _fivetran_deleted
    , _fivetran_synced

from src_sql_server_dbo_promos
)

select * from stg_promos
-- preguntar como hacer test para ver que tipo de dato entra

