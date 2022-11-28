{{ config(materialized="table") }}

with stg_sql_server_dbo_addresses as (select * from {{ ref('stg_sql_server_dbo_addresses') }})
,

stg_sql_server_dbo_products as (select * from {{ ref('stg_sql_server_dbo_products') }})

select 