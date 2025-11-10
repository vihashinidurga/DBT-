with src as (
  select * from {{ source('raw','listings') }}
)

select
  id as listing_id,
  listing_url,
  scrape_id,
  try_cast(last_scraped as timestamp) as last_scraped,
  source,
  name,
  description,
  neighborhood_overview,
  host_id,
  host_name,
  cast(host_since as date) as host_since,
  host_location,
  -- price cleaning macro
  {{ clean_price('price') }} as price,
  coalesce(cast(accommodates as int), null) as accommodates,
  coalesce(cast(bathrooms as float), null) as bathrooms,
  coalesce(cast(bedrooms as int), null) as bedrooms,
  coalesce(cast(beds as int), null) as beds,
  lower(room_type) as room_type,
  neighbourhood_cleansed as neighbourhood,
  latitude::float as latitude,
  longitude::float as longitude,
  case when host_is_superhost in ('t','true','True') then true else false end as is_superhost,
  number_of_reviews::int as number_of_reviews,
  review_scores_rating::float as review_scores_rating
from src
