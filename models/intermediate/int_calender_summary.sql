-- models/intermediate/int_calendar_summary.sql
with calender as (
  select * from {{ ref('stg_calender') }}
)
select
  listing_id,
  avg(price) as avg_price,
  count(*) as total_days,
  sum(case when available = false then 1 else 0 end) as booked_days,
  round(sum(case when available = false then 1 else 0 end) / nullif(count(*), 0), 2) as occupancy_rate,
  sum(case when available = false then price else 0 end) as estimated_revenue
from calender
group by listing_id