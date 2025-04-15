-- models/staging/stg_product_category_translation.sql
with source as (
    select * from {{ source('raw', 'PRODUCT_CATEGORY_TRANSLATION') }}
),

renamed as (
    select
        lower(product_category_name) as category_name,
        lower(product_category_name_english) as category_name_english
    from source
)

select * from renamed