{{ config(materialized="table") }}

with stg_sql_server_dbo_addresses as (select * from {{ ref('stg_sql_server_dbo_addresses') }})
,

dim_addresses as (
  select

     address_id
    , country
    , state
    , zipcode
    , address
    , _fivetran_deleted
    , _fivetran_synced

from stg_sql_server_dbo_addresses
)

select * from dim_addresses