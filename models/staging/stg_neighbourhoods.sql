select
  neighbourhood_group as neighbourhood_group,
  neighbourhood as neighbourhood
from {{ source('raw','neighbourhoods') }}
