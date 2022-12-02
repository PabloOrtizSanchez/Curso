
{{ config(materialized="table") }}

with dim_tiempo_dia as (select * from {{ ref('dim_tiempo_dia') }})
,

dim_tiempo_mes as (
    select
      date_mes_id
    , anio
    , mes
    , desc_mes
from dim_tiempo_dia
group by date_mes_id,mes,anio,desc_mes
order by date_mes_id
)

select * from dim_tiempo_mes
