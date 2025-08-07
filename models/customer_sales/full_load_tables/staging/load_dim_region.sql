{{
  config(
    alias = 'BAS_DIM_REGION'
  )
}}


WITH SOURCE_DATA AS (
  SELECT
    REGION_ID,
    REGION_NAME,
    COUNTRY,
    current_timestamp AS CREATED_AT,
    current_timestamp AS UPDATED_AT
  FROM {{ ref('seed_regions') }}
)

SELECT * 
FROM SOURCE_DATA