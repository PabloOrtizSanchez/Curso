{{
   config(materialized="incremental",
unique_key = 'user_NK_id'
) 
}}

with stg_sql_server_dbo_users as (select * from {{ ref('stg_sql_server_dbo_users') }})
,
int_events as (select * from {{ ref('int_events') }})
,
stg_sql_server_dbo_shipping_addresses as (select * from {{ ref('stg_sql_server_dbo_shipping_addresses') }})
,

dim_users as (

select 

  user_id
, a.user_NK_id
, first_name
, last_name
, c.country
, c.state
, c.primary_city
, c.zipcode
, c.address
, email
, phone_number
, numero_pedidos
, created_at_id
, updated_at_id
, created_at
, updated_at
, a._fivetran_deleted
, a._fivetran_synced


from stg_sql_server_dbo_users as a
left join
int_events as b
on a.user_NK_id = b.user_NK_id
left join
stg_sql_server_dbo_shipping_addresses as c
on a.address_id = c.shipping_address_NK_id
)

select * from dim_users

{% if is_incremental() %}

  where _fivetran_synced > (select max(_fivetran_synced) from {{ this }})

{% endif %}

-- Cuidado, por el snapshot en users, la suma de pedidos será desde la última vez que se actualizó el usuario. 
-- ARREGLADO lo de arriba, he hecho el group by por user_NK_id en int_events para que no tenga en cuenta las actualizaciones.

--para hacer que en las celdas vacias ponga 0 como se hace