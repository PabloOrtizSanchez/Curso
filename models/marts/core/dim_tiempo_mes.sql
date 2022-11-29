
{{ config(materialized="table") }}

with dim_tiempo_dia as (select * from {{ ref('dim_tiempo_dia') }})
,

dim_tiempo_mes as (
    select
      id_date_mes
    , anio
    , mes
    , desc_mes
from dim_tiempo_dia
group by id_date_mes,mes,anio,desc_mes
order by id_date_mes
)

select * from dim_tiempo_mes

-- AÑADIR UNA COLUMNA CON LA FECHA ENAÑO-MES