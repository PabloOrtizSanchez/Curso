{{ config(materialized="table") }}

with int_events_session as (select * from {{ ref("int_events_session") }})


select * from int_events_session