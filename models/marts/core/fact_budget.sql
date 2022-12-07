{{
   config(materialized="incremental",
unique_key = 'budget_NK_id'
) 
}}
 

with stg_google_sheets_budget as (select * from {{ ref('stg_google_sheets_budget') }})
,

fact_budget as (

select  
  budget_id
, budget_NK_id
, product_id
, quantity as quantity_to_sell
, month_id
, _fivetran_synced

from stg_google_sheets_budget
)

select * from fact_budget


{% if is_incremental() %}

  where _fivetran_synced > (select max(_fivetran_synced) from {{ this }})

{% endif %}