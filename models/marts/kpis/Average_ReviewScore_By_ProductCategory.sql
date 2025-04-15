with category_reviews as (
    select
        ct.category_name_english as category_name,
        r.review_score
    from {{ ref('stg_products') }} p
    join {{ ref('stg_order_items') }} oi
        on p.product_id = oi.product_id
    join {{ ref('stg_order_reviews') }} r
        on oi.order_id = r.order_id
    join {{ ref('stg_category_translation') }} ct
        on p.category_name = ct.category_name
)
select
    category_name,
    avg(review_score) as avg_review_score
from category_reviews
group by category_name
order by avg_review_score desc