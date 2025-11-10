select 
room_type as room_type,
round(avg(price), 2) as avg_price_of_each_room 
from {{ ref('stg_listings') }}
group by room_type