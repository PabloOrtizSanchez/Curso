{{ config(materialized="view") }}

with src_sql_server_dbo_shipping_addresses as (select * from {{ source("sql_server_dbo", "addresses") }})
,

base_shipping_addresses as (
  select
      {{ dbt_utils.surrogate_key(['address_id','_fivetran_synced']) }} as shipping_address_id
    , address_id as shipping_address_NK_id
    , country
    , state
    , zipcode
    , address
    , _fivetran_deleted
    , _fivetran_synced

from src_sql_server_dbo_shipping_addresses
)

select * from base_shipping_addresses