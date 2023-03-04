

  create  table "postgres".public."processed_api_uploads__dbt_tmp"
  as (
    
with __dbt__cte__processed_api_uploads_ab1 as (

-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: "postgres".public._airbyte_raw_processed_api_uploads
select
    jsonb_extract_path_text(_airbyte_data, 'category') as category,
    jsonb_extract_path_text(_airbyte_data, 'store_id') as store_id,
    jsonb_extract_path_text(_airbyte_data, 'store_name') as store_name,
    jsonb_extract_path_text(_airbyte_data, 'attribute_1') as attribute_1,
    jsonb_extract_path_text(_airbyte_data, 'attribute_2') as attribute_2,
    jsonb_extract_path_text(_airbyte_data, 'product_rrp') as product_rrp,
    jsonb_extract_path_text(_airbyte_data, 'product_sku') as product_sku,
    jsonb_extract_path_text(_airbyte_data, 'store_state') as store_state,
    jsonb_extract_path_text(_airbyte_data, 'product_category') as product_category,
    jsonb_extract_path_text(_airbyte_data, '_ab_source_file_url') as _ab_source_file_url,
    jsonb_extract_path_text(_airbyte_data, 'product_description') as product_description,
    jsonb_extract_path_text(_airbyte_data, 'product_offer_price') as product_offer_price,
    jsonb_extract_path_text(_airbyte_data, 'category_offer_discount') as category_offer_discount,
    
        jsonb_extract_path(table_alias._airbyte_data, '_ab_additional_properties')
     as _ab_additional_properties,
    jsonb_extract_path_text(_airbyte_data, '_ab_source_file_last_modified') as _ab_source_file_last_modified,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at
from "postgres".public._airbyte_raw_processed_api_uploads as table_alias
-- processed_api_uploads
where 1 = 1
),  __dbt__cte__processed_api_uploads_ab2 as (

-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: __dbt__cte__processed_api_uploads_ab1
select
    cast(category as text) as category,
    cast(store_id as 
    bigint
) as store_id,
    cast(store_name as text) as store_name,
    cast(attribute_1 as text) as attribute_1,
    cast(attribute_2 as text) as attribute_2,
    cast(product_rrp as 
    float
) as product_rrp,
    cast(product_sku as 
    bigint
) as product_sku,
    cast(store_state as text) as store_state,
    cast(product_category as text) as product_category,
    cast(_ab_source_file_url as text) as _ab_source_file_url,
    cast(product_description as text) as product_description,
    cast(product_offer_price as 
    float
) as product_offer_price,
    cast(category_offer_discount as 
    float
) as category_offer_discount,
    cast(_ab_additional_properties as 
    jsonb
) as _ab_additional_properties,
    cast(nullif(_ab_source_file_last_modified, '') as 
    timestamp with time zone
) as _ab_source_file_last_modified,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at
from __dbt__cte__processed_api_uploads_ab1
-- processed_api_uploads
where 1 = 1
),  __dbt__cte__processed_api_uploads_ab3 as (

-- SQL model to build a hash column based on the values of this record
-- depends_on: __dbt__cte__processed_api_uploads_ab2
select
    md5(cast(coalesce(cast(category as text), '') || '-' || coalesce(cast(store_id as text), '') || '-' || coalesce(cast(store_name as text), '') || '-' || coalesce(cast(attribute_1 as text), '') || '-' || coalesce(cast(attribute_2 as text), '') || '-' || coalesce(cast(product_rrp as text), '') || '-' || coalesce(cast(product_sku as text), '') || '-' || coalesce(cast(store_state as text), '') || '-' || coalesce(cast(product_category as text), '') || '-' || coalesce(cast(_ab_source_file_url as text), '') || '-' || coalesce(cast(product_description as text), '') || '-' || coalesce(cast(product_offer_price as text), '') || '-' || coalesce(cast(category_offer_discount as text), '') || '-' || coalesce(cast(_ab_additional_properties as text), '') || '-' || coalesce(cast(_ab_source_file_last_modified as text), '') as text)) as _airbyte_processed_api_uploads_hashid,
    tmp.*
from __dbt__cte__processed_api_uploads_ab2 tmp
-- processed_api_uploads
where 1 = 1
)-- Final base SQL model
-- depends_on: __dbt__cte__processed_api_uploads_ab3
select
    category,
    store_id,
    store_name,
    attribute_1,
    attribute_2,
    product_rrp,
    product_sku,
    store_state,
    product_category,
    _ab_source_file_url,
    product_description,
    product_offer_price,
    category_offer_discount,
    _ab_additional_properties,
    _ab_source_file_last_modified,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at,
    _airbyte_processed_api_uploads_hashid
from __dbt__cte__processed_api_uploads_ab3
-- processed_api_uploads from "postgres".public._airbyte_raw_processed_api_uploads
where 1 = 1
  );