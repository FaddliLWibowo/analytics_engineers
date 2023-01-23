{{ config (materialized="view") }}

with produk as (
    select product_id, name, description, price from raw_products
)

select * from produk