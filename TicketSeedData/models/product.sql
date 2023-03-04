-- product.sql
{{ config(materialized='table') }}

select distinct
    product_sku as sku,
    product_description as description,
    product_category as category,
    product_rrp as rrp,
    _ab_source_file_last_modified as last_updated
FROM {{ source('airbyte_raw_data', 'processed_api_uploads') }}
where product_sku is not null
