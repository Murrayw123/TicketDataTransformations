{{ config(materialized='table') }}

-- create a CTE for the category table
with category_offers as (
    select distinct
        row_number() over (order by LOWER(product_category)) as id,
        LOWER(category) as category_name,
        category_offer_discount
    from {{ source('airbyte_raw_data', 'processed_api_uploads') }}
    where category is not null
)

-- select the category id and discount from the join of category_offer and category tables
select
    category_offers.id as id,
    cat.id as category_id,
    category_offers.category_offer_discount as discount
from category_offers
join category cat on LOWER(category_offers.category_name) = cat.name
where category_offers.category_offer_discount is not null
