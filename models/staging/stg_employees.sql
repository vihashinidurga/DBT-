select 
    emp_id,
    emp_name,
    manager_id
from {{ source('raw', 'employee_hierarchy') }}
