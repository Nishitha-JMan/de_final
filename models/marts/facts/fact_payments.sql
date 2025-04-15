-- models/mart/facts/fact_payments.sql

with payments as (
    select * from {{ ref('trans_payments') }}
),
orders as (
    select
        order_id,
        order_purchase_ts
    from {{ ref('trans_orders') }}
)
select
    p.order_id,
    o.order_purchase_ts,
    p.payment_type,
    p.total_payment_value,
    p.payment_count
from payments p
left join orders o on p.order_id = o.order_id
