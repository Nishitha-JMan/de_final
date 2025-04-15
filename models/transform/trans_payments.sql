with payments as (
    select * from {{ ref('stg_order_payments') }}
),
transformed_payments as (
    select
        order_id,
        payment_type,
        sum(payment_value) as total_payment_value,
        count(payment_sequence) as payment_count
    from payments
    group by order_id, payment_type order by payment_count desc
)
select * from transformed_payments