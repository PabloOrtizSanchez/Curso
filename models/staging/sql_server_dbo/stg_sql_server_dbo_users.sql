{{ config(materialized="view") }}

with stg_sql_server_dbo_users as (select * from {{ source("sql_server_dbo", "users") }})
,

users as (

select 

md5(user_id) as user_id
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

select * from users