-- filepath: d:\DE_FINAL\de_final\models\marts\kpis\Top_customer_by_revenue.sql
with customer_revenue as (
    select
        c.customer_unique_id,
        sum(oi.item_price) as total_revenue
    from {{ ref('stg_customers') }} c
    join {{ ref('stg_orders') }} o
        on c.customer_id = o.customer_id
    join {{ ref('stg_order_items') }} oi
        on o.order_id = oi.order_id
    group by c.customer_unique_id
)
select
    customer_unique_id,
    total_revenue
from customer_revenue
order by total_revenue desc