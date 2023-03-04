-- store_product.sql
{{ config(materialized='table') }}

select
    s.id as store_id,
    p.id as product_id,
    coalesce(po.price, p.rrp) as price
from {{ ref('store') }} s
cross join {{ ref('product') }} p
left join {{ ref('product_offer') }} po
on p.id = po.product_id
where s.id is not null and p.id is not null