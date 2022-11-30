
{{ config(materialized="table") }}

with stg_sql_server_dbo_events as (select * from {{ ref('stg_sql_server_dbo_events') }})
,


dim_events as (
  select

      event_id
    , user_id
    , product_id
    , session_id
    , order_id
    , year(created_at)*10000+month(created_at)*100+day(created_at) as created_at_date_dia_id
    , page_url
    , tipo_evento
    , _fivetran_deleted
    , _fivetran_synced

from stg_sql_server_dbo_events
)

select * from dim_events

