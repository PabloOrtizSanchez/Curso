{% snapshot users_snapshot %}

{{
    config(
      target_schema='snapshots',
      unique_key='user_NK_id',
      strategy='timestamp',
      updated_at='_fivetran_synced',
      invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('dim_users') }}

{% endsnapshot %}