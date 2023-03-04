-- product_attributes_product.sql
{{ config(materialized='table') }}

select
    p.id as product_id,
    pa.attribute,
    pa.last_updated
from {{ ref('product') }} p
join {{ ref('product_attributes') }} pa
on p.sku = pa.sku
