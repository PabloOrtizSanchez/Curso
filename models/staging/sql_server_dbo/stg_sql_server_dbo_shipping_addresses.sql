{{ config(materialized="view") }}

with base_sql_server_dbo_shipping_addresses as (select * from {{ ref('base_sql_server_dbo_shipping_addresses') }})
,

stg_shipping_addresses as (
  select
      shipping_address_id
    , shipping_address_NK_id
    , country
    , state
    , zipcode
    , address
    , _fivetran_deleted
    , _fivetran_synced

from base_sql_server_dbo_shipping_addresses
)

select * from stg_shipping_addresses