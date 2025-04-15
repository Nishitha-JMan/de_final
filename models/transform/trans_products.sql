with products as (
    select * from {{ ref('stg_products') }}
),
category_translation as (
    select * from {{ ref('stg_category_translation') }}
),
transformed_products as (
    select
        p.product_id,
        t.category_name_english as product_category,
        p.weight_g,
        p.length_cm,
        p.height_cm,
        p.width_cm,
        p.length_cm * p.width_cm * p.height_cm as product_volume_cm3
    from products p
    left join category_translation t
    on p.category_name = t.category_name
)
select * from transformed_products