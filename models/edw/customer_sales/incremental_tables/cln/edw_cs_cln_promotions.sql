{{
  config(
      alias='CLN_PROMOTIONS',
      materialized='incremental',
      incremental_strategy='merge',
      unique_key='PROMOTION_ID'
  )
}}

WITH S_STG_PROMOTIONS AS (
    SELECT
        PROMOTION_ID,
        PROMOTION_NAME,
        START_DATE,
        END_DATE,
        DISCOUNT_PERCENT,
        CREATED_AT,
        UPDATED_AT        
    FROM {{ ref('load_stg_promotions') }}
)


SELECT
    PROMOTION_ID,
    PROMOTION_NAME,
    START_DATE,
    END_DATE,
    DISCOUNT_PERCENT,
    CURRENT_TIMESTAMP(9) AS VALID_FROM,
    NULL AS VALID_TO,
    TRUE AS IS_ACTIVE,
    CURRENT_TIMESTAMP(9) AS CREATED_AT,
    CURRENT_TIMESTAMP(9) AS UPDATED_AT
FROM S_STG_PROMOTIONS
