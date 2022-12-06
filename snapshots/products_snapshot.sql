{% snapshot products_snapshot %}

{{
    config(
      target_schema='snapshots',
      unique_key='product_NK_id',
      strategy='timestamp',
      updated_at='_fivetran_synced',
    )
}}

select * from {{ ref('stg_sql_server_dbo_products') }}

{% endsnapshot %}