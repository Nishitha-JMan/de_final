with monthly_revenue as (
    select
        date_trunc('month', o.order_purchase_ts) as order_month,
        sum(oi.item_price) as total_revenue
    from {{ ref('stg_orders') }} o
    join {{ ref('stg_order_items') }} oi
        on o.order_id = oi.order_id
    group by date_trunc('month', o.order_purchase_ts)
)
select
    order_month,
    total_revenue
from monthly_revenue
order by order_month