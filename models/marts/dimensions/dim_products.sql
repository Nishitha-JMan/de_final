with products as (
    select * from {{ ref('trans_products') }}
),

dim_products as (
    select
        product_id,
        product_category,
        weight_g,
        length_cm,
        height_cm,
        width_cm,
        product_volume_cm3
    from products
)

select * from dim_products
