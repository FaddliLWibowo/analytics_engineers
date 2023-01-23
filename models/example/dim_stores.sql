{{ config (materialized="view") }}

with store as (
    select store_id, city, country from raw_stores
)

select * from store