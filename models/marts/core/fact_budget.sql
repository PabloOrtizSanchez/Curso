{{ config(materialized="table") }}

with stg_google_sheets_budget as (select * from {{ ref('stg_google_sheets_budget') }})
,


dim_budget as (

select 

  budget_id
, year(mes_cierre)*10000+month(mes_cierre)*100 as date_mes_id
, mes_cierre
, cantidad
, product_id
, _fivetran_synced

from stg_google_sheets_budget
)

select * from dim_budget