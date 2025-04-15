with product_sales as (
    select
        p.product_id,
        ct.category_name_english,
        count(oi.order_item_number) as total_sold
    from {{ ref('stg_products') }} p
    join {{ ref('stg_order_items') }} oi
        on p.product_id = oi.product_id
    join {{ ref('stg_category_translation') }} ct
        on p.category_name = ct.category_name
    group by p.product_id, ct.category_name_english
)
select
    product_id,
    category_name_english as category_name,
    total_sold
from product_sales
order by total_sold desc