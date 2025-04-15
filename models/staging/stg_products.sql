-- models/staging/stg_products.sql

with source as (
    select * from {{ source('raw', 'olist_products') }}
),

renamed as (
    select
        cast(product_id as string) as product_id,
        cast(product_category_name as string) as category_name,
        cast(product_name_lenght as int) as name_length,
        cast(product_description_lenght as int) as description_length,
        cast(product_photos_qty as int) as photos_qty,
        cast(product_weight_g as float) as weight_g,
        cast(product_length_cm as float) as length_cm,
        cast(product_height_cm as float) as height_cm,
        cast(product_width_cm as float) as width_cm
    from source
)

select * from renamed