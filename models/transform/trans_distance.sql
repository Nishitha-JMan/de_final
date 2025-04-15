with aggregated_geolocation as (
    -- Pre-aggregate geolocation data to reduce the number of rows processed
    select
        g.zip_code_prefix,
        avg(g.latitude) as latitude,
        avg(g.longitude) as longitude
    from {{ ref('stg_geolocation') }} g
    group by g.zip_code_prefix
),
customers as (
    select
        c.customer_id,
        c.customer_unique_id,
        g.latitude as customer_lat,
        g.longitude as customer_lng
    from {{ ref('stg_customers') }} c
    left join aggregated_geolocation g
    on c.zip_code_prefix = g.zip_code_prefix
),
sellers as (
    select
        s.seller_id,
        s.zip_code_prefix,
        g.latitude as seller_lat,
        g.longitude as seller_lng
    from {{ ref('stg_sellers') }} s
    left join aggregated_geolocation g
    on s.zip_code_prefix = g.zip_code_prefix
),
orders as (
    select
        o.order_id,
        o.customer_id
    from {{ ref('stg_orders') }} o
),
customer_seller_distance as (
    select
        oi.order_id,
        c.customer_id,
        oi.seller_id,
        -- Use the haversine macro to calculate distance in kilometers
        {{ haversine('c.customer_lat', 'c.customer_lng', 's.seller_lat', 's.seller_lng') }} as distance_km
    from {{ ref('stg_order_items') }} oi
    join orders o on oi.order_id = o.order_id
    join customers c on o.customer_id = c.customer_id
    join sellers s on oi.seller_id = s.seller_id
    {% if is_incremental() %}
    where oi.updated_at >= (current_date - interval '1 day')  -- Process only new or updated rows
    {% endif %}
)
select * from customer_seller_distance