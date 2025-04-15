with order_items as (
    select * from {{ ref('trans_order_items') }}
),

orders as (
    select order_id, customer_id from {{ ref('trans_orders') }}
),

products as (
    select product_id, product_category from {{ ref('trans_products') }}
),

sellers as (
    select seller_id, city as seller_city, state as seller_state from {{ ref('trans_sellers') }}
),

fact_order_items as (
    select
        oi.order_id,
        o.customer_id,
        oi.product_id,
        p.product_category,
        oi.seller_id,
        s.seller_city,
        s.seller_state,
        oi.shipping_limit_ts,
        oi.item_price as item_price,
        oi.freight_value,
        oi.item_price + oi.freight_value as item_total_value
    from {{ ref('stg_order_items') }} oi
    left join orders o on oi.order_id = o.order_id
    left join products p on oi.product_id = p.product_id
    left join sellers s on oi.seller_id = s.seller_id
)

select * from fact_order_items
