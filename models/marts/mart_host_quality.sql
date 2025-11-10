select
round(sum(case when is_superhost = true then 1 else 0 end) / count(distinct(host_id)) *100,2) as num_superhost
from  {{ ref("stg_listings") }}