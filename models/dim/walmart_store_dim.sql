{{
    config(
        materialized='incremental',
        incremental_strategy='merge',
        unique_key=['store_id','dept_id'],
        merge_exclude_columns=['insert_date']
    )
}}

with stores as (

    select
        store_id,
        store_type,
        size as store_size
    from {{ source('store','store_raw') }}

),

departments as (

    select distinct
        store_id,
        dept_id
    from {{ source('department','department_raw') }}

)

select

    d.store_id,
    d.dept_id,
    s.store_type,
    s.store_size,
    current_timestamp as insert_date,
    current_timestamp as update_date
from departments d
inner join stores s
    on d.store_id = s.store_id