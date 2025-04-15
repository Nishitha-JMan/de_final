with payment_methods as (
    select
        p.payment_type,
        count(p.payment_type) as payment_count,
        sum(p.payment_value) as total_payment_value
    from {{ ref('stg_order_payments') }} p
    group by p.payment_type
)
select
    payment_type,
    payment_count,
    total_payment_value
from payment_methods
order by payment_count desc