with delivery_metrics as (
    select
        o.order_id,
        case
            when o.delivered_to_customer_ts > o.estimated_delivery_ts then 1
            else 0
        end as is_delayed
    from {{ ref('stg_orders') }} o
)
select
    sum(is_delayed) as total_delayed_orders,
    count(order_id) as total_orders,
    (sum(is_delayed) * 100.0 / count(order_id)) as delayed_percentage
from delivery_metrics