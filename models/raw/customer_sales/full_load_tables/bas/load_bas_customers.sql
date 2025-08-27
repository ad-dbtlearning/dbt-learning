{{
  config(    
    alias='BAS_CUSTOMERS'    
  )
}}

WITH SOURCE_DATA AS (

  SELECT
    CUSTOMER_ID,
    CUSTOMER_NAME,
    REGION_ID,
    CHANNEL,
    current_timestamp AS CREATED_AT,
    current_timestamp AS UPDATED_AT
  FROM {{ ref('seeds_customers') }}
)

SELECT * FROM SOURCE_DATA
WHERE CUSTOMER_ID IS NOT NULL
  

