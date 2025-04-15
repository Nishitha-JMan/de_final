-- models/staging/stg_order_payments.sql

with source as (
    select * from {{ source('raw', 'olist_order_payments') }}
),

renamed as (
    select
        cast(order_id as string) as order_id,
        cast(payment_sequential as int) as payment_sequence,
        cast(payment_installments as int) as installments,
        cast(payment_value as float) as payment_value,
        lower(payment_type) as payment_type
    from source
)

select * from renamed