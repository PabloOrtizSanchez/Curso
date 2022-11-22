{{ config(materialized="view") }}

with orders as (select * from {{ source("sql_server_dbo", "orders") }})

select
    order_id,
    tracking_id,
    address_id,
    promo_id,
    delivered_at,
    order_cost,
    shipping_cost,
    order_total,
    status,
    shipping_service,
    estimated_delivery_at,
    created_at,
    _fivetran_deleted,
    _fivetran_synced
from orders


-- merece la pena ordenar las columnas?
