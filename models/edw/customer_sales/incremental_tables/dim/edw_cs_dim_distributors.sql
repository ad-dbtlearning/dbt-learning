{{
  config(
    alias='DIM_DISTRIBUTORS',
    materialized='incremental',    
    unique_key='DISTRIBUTOR_ID'
  )
}}

WITH S_STG_PROMOTIONS AS (
    SELECT
        DISTRIBUTOR_ID,
        DISTRIBUTOR_NAME,
        ZONE,
        CREATED_AT,
        UPDATED_AT          
    FROM {{ ref('edw_cs_cln_distributors') }}
)

SELECT
    {{dbt_utils.generate_surrogate_key(['DISTRIBUTOR_ID', 'UPDATED_AT'])}} AS DISTRIBUTOR_KEY,
    DISTRIBUTOR_ID,
    DISTRIBUTOR_NAME,
    ZONE,    
    CREATED_AT,
    UPDATED_AT
FROM S_STG_PROMOTIONS