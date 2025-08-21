select 
    sale_id,
    emp_id,
    sale_amount,
    sale_date
from {{ source('raw_sales','sales_data') }}