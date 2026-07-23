{{
    config(
        materialized='incremental',
        incremental_strategy='merge',
        unique_key='date_id',
        merge_exclude_columns=['insert_date']
    )
}}

select distinct
    dept_date as date_id,
    dept_date as store_date,
    isholiday,
    current_timestamp as insert_date,
    current_timestamp as update_date
from {{ source('department','department_raw') }}