-- models/staging/stg_order_reviews.sql

with source as (
    select * from {{ source('raw', 'olist_order_reviews') }}
),

renamed as (
    select
        cast(review_id as string) as review_id,
        cast(order_id as string) as order_id,
        cast(review_score as int) as review_score,
        review_comment_title,
        review_comment_message,
        cast(review_creation_date as date) as review_created_date,
        cast(review_answer_timestamp as timestamp) as review_answered_ts
    from source
)

select * from renamed