with src as (
  select * from {{ source('raw','reviews') }}
)

select
  id as review_id,
  listing_id::int as listing_id,
  try_cast(date as date) as review_date,
  reviewer_id,
  reviewer_name,
  comments
from src
