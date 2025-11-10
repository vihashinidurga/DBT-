with src as (
  select * 
  from {{ source('raw', 'calender') }}
),

-- Bring in price data from listings
listings as (
  select 
    listing_id as listing_id,
    {{ clean_price('price') }} as price
  from {{ ref('stg_listings') }}
),

final as (
  select
    src.listing_id::int as listing_id,
    try_cast(src.date as date) as cal_date,

    case 
      when lower(trim(src.available)) in ('t','true','1','y','yes') 
      then true 
      else false 
    end as available,

    -- Price: use existing cleaned price, else take from listings table
    coalesce({{ clean_price('src.price') }}, listings.price) as price,

    -- Adjusted price: if null, apply a random discount (e.g., 5–20%)
    coalesce(
      {{ clean_price('src.adjusted_price') }},
      round(
        coalesce({{ clean_price('src.price') }}, listings.price) 
        * (1 - (uniform(0.05, 0.20, random()))),
        2
      )
    ) as adjusted_price,

    coalesce(try_cast(src.minimum_nights as int), null) as minimum_nights,
    coalesce(try_cast(src.maximum_nights as int), null) as maximum_nights

  from src
  left join listings 
    on src.listing_id = listings.listing_id
)

select * from final
