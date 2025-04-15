with orders as (
    select * from {{ ref('trans_orders') }}
),

order_items as (
    select * from {{ ref('trans_order_items') }}
),

payments as (
    select * from {{ ref('trans_payments') }}
),

reviews as (
    select * from {{ ref('trans_review') }}
),

distances as (
    select * from {{ ref('trans_distance') }}
),

fact_orders as (
    select
        o.order_id,
        o.customer_id,
        o.order_status,
        o.order_purchase_ts,
        o.order_approved_ts,
        o.delivered_to_carrier_ts,
        o.delivered_to_customer_ts,
        o.estimated_delivery_ts,
        o.actual_delivery_days,
        o.estimated_delivery_days,
        o.is_delayed,
        oi.total_order_item_value,
        oi.total_freight_value,
        oi.total_order_value,
        p.total_payment_value,
        r.avg_review_score,
        r.total_reviews,
        d.distance_km
    from orders o
    left join order_items oi on o.order_id = oi.order_id
    left join payments p on o.order_id = p.order_id
    left join reviews r on o.order_id = r.order_id
    left join distances d on o.order_id = d.order_id
)

select * from fact_orders
