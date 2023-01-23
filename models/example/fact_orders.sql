{{ config (materialized="table") }}

with 
    customer as (select * from {{ ref("dim_customers") }}),
    dates as (select * from {{ ref("dim_dates") }}),
    product as (select * from {{ ref("dim_products") }}),
    orders as (
        select
            customer_id,
            date_id,
            b.product_id,
            sum(quantity * b.price) as amount,
            sum(quantity) as quantity,
            count(a.order_id) as number_of_orders
        from raw_order a
        left join raw_order_items b on (a.order_id = b.order_id)
        left join dates c on (date(a.transaction_date) = c.date)
        left join product d on (b.product_id = d.product_id)
        group by customer_id, date_id, b.product_id
    ),
    final as (
        select * from orders
    )

select * from final