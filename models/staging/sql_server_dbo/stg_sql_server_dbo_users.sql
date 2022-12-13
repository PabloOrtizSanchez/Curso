{{ config(materialized="view") }}

with base_sql_server_dbo_users as (select * from {{ ref('base_sql_server_dbo_users') }})
,

stg_users as (

select 

  user_id
, user_NK_id
, first_name
, last_name
, address_id
, email
, phone_number
, created_at_id
, updated_at_id
, created_at
, updated_at
, _fivetran_deleted
, _fivetran_synced

from base_sql_server_dbo_users
)

select * from stg_users