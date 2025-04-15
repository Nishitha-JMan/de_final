-- models/staging/stg_geolocation.sql

with source as (
    select * from {{ source('raw', 'olist_geolocation') }}
),

renamed as (
    select
        cast(geolocation_zip_code_prefix as string) as zip_code_prefix,
        cast(geolocation_lat as float) as latitude,
        cast(geolocation_lng as float) as longitude,
        lower(geolocation_city) as city,
        upper(geolocation_state) as state
    from source
)

select * from renamed