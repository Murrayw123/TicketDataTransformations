-- product_offer.sql
{{ config(materialized='table') }}

select
    p.id as product_id,
    po.price,
    po.last_updated
from {{ ref('product') }} p
join {{ ref('store_product_offer') }} po
on p.sku = po.sku