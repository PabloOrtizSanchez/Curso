{{ config(materialized="view") }}

with
    stg_sql_server_dbo_events as (select * from {{ ref("stg_sql_server_dbo_events") }})
    ,
    stg_sql_server_dbo_users as (select * from {{ ref("stg_sql_server_dbo_users") }})
    ,


    pedidos_web_usuarios as (
        select 
          b.user_NK_id
        , count(a.order_id) as numero_pedidos_web
        from stg_sql_server_dbo_events as a
        left join
        stg_sql_server_dbo_users as b
        on a.user_id = b.user_id
        where order_id != '' and a.event_type = 'checkout'
        group by b.user_NK_id
    )

    select * from pedidos_web_usuarios

