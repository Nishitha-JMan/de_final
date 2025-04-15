-- models/staging/stg_orders.sql

with source as (
    select * from {{ source('raw', 'olist_orders') }}
),

renamed as (
    select
        cast(order_id as string) as order_id,
        cast(customer_id as string) as customer_id,
        cast(order_purchase_timestamp as timestamp) as order_purchase_ts,
        cast(order_approved_at as timestamp) as order_approved_ts,
        cast(order_delivered_carrier_date as timestamp) as delivered_to_carrier_ts,
        cast(order_delivered_customer_date as timestamp) as delivered_to_customer_ts,
        cast(order_estimated_delivery_date as timestamp) as estimated_delivery_ts,
        lower(order_status) as order_status
    from source
)

select * from renamed