with order_items as (
    select * from {{ ref('stg_order_items') }}
),
transformed_order_items as (
    select
        order_id,
        sum(item_price) as total_order_item_value,
        sum(freight_value) as total_freight_value, 
        sum(item_price) + sum(freight_value) as total_order_value 
    from order_items
    group by order_id
)
select * from transformed_order_items