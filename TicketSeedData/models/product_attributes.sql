-- product_attributes.sql
{{ config(materialized='table') }}

select distinct
    product_sku as sku,
    attribute_1 as attribute,
    _ab_source_file_last_modified as last_updated
FROM {{ source('airbyte_raw_data', 'processed_api_uploads') }}
where product_sku is not null
union all
select distinct
    product_sku as sku,
    attribute_2 as attribute,
    _ab_source_file_last_modified as last_updated
FROM {{ source('airbyte_raw_data', 'processed_api_uploads') }}
where product_sku is not null
