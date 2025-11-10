with listings as(
    select listing_id, host_id, name,is_superhost
    from {{ ref("stg_listings") }}
),
calender_summary as(
    select * from {{ ref("int_calender_summary") }}
)
select l.host_id,
l.name as host_name,
l.is_superhost as host_is_superhost,
count(distinct l.listing_id) as num_listings,
sum(coalesce(c.estimated_revenue,0)) as total_revenue,
round(avg(coalesce(c.occupancy_rate,0)),2) as avg_occupancy_rate
from listings l
left join calender_summary c
on l.listing_id=c.listing_id
group by 1,2,3