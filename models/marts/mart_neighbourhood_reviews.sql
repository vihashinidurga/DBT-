with listings as(
    select listing_id,
    neighbourhood,
    is_superhost,
    price,
    number_of_reviews,
    review_scores_rating
    from {{ ref("stg_listings") }}
    where neighbourhood is not null
),
reviews as(
    select listing_id,
    total_reviews,
    reviews_last_12_months
    from {{ ref("int_reviews_summary") }}
)
select 
l.neighbourhood,
count(distinct l.listing_id) as num_listings,
round(avg(l.review_scores_rating),2) as avg_review_score,
round(avg(l.number_of_reviews),2) as avg_list_reviews,
sum(r.total_reviews) as total_reviews,
sum(r.reviews_last_12_months) as reviews_last_12_months,
round(avg(l.price),2) as avg_price,
sum(case when l.is_superhost = true then 1 else 0 end) as num_superhosts,
from listings l
left join reviews r
on l.listing_id=r.listing_id
group by l.neighbourhood
order by avg_review_score desc