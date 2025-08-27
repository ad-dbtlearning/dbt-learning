{{
  config(
   alias = 'BAS_PROMOTIONS',
  )
}}

WITH SOURCE_DATA AS (
    SELECT
        PROMOTION_ID,
        PROMOTION_NAME,
        START_DATE,
        END_DATE,
        DISCOUNT_PERCENT,
        current_timestamp AS CREATED_AT,
        current_timestamp AS UPDATED_AT
    FROM {{ ref('seed_promotions') }}
)

SELECT *
FROM SOURCE_DATA
