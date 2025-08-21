with recursive up_chain as (
    select
        e.emp_id      as employee,
        e.emp_name    as emp_name,
        e.manager_id  as current_manager_id,
        1             as depth
    from {{ ref('stg_employees') }} e

    union all

    select
        u.employee,
        u.emp_name,
        m.manager_id  as current_manager_id,
        u.depth + 1   as depth
    from up_chain u
    join {{ ref('stg_employees') }} m
      on u.current_manager_id = m.emp_id
    where u.current_manager_id is not null
),

labeled_chain as (
    select
        u.employee,
        u.emp_name,
        u.depth,
        m.emp_name as manager_name
    from up_chain u
    left join {{ ref('stg_employees') }} m
      on u.current_manager_id = m.emp_id
)

select
    employee,
    emp_name,
    max(case when depth = 1 then manager_name end) as manager_lvl1,
    max(case when depth = 2 then manager_name end) as manager_lvl2,
    max(case when depth = 3 then manager_name end) as manager_lvl3
from labeled_chain
group by 1,2
