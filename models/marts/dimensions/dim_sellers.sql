with sellers as (
    select * from {{ ref('trans_sellers') }}
),

dim_sellers as (
    select
        seller_id,
        zip_code_prefix,
        latitude,
        longitude,
        city as seller_city,
        state as seller_state
    from sellers
)

select * from dim_sellers
