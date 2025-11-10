with listings as(
    select listing_id, name, host_id, neighbourhood from {{ ref("stg_listings") }}
),
inter as(
    select listing_id, estimated_revenue from {{ ref("int_calender_summary") }}
),
joined as(
    select l.listing_id, name,host_id,neighbourhood, i.estimated_revenue
    from listings l
    join inter i
    on l.listing_id = i.listing_id
)
select listing_id,name,host_id,neighbourhood ,estimated_revenue
from joined 
order by estimated_revenue desc
limit 10