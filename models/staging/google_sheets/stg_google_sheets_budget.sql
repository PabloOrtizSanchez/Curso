{{ config(materialized="view") }}

with src_google_sheets_budget as (select * from {{ source("google_sheets", "budget") }})
,
stg_sql_server_dbo_products as (select * from {{ ref('stg_sql_server_dbo_products') }})
,

stg_budget as (

select  
 {{ dbt_utils.surrogate_key(['_row', 'a._fivetran_synced']) }} as budget_id
, _row as budget_NK_id
, b.product_id
, quantity
, year(month)*10000+month(month)*100 as month_id
, a._fivetran_synced

from src_google_sheets_budget as a
join
stg_sql_server_dbo_products as b
on a.product_id = b.product_NK_id
)

select * from stg_budget