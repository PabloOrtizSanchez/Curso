{{ config(materialized="view") }}

with budget as (select * from {{ source("google_sheets", "budget") }})

select 

  md5(_row) as budget_id
, quantity
, month
, product_id
, _fivetran_synced

from budget
