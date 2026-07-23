{{
    config(
        materialized='table'
    )
}}

with department as (

    select
        store_id,
        dept_id,
        dept_date,
        weekly_sales as store_weekly_sales
    from {{ source('department','department_raw') }}

),

store_dim as (

    select
        store_id,
        dept_id,
        store_size
    from {{ ref('walmart_store_dim') }}

),

fact as (

    select
        store_id,
        store_date,
        temperature,
        fuel_price,
        unemployment,
        cpi,
        markdown1,
        markdown2,
        markdown3,
        markdown4,
        markdown5
    from {{ source('fact','fact_raw') }}

),

date_dim as (

    select
        date_id,
        store_date
    from {{ ref('walmart_date_dim') }}

)

select

    d.store_id,
    d.dept_id,
    dd.date_id,
    d.store_weekly_sales,
    s.store_size,
    f.temperature,
    f.fuel_price,
    f.unemployment,
    f.cpi,
    f.markdown1,
    f.markdown2,
    f.markdown3,
    f.markdown4,
    f.markdown5
from department d
inner join fact f
    on d.store_id = f.store_id
   and d.dept_date = f.store_date
inner join date_dim dd
    on d.dept_date = dd.store_date
inner join store_dim s
    on d.store_id = s.store_id
    and d.dept_id = s.dept_id