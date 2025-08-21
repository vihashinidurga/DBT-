select 
    p.review_id,
    p.emp_id,
    d.emp_name,
    d.manager_lvl1,
    d.manager_lvl3,
    p.rating,
    p.review_year
from {{ ref('stg_performance') }} p
join {{ ref('employee_hierarchy') }} d

on p.emp_id = d.employee