{{ config (materialized="view") }}

with product as (
    select product_id, name, description, price from raw_products
)

select * from product