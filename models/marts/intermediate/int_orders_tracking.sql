{{ config(materialized="view") }}

with
    stg_sql_server_dbo_orders as (select * from {{ ref("stg_sql_server_dbo_orders") }})
    ,
    stg_sql_server_dbo_users as (select * from {{ ref("stg_sql_server_dbo_users") }})
    ,

    numero_pedidos as (
        select
          b.user_NK_id
        , count(a.order_tracking_id) as numero_total_pedidos
        from stg_sql_server_dbo_orders as a
        left join
        stg_sql_server_dbo_users as b
        on a.user_id = b.user_id
        group by user_NK_id
    )

    select * from numero_pedidos