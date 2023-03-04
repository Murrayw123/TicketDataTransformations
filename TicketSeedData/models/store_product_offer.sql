-- store_product_offer.sql
{{ config(materialized='table') }}

select
    product_sku as sku,
    product_offer_price as price,
    _ab_source_file_last_modified as last_updated
FROM {{ source('airbyte_raw_data', 'processed_api_uploads') }}
where product_sku is not null and product_offer_price is not null
