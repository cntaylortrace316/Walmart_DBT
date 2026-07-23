{% snapshot walmart_fact_snapshot %}

{{
    config(
        target_schema='public',
        unique_key=['store_id','dept_id','date_id'],
        strategy='check',
        check_cols=[
            'store_weekly_sales',
            'store_size',
            'temperature',
            'fuel_price',
            'unemployment',
            'cpi',
            'markdown1',
            'markdown2',
            'markdown3',
            'markdown4',
            'markdown5'
        ]
    )
}}

select *
from {{ ref('walmart_fact_base') }}

{% endsnapshot %}