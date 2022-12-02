{{ config(materialized="view") }}

with src_sql_server_dbo_users as (select * from {{ source("sql_server_dbo", "users") }})
,

users as (

select 

  md5(user_id) as user_id
, first_name as nombre
, last_name as apellido
, email
, phone_number
, created_at
, updated_at
, _fivetran_deleted
, _fivetran_synced

from src_sql_server_dbo_users
)

select * from users