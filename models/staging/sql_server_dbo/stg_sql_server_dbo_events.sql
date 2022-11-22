{{ config(materialized="view") }}

with
    src_events as (select * from {{ source("sql_server_dbo", "events") }}),

    events as (
        select
            event_id,
            user_id,
            product_id,
            session_id,
            order_id,
            page_url,
            event_type,
            created_at,
            _fivetran_deleted,
            _fivetran_synced
        from src_events
    )

select *
from events
