{{ config(materialized="view") }}

with addresses as (select * from {{ source("sql_server_dbo", "addresses") }})

select

      md5(address_id) as address_id
    , country
    , state
    , zipcode
    , address
    , _fivetran_deleted
    , _fivetran_synced

from addresses