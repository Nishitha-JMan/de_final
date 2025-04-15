with customers as (
    select * from {{ ref('stg_customers') }}
),
geolocation as (
    select
        zip_code_prefix,
        latitude,
        longitude
    from {{ ref('stg_geolocation') }}
),
enriched_customers as (
    select
        c.customer_id,
        c.customer_unique_id,
        c.zip_code_prefix,
        g.latitude,
        g.longitude,
        c.city,
        c.states
    from customers c
    left join geolocation g
    on c.zip_code_prefix = g.zip_code_prefix
)
select * from enriched_customers