{{ config(materialized='table') }}

-- create a CTE to generate unique IDs for each category
with category_ids as (
    select distinct
        row_number() over (order by product_category) as id,
        LOWER(product_category) as name,
        MAX(_ab_source_file_last_modified) as last_updated
    from {{ source('airbyte_raw_data', 'processed_api_uploads') }}
    where product_category is not null
    group by product_category
)

-- select the category name and ID from the CTE
select
    id,
    name,
    last_updated
from category_ids