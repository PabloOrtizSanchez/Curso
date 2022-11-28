{{ config(materialized="view") }}

with stg_sql_server_dbo_addresses as (select * from {{ source("sql_server_dbo", "addresses") }})
,

addresses as (
  select

      md5(address_id) as address_id
    , country
    , state
    , zipcode
    , address
    , _fivetran_deleted
    , _fivetran_synced

from stg_sql_server_dbo_addresses
)

select * from addresses