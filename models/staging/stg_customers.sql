-- models/staging/stg_customers.sql

with source as (
    select * from {{ source('raw', 'olist_customers') }}
),

renamed as (
    select
        cast(customer_id as string) as customer_id,
        cast(customer_unique_id as string) as customer_unique_id,
        cast(customer_zip_code_prefix as string) as zip_code_prefix,
        cast(customer_city as string) as city,
        cast(customer_state as string) as states
    from source
)

select * from renamed