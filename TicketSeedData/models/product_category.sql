-- product_category.sql
{{ config(materialized='table') }}

select
    p.id as product_id,
    c.id as category_id
from {{ ref('product') }} p
join {{ ref('category') }} c
on p.category = c.category_name
