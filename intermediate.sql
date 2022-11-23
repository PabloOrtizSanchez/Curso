with fact_events as (
    select *
    from {{ ref('stg_sql_server_dbo_events')}}
),

int_sesion_events_users as (
    select
    session_id
    , created_at
    , user_id
    , product_id
    , {{column_values_to_metrics(ref('stg_sql_server_dbo_events'),'event_type')}}
    from fact_events

group by 1, 2, 3, 4

)

select *from