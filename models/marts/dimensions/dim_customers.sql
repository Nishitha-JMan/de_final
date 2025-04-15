with customers as (
    select * from {{ ref('trans_customers') }}
),

dim_customers as (
    select
        customer_id,
        customer_unique_id,
        zip_code_prefix,
        latitude,
        longitude,
        city as customer_city,
        states as customer_state
    from customers
)

select * from dim_customers
