{{ config(materialized="view") }}

with src_sql_server_dbo_users as (select * from {{ source('sql_server_dbo', 'users') }})
,

base_users as (

select 

  {{ dbt_utils.surrogate_key(['user_id','_fivetran_synced']) }} as user_id
, user_id as user_NK_id
, first_name
, last_name
, email
, phone_number
,  year(created_at)*10000+month(created_at)*100+day(created_at) as created_at_id
,  year(updated_at)*10000+month(updated_at)*100+day(updated_at) as updated_at_id
, _fivetran_deleted
, _fivetran_synced

from src_sql_server_dbo_users
)

select * from base_users