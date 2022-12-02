{{ config(materialized="view") }}

with src_sql_server_dbo_orders as (select * from {{ source("sql_server_dbo", "orders") }})
,

base_orders as (
  select

      {{ dbt_utils.surrogate_key(['order_id', '_fivetran_synced']) }} as order_id
    , order_id as order_NK_id
    , address_id as shipping_address_id
    , promo_id
    , user_id
    , tracking_id
    , status
    , year(cast(delivered_at as date))*10000+month(cast(delivered_at as date))*100+day(cast(delivered_at as date)) as delivered_at_id
    , year(cast(estimated_delivery_at as date))*10000+month(cast(estimated_delivery_at as date))*100+day(cast(estimated_delivery_at as date)) as estimated_delivery_at_id
    , order_cost
    , shipping_cost
    , order_total
    , shipping_service
    , year(cast(created_at as date))*10000+month(cast(created_at as date))*100+day(cast(created_at as date)) as created_at_id
    , _fivetran_deleted
    , _fivetran_synced

from src_sql_server_dbo_orders

)

select * from base_orders