{% snapshot orders_tracking_snapshot %}

{{
    config(
      target_schema='snapshots',
      unique_key='order_tracking_NK_id',
      strategy='timestamp',
      updated_at='_fivetran_synced',
    )
}}

select * from {{ ref('fact_orders_tracking') }}

{% endsnapshot %}