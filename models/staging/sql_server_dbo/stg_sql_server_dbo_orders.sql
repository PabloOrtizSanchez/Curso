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

      a.order_id
    , a.order_id as order_NK_id
    , b.shipping_address_id
    , c.promo_id
    , d.user_id
    , a.tracking_id
    , a.status
    , year(cast(a.delivered_at as date))*10000+month(cast(a.delivered_at as date))*100+day(cast(a.delivered_at as date)) as delivered_at_id
    , year(cast(a.estimated_delivery_at as date))*10000+month(cast(a.estimated_delivery_at as date))*100+day(cast(a.estimated_delivery_at as date)) as estimated_delivery_at_id
    , order_cost
    , shipping_cost
    , order_total
    , shipping_service
    , year(cast(a.created_at as date))*10000+month(cast(a.created_at as date))*100+day(cast(a.created_at as date)) as created_at_id
    , a._fivetran_deleted
    , a._fivetran_synced

from base_sql_server_dbo_orders as a
join
base_sql_server_dbo_shipping_addresses as b
on a.shipping_address_id = b.shipping_address_NK_id
join base_sql_server_dbo_promos as c
on a.promo_id = c.promo_NK_id
join base_sql_server_dbo_users as d
on a.user_id = d.user_NK_id

)

select * from stg_orders

