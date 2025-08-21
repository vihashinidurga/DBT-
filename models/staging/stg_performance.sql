select 
    review_id,
    emp_id,
    rating,
    review_year
from {{ source('raw_perf','review_data') }}
