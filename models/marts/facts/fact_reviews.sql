with reviews as (
    select * from {{ ref('trans_review') }}
),

orders as (
    select order_id, customer_id, order_purchase_ts from {{ ref('trans_orders') }}
),

fact_reviews as (
    select
        r.order_id,
        o.customer_id,
        o.order_purchase_ts,
        r.avg_review_score,
        r.total_reviews,
        -- Review label (can be used for classification models later)
        case
            when r.avg_review_score >= 4 then 'positive'
            when r.avg_review_score = 3 then 'neutral'
            else 'negative'
        end as review_sentiment
    from reviews r
    left join orders o on r.order_id = o.order_id
)

select * from fact_reviews
