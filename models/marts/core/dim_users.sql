{{ config(materialized="table") }}

with stg_sql_server_dbo_users as (select * from {{ ref('stg_sql_server_dbo_users') }})
,

dim_users as (

select 

  user_id
, first_name
, last_name
, email
, phone_number
, created_at
, updated_at
, total_orders
, _fivetran_deleted
, _fivetran_synced

from stg_sql_server_dbo_users
)

select * from dim_users