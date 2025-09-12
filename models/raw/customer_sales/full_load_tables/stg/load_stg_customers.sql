{{
  config(    
    alias='STG_CUSTOMERS',    
  )
}}

WITH SOURCE_DATA AS (

  SELECT
    CUSTOMER_ID,
    CUSTOMER_NAME,
    EMAIL,
    PHONE_NUMBER,    
    ADDRESS,
    LOYALTY_STATUS,
    PREVIOUS_LOYALTY_STATUS,
    ACCOUNT_STATUS,
    PREVIOUS_ACCOUNT_STATUS,            
    CHANNEL,
    REGION_ID,
    STORE,
    current_timestamp AS CREATED_AT,
    current_timestamp AS UPDATED_AT
  FROM {{ ref('seeds_customers') }}
)

SELECT * FROM SOURCE_DATA
WHERE CUSTOMER_ID IS NOT NULL
  

