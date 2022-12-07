{{
   config(materialized="incremental",
unique_key = 'event_NK_id'
) 
}}

with stg_sql_server_dbo_orders_items as (select * from {{ ref('stg_sql_server_dbo_orders_items') }})
,

fact_order_details as (
  
  select
   order_details_id
 , order_details_NK_id
 , user_id
 , product_id
 , order_id
 , quantity
 , price_USD
 , quantity * price_USD as total_price_USD
 , shipping_service
 , created_at_id
 , _fivetran_deleted
 , _fivetran_synced

from stg_sql_server_dbo_orders_items
)

select * from fact_order_details

{% if is_incremental() %}

  where _fivetran_synced > (select max(_fivetran_synced) from {{ this }})

{% endif %}