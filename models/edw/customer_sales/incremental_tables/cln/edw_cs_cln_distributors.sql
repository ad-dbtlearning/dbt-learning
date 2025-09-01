{{
config(
    alias='CLN_DISTRIBUTORS',
    materialized='incremental',
    unique_key='DISTRIBUTOR_ID'
)
}}


WITH S_STG_DISTRIBUTOR AS (
  SELECT
    DISTRIBUTOR_ID,
    DISTRIBUTOR_NAME,
    ZONE,
    CREATED_AT,
    UPDATED_AT    
  FROM {{ ref('load_stg_distributors') }}
)

SELECT 
  DISTRIBUTOR_ID,
  DISTRIBUTOR_NAME,
  ZONE,
  CURRENT_TIMESTAMP(9) AS CREATED_AT,
  CURRENT_TIMESTAMP(9) AS UPDATED_AT
FROM S_STG_DISTRIBUTOR
{% if is_incremental() %}
WHERE DISTRIBUTOR_ID NOT IN (SELECT DISTRIBUTOR_ID FROM {{ this }})
{% endif %}