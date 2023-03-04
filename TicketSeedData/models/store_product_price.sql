-- store_product_price.sql
{{ config(materialized='table') }}

select
    sp.store_id,
    sp.product_id,
    coalesce(po.price, sp.price) as price
from {{ ref('store_product') }} sp
left join {{ ref('product_offer') }} po
on sp.product_id = po.product_id
