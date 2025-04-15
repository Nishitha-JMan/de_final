-- models/staging/stg_order_items.sql

with source as (
    select * from {{ source('raw', 'olist_order_items') }}
),

renamed as (
    select
        cast(order_id as string) as order_id,
        cast(order_item_id as int) as order_item_number,
        cast(product_id as string) as product_id,
        cast(seller_id as string) as seller_id,
        cast(shipping_limit_date as timestamp) as shipping_limit_ts,
        cast(price as float) as item_price,
        cast(freight_value as float) as freight_value
    from source
)

select * from renamed