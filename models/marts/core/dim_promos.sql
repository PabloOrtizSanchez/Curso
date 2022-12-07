{{
   config(materialized="incremental",
unique_key = 'promo_NK_id'
) 
}}

with stg_sql_server_dbo_promos as (select * from {{ ref('stg_sql_server_dbo_promos') }})
,

dim_promos as (
  
  select

      promo_id
    , promo_NK_id as name_promo
    , discout_USD
    , status
    , _fivetran_deleted
    , _fivetran_synced
    , dbt_valid_from
    , dbt_valid_to

from stg_sql_server_dbo_promos
)

select * from dim_promos

{% if is_incremental() %}

  where _fivetran_synced > (select max(_fivetran_synced) from {{ this }})

{% endif %}