-- store.sql
{{ config(materialized='table') }}

select distinct
    store_id as id,
    store_name as name,
    store_state as state,
    _ab_source_file_last_modified as last_updated
FROM {{ source('airbyte_raw_data', 'processed_api_uploads') }}
where store_id is not null
