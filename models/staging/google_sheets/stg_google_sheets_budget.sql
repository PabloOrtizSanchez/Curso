{{ config(materialized="view") }}

with stg_google_sheets_budget as (select * from {{ source("google_sheets", "budget") }})
,

budget as (

select 

  md5(_row) as budget_id
, quantity as cantidad
, month as mes_cierre
, monthname(month) as nombre_mes
, product_id
, _fivetran_synced

from stg_google_sheets_budget
)

select * from budget