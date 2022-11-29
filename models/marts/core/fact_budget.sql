{{ config(materialized="table") }}

with stg_google_sheets_budget as (select * from {{ ref('stg_google_sheets_budget') }})
,
dim_tiempo_mes as (select * from {{ ref('dim_tiempo_mes') }})
,

dim_budget as (

select 

  budget_id
, quantity
, month -- esta columna deberia pasarla a mes como tal
, product_id
, _fivetran_synced

from stg_google_sheets_budget
)

select * from dim_budget

-- Necesito haceer join y añadir id_date_mes? o lo dejo asi y se une a través de month?