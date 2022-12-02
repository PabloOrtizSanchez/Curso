{{ config(materialized="view") }}

with base_google_sheets_budget as (select * from {{ ref('base_google_sheets_budget') }})
,
base_sql_server_dbo_products as (select * from {{ ref('base_sql_server_dbo_products') }})
,

stg_budget as (

select  
  budget_id
, budget_NK_id
, b.product_id
, quantity
, month_id
, a._fivetran_synced

from base_google_sheets_budget as a
join
base_sql_server_dbo_products as b
on a.product_id = b.product_NK_id
)

select * from stg_budget