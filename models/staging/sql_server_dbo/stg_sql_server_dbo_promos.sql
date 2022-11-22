{{ config(materialized="table") }}

with
    promos as (select * from {{ source("sql_server_dbo", "promos") }})


select
    md5(promo_id), promo_id as nombre_promo, discount, status, _fivetran_deleted, _fivetran_synced

from promos


-- preguntar como hacer test para ver que tipo de dato entra