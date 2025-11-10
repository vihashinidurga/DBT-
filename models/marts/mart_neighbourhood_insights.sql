with listings as (
    select listing_id, neighbourhood from
    {{ ref('stg_listings') }}
),
calender_summary as(
    select listing_id,avg_price, occupancy_rate
    from {{ ref ('int_calender_summary') }}
),
joined as(
    select l.neighbourhood,
    c.avg_price, c.occupancy_rate
    from listings l
    join calender_summary c
    on l.listing_id = c.listing_id
)
select neighbourhood,
round(avg(avg_price),2) as avg_price,
round(avg(occupancy_rate),2) as avg_occupancy_rate
from joined
group by neighbourhood
order by avg_occupancy_rate desc