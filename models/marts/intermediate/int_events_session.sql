{{ config(materialized="view") }}

with
    stg_sql_server_dbo_events as (select * from {{ ref("stg_sql_server_dbo_events") }})
    ,

    tiempo_sesion as (
        select
          session_id
        , max(created_at)
        , min(created_at)
        , datediff(second,min(created_at)::timestamp,max(created_at)::timestamp) as duracion_sesion_segundos
        from stg_sql_server_dbo_events
        where event_type <> 'package_shipped'
        group by session_id
    )

    select * from tiempo_sesion