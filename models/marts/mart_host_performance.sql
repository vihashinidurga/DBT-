select
    host_id,
    host_name,
    host_is_superhost,
    num_listings,
    avg_occupancy_rate,
    total_revenue
from {{ ref("int_host_summary") }}
order by total_revenue desc
-- limit 15
