{{ config(materialized="view") }}

with users as (select * from {{ source("sql_server_dbo", "users") }})

select 

  md5(user_id) as user_id
, first_name
, last_name
, email
, phone_number
, created_at
, updated_at
, total_orders
, fivetran_deleted
, _fivetran_synced

from users
