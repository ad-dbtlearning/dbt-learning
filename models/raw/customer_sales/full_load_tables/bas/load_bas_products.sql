{{
  config(    
    alias='BAS_PRODUCTS'               
    )
}}

WITH SOURCE_DATA AS (

  SELECT
    PRODUCT_ID,
    PRODUCT_NAME,
    CATEGORY,
    BRAND,
    current_timestamp AS CREATED_AT,
    current_timestamp AS UPDATED_AT
  FROM {{ ref('seed_products') }}
)

SELECT * FROM SOURCE_DATA
WHERE PRODUCT_ID IS NOT NULL
  

