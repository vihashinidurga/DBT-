select 
    s.sale_id,
    s.emp_id,
    d.emp_name,
    d.manager_lvl1,
    d.manager_lvl3,
    s.sale_amount,
    s.sale_date
from {{ ref('stg_sales') }} s
join {{ ref('employee_hierarchy') }} d

  on s.emp_id = d.employee