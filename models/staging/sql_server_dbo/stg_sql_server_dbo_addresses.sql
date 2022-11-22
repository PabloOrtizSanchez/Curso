{{ config(materialized="view") }}

with addresses as (select * from {{ source("sql_server_dbo", "addresses") }})

select *
from addresses
