with listings as(
    select listing_id,name, host_id, neighbourhood, room_type
    from {{ ref('stg_listings') }}
),
calender_summary as (
    select * from {{ ref('int_calender_summary') }}
)
select
l.listing_id,
l.name,
l.neighbourhood as neighbourhood,
l.room_type,
calender_summary.avg_price,
calender_summary.occupancy_rate,
calender_summary.estimated_revenue
from listings l
join calender_summary
on l.listing_id = calender_summary.listing_id
order by calender_summary.estimated_revenue desc