
{{
   config(materialized="incremental",
unique_key = 'order_tracking_NK_id'
) 
}}

with

stg_sql_server_dbo_orders as (select * from {{ ref('stg_sql_server_dbo_orders') }})
,



fact_orders_tracking as (
  
  select

      order_tracking_id
    , order_tracking_NK_id
    , shipping_address_id
    , user_id
    , tracking_id
    , promo_id
    , created_at_id
    , created_at
    , shipping_service
    , estimated_delivery_at_id
    , delivered_at_id
    , estimated_delivery_at
    , delivered_at
    , status
    , order_cost_USD
    , shipping_cost_USD
    , order_total_USD
    , _fivetran_deleted
    , _fivetran_synced

from stg_sql_server_dbo_orders
)

select * from fact_orders_tracking


{% if is_incremental() %}

  where _fivetran_synced > (select max(_fivetran_synced) from {{ this }})

{% endif %}