with sellers as (
    select * from  {{ref('stg_sellers') }}
),
geolocation as (
    select
        zip_code_prefix,
        latitude,
        longitude
    from  {{ref('stg_geolocation')}} 
),
enriched_sellers as (
    select
        s.seller_id,
        s.zip_code_prefix,
        g.latitude,
        g.longitude,
        s.city,
        s.state
    from sellers s
    left join geolocation g
    on s.zip_code_prefix = g.zip_code_prefix
)
select * from enriched_sellers