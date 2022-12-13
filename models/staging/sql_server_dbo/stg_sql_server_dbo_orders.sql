{{ config(materialized="view") }}

with base_sql_server_dbo_orders as (select * from {{ ref('base_sql_server_dbo_orders') }})
,
base_sql_server_dbo_shipping_addresses as (select * from {{ ref('base_sql_server_dbo_shipping_addresses') }})
,
base_sql_server_dbo_promos as (select * from {{ ref('base_sql_server_dbo_promos') }})
,
base_sql_server_dbo_users as (select * from {{ ref('base_sql_server_dbo_users') }})
,

stg_orders as (

  select

      a.order_id as order_tracking_id
    , a.order_NK_id as order_tracking_NK_id
    , b.shipping_address_id
    , c.promo_id
    , d.user_id
    , a.tracking_id
    , a.status
    , a.delivered_at_id
    , a.estimated_delivery_at_id
    , a.delivered_at
    , a.estimated_delivery_at
    , order_cost as order_cost_USD
    , shipping_cost as shipping_cost_USD
    , order_total as order_total_USD
    , shipping_service
    , a.created_at_id
    , a.created_at
    , a._fivetran_deleted
    , a._fivetran_synced

from base_sql_server_dbo_orders as a
left join
base_sql_server_dbo_shipping_addresses as b
on a.shipping_address_id = b.shipping_address_NK_id
left join base_sql_server_dbo_promos as c
on a.promo_id = c.promo_NK_id
left join base_sql_server_dbo_users as d
on a.user_id = d.user_NK_id

)

select * from stg_orders
order by order_tracking_NK_id