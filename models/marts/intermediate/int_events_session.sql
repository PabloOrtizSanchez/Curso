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
        , datediff(minute,min(created_at)::timestamp,max(created_at)::timestamp) as duracion_sesion_minutos
        from stg_sql_server_dbo_events
        where event_type <> 'package_shipped'
        group by session_id
    )
    ,
    paginas_visitadas_sesion as (
      select
       session_id
     , count(page_url) as paginas_visitadas
     from stg_sql_server_dbo_events
     where event_type = 'page_view'
     group by session_id
    )
    ,

    productos_carrito as (
      select
        session_id
      , count(page_url) as productos_al_carrito
      from stg_sql_server_dbo_events
      where event_type = 'add_to_cart'
      group by session_id
    )
    ,

   comprobar_compra as (
     select
     session_id
   , event_type as hace_compra
     from stg_sql_server_dbo_events
     where event_type = 'checkout'
   )
   
    select 
     a.session_id
   , b.duracion_sesion_segundos
   , b.duracion_sesion_minutos
   , c.paginas_visitadas
   , d.productos_al_carrito
   , e.hace_compra
     from stg_sql_server_dbo_events as a
     left join
     tiempo_sesion as b
     on a.session_id = b.session_id
     left join
     paginas_visitadas_sesion as c
     on a.session_id = c.session_id
     left join
     productos_carrito as d
     on a.session_id = d.session_id
     left join
     comprobar_compra as e
     on a.session_id = e.session_id
group by a.session_id, b.duracion_sesion_segundos, b.duracion_sesion_minutos, c.paginas_visitadas, d.productos_al_carrito, e.hace_compra
     
