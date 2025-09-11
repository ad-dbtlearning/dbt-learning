{{
  config(
    alias='DIM_REGION',
    materialized='incremental',
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
    FROM {{ ref('edw_cs_cln_region') }}
)

SELECT
    {{dbt_utils.generate_surrogate_key(['REGION_ID', 'UPDATED_AT'])}} AS REGION_KEY,
    REGION_ID,
    REGION_NAME,
    COUNTRY,
    CREATED_AT,
    UPDATED_AT
FROM S_STG_REGION