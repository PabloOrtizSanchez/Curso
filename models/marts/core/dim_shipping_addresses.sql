{{ config(materialized="table") }}

with stg_sql_server_dbo_shipping_addresses as (select * from {{ ref('stg_sql_server_dbo_shipping_addresses') }})
,

dim_shipping_addresses as (
  
  select
      shipping_address_id
    , shipping_address_NK_id
    , country
    , state
    , zipcode
    , address
    , _fivetran_deleted
    , _fivetran_synced


from stg_sql_server_dbo_shipping_addresses
)

select * from dim_shipping_addresses