{{ config(materialized="view") }}

with base_sql_server_dbo_shipping_addresses as (select * from {{ ref('base_sql_server_dbo_shipping_addresses') }})
,
seed_zipcode_to_city as (select * from {{ ref('seed_zipcode_to_city') }})
,

stg_shipping_addresses as (
  select
      shipping_address_id
    , shipping_address_NK_id
    , country
    , state
    , b.primary_city
    , a.zipcode
    , address
    , _fivetran_deleted
    , _fivetran_synced

from base_sql_server_dbo_shipping_addresses as a
left join
seed_zipcode_to_city as b
on a.zipcode = b.zipcode
)

select * from stg_shipping_addresses