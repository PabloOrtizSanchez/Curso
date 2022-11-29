{{ config(materialized="table") }}

with stg_google_sheets_budget as (select * from {{ ref('stg_google_sheets_budget') }})
,
dim_tiempo_mes as (select * from {{ ref('dim_tiempo_mes') }})
,

dim_budget as (

select 

  budget_id
, id_date_mes
, cantidad
, a.mes
, product_id
, _fivetran_synced

from stg_google_sheets_budget as a
 join dim_tiempo_mes as b
on a.mes = b.mes
)

select * from dim_budget