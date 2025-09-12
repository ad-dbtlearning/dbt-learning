{{ config(
    alias='STG_CUSTOMER_SALES',
    materialized='incremental',
    unique_key='CUSTOMER_SALES_KEY', 
    cluster_by=['CUSTOMER_ID','PRODUCT_ID','SALES_DATE']
) }}

WITH source_data AS (
    SELECT
        SALE_ID,
        SALES_DATE,
        CUSTOMER_ID,
        PRODUCT_ID,
        QUANTITY,
        UNIT_PRICE,
        PROMOTION_ID,
        DISCOUNT,
        NET_PRICE,
        TOTAL_REVENUE,
        CURRENT_TIMESTAMP AS CREATED_AT,
        CURRENT_TIMESTAMP AS UPDATED_AT,
        -- Surrogate key for multi-column uniqueness
        CONCAT_WS('_', SALE_ID, CUSTOMER_ID, PRODUCT_ID, SALES_DATE) AS CUSTOMER_SALES_KEY
    FROM {{ ref('seed_fact_sales') }}
)

SELECT
    SALE_ID AS SALES_ID,        -- keeps SALES_ID in the target table
    SALES_DATE,
    CUSTOMER_ID,
    PRODUCT_ID,
    QUANTITY,
    UNIT_PRICE,
    PROMOTION_ID,
    DISCOUNT,
    NET_PRICE,
    TOTAL_REVENUE,
    CREATED_AT,
    UPDATED_AT,
    CUSTOMER_SALES_KEY   -- needed for incremental logic but can be dropped in downstream models
FROM source_data
{% if is_incremental() %}
WHERE CUSTOMER_SALES_KEY NOT IN (SELECT CUSTOMER_SALES_KEY FROM {{ this }})
{% endif %}
