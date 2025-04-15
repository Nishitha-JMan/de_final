with orders as (
    select * from {{ ref('stg_orders') }}
),
transformed_orders as (
    select
        order_id,
        customer_id,
        order_status,
        order_purchase_ts,
        order_approved_ts,
        delivered_to_carrier_ts,
        delivered_to_customer_ts,
        estimated_delivery_ts,
        datediff(day, order_purchase_ts, delivered_to_customer_ts) as actual_delivery_days,
        datediff(day, order_purchase_ts, estimated_delivery_ts) as estimated_delivery_days,
        case
            when delivered_to_customer_ts > estimated_delivery_ts then 1
            else 0
        end as is_delayed,
        year(order_purchase_ts) as order_year,
        month(order_purchase_ts) as order_month,
        day(order_purchase_ts) as order_day
    from orders
)
select * from transformed_orders