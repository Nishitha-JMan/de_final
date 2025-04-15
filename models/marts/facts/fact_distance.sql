-- models/mart/facts/fact_distance.sql

with customer_seller_distance as (
    select * from {{ ref('trans_distance') }}
),
orders as (
    select
        order_id,
        order_purchase_ts
    from {{ ref('trans_orders') }}
)
select
    csd.order_id,
    o.order_purchase_ts,
    csd.customer_id,
    csd.seller_id,
    csd.distance_km
from customer_seller_distance csd
left join orders o on csd.order_id = o.order_id
