{{ config(materialized="view") }}

with
    int_events as (select * from {{ ref("stg_sql_server_dbo_events") }}),


    pedidos_usuarios as (
        select 
          user_nk_id
        , count(order_id) as numero_pedidos
        from int_events
        where order_id != ''
        group by user_nk_id
    )

    select * from pedidos_usuarios
/*,
cuenta_pedidos as (
   select 
     count(user_NK_id) as usuarios_totales
   , numero_pedidos
   from pedidos_usuarios
   group by numero_pedidos
)

select *
from cuenta_pedidos
order by numero_pedidos*/
