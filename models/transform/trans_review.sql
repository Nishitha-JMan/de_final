with reviews as (
    select * from {{ ref('stg_order_reviews') }}
),
transformed_reviews as (
    select
        order_id,
        avg(review_score) as avg_review_score,
        count(review_id) as total_reviews
    from reviews
    group by order_id
)
select * from transformed_reviews