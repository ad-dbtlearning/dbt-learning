{{ 
  config(
    alias="CLN_CUSTOMERS",
    materialized="incremental",        
    incremental_strategy="merge",
    unique_key="CUSTOMER_ID"
  ) 
}}

WITH STG_CUSTOMERS AS (
  SELECT
    CUSTOMER_ID,
    CUSTOMER_NAME,
    EMAIL,
    PHONE_NUMBER,    
    ADDRESS,
    LOYALTY_STATUS,
    NULL AS PREVIOUS_LOYALTY_STATUS,
    ACCOUNT_STATUS,
    NULL AS PREVIOUS_ACCOUNT_STATUS,   
    CHANNEL,
    REGION_ID,
    STORE,
    md5(
      concat_ws('|',
        CUSTOMER_NAME,
        EMAIL,
        PHONE_NUMBER,
        ADDRESS,
        REGION_ID,
        LOYALTY_STATUS,
        ACCOUNT_STATUS
      )
    ) AS RECORD_HASH,
    CURRENT_TIMESTAMP(9) AS CREATED_AT,
    CURRENT_TIMESTAMP(9) AS UPDATED_AT
  FROM {{ ref('load_stg_customers') }}
)

SELECT *    
FROM STG_CUSTOMERS