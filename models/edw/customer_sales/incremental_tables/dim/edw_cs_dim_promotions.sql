{{
  config(
    alias='DIM_PROMOTIONS',
    materialized='incremental',
    unique_key='PROMOTION_ID',
    incremental_strategy='merge'
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
    FROM {{ ref('edw_cs_cln_promotions') }}
)

SELECT
    {{dbt_utils.generate_surrogate_key(['PROMOTION_ID', 'UPDATED_AT'])}} AS PROMOTION_KEY,
    PROMOTION_ID,
    PROMOTION_NAME,
    START_DATE,
    END_DATE,
    DISCOUNT_PERCENT,
    CREATED_AT,
    UPDATED_AT
FROM S_STG_PROMOTIONS