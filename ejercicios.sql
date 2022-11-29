

with events as
(
    select * from {{ ref('stg_sql_server_dbo_events') }}
),

sesion as (
    select hour(created_at) as created_hour,
count (distinct session_id) as sesion_unica
 from events
 group by (1)

