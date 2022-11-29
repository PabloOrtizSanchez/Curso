
{{ config(materialized="table") }}

with stg_sql_server_dbo_events as (select * from {{ ref('stg_sql_server_dbo_events') }})
,
dim_tiempo_dia as (select * from {{ ref('dim_tiempo_dia') }})
,

dim_events as (
  select

      event_id
    , user_id
    , product_id
    , session_id
    , order_id
    , page_url
    , tipo_evento
    , created_at
    , id_date_dia
    , _fivetran_deleted
    , _fivetran_synced

from stg_sql_server_dbo_events as a
join dim_tiempo_dia as b
on a.created_at = b.fecha_forecast
)

select * from dim_events

