select 
host_id, host_name, count(distinct listing_id) as num_listings
from {{ ref("stg_listings") }}
group by host_id,host_name
order by num_listings desc