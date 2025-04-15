-- models/staging/stg_sellers.sql

with source as (
    select * from {{ source('raw', 'olist_sellers') }}
),

renamed as (
    select
        cast(seller_id as string) as seller_id,
        cast(seller_zip_code_prefix as string) as zip_code_prefix,
        lower(seller_city) as city,
        upper(seller_state) as state
    from source
)

select * from renamed