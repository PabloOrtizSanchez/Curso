{{ config(materialized="view") }}

with src_sql_server_dbo_shipping_addresses as (select * from {{ source("sql_server_dbo", "addresses") }})
,

stg_addresses as (
  select
      md5(address_id) as address_id
    , country as pais
    , state as estado
    , zipcode
    , address
    , _fivetran_deleted
    , _fivetran_synced

from src_sql_server_dbo_shipping_addresses
)

select * from stg_addresses