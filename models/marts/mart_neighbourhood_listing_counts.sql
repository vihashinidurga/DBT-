select 
neighbourhood as neighbourhood,
count(distinct listing_id) as num_listings from 
{{ ref("stg_listings") }}
group by neighbourhood