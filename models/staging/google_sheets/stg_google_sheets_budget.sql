{{ config(materialized="view") }}

with stg_google_sheets_budget as (select * from {{ source("google_sheets", "budget") }})
,

budget as (

select 

  md5(_row) as budget_id
, quantity
, month
, product_id
, _fivetran_synced

from stg_google_sheets_budget
)

select * from budget