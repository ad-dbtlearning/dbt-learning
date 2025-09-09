{{
  config(
    alias = 'STG_DISTRIBUTORS',
  )
}}

WITH SOURCE_DATA AS (
    SELECT
        DISTRIBUTOR_ID,
        DISTRIBUTOR_NAME,
        ZONE,
        current_timestamp AS CREATED_AT,
        current_timestamp AS UPDATED_AT
    FROM {{ ref('seed_distributors') }}
)

SELECT * 
FROM SOURCE_DATA

