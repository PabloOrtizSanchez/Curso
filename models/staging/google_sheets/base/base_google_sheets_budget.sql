{{ config(materialized="view") }}

with src_google_sheets_budget as (select * from {{ source("google_sheets", "budget") }})
,

base_budget as (

select  
 {{ dbt_utils.surrogate_key(['_row', '_fivetran_synced']) }} as budget_id
, _row as budget_NK_id
, product_id
, quantity
, year(month)*10000+month(month)*100 as month_id
, _fivetran_synced

from src_google_sheets_budget
)

select * from base_budget