{{
  config(
    alias="CLN_PRODUCTS",
    unique_key="PRODUCT_ID",
    materialized="incremental",
    incremental_strategy="merge",   
  )
}}

WITH S_STG_PRODUCT AS (
  SELECT
    PRODUCT_ID,
    PRODUCT_NAME,
    CATEGORY,
    BRAND,        
    CREATED_AT,
    UPDATED_AT,
    md5(
      CONCAT_WS('|',
        PRODUCT_NAME,
        CATEGORY,
        BRAND
      )
    )  AS RECORD_HASH 
  FROM {{ ref('load_stg_products') }}
)

SELECT 
  PRODUCT_ID,
  PRODUCT_NAME,
  CATEGORY,
  BRAND,        
  CURRENT_TIMESTAMP() AS VALID_FROM,
  NULL AS VALID_TO,
  TRUE AS IS_ACTIVE,
  CURRENT_TIMESTAMP(9) AS CREATED_AT,
  CURRENT_TIMESTAMP(9) AS UPDATED_AT,
  RECORD_HASH
FROM S_STG_PRODUCT
