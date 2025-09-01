{{
  config(
      alias='CLN_REGION',
      unique_key='REGION_ID'
  )
}}

WITH S_STG_REGION AS (
    SELECT
        REGION_ID,
        REGION_NAME,
        COUNTRY,
        CREATED_AT,
        UPDATED_AT        
    FROM {{ ref('load_stg_region') }}
)

SELECT 
    REGION_ID,
    REGION_NAME,
    COUNTRY,
    CURRENT_TIMESTAMP(9) AS VALID_FROM,
    NULL AS VALID_TO,
    TRUE AS IS_ACTIVE,
    CURRENT_TIMESTAMP(9) AS CREATED_AT,
    CURRENT_TIMESTAMP(9) AS UPDATED_AT
FROM S_STG_REGION
{% if is_incremental() %}
WHERE REGION_ID NOT IN (SELECT REGION_ID FROM {{ this}})
{% endif %}