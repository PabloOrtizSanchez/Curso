{{ config(materialized="view") }}

with orders as (select * from {{ source("sql_server_dbo", "orders") }})

select

      md5(order_id) as order_id
    , md5(tracking_id) as tracking_id
    , md5(address_id) as address_id
    , md5(promo_id) as promo_id
    , status, delivered_at
    , estimated_delivery_at
    , order_cost, shipping_cost
    , order_total, shipping_service
    , created_at, _fivetran_deleted
    , _fivetran_synced

from orders


-- merece la pena ordenar las columnas?
