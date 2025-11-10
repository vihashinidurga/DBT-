with reviews as(
    select * from {{ ref("stg_reviews") }}
),
reviews_enriched as (
    select listing_id,
    review_date,
    case when review_date >= dateadd(year, -1, current_date()) then 1 else 0 end as is_recent_review
    from reviews
),
aggregated as (
    select listing_id,
    count(*) as total_reviews,
    sum(is_recent_review) as reviews_last_12_months,
    min(review_date) as first_review_date,
    max(review_date) as latest_review_date,
    datediff('day', min(review_date), max(review_date)) as review_period_days,
    case when datediff('day', min(review_date), max(review_date)) > 0
    then round(count(*) / nullif(datediff('day', min(review_date), max(review_date)) / 30.0, 0), 2)
    else null end as avg_reviews_per_month
    from reviews_enriched
    group by listing_id
)
select * from aggregated
