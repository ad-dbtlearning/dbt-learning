{{
    config(
        alias = 'DIM_PRODUCTS',
        materialized = 'incremental',
        unique_key = 'PRODUCT_KEY'
    )
}}

WITH SOURCE_DATA AS (
    SELECT
        P.PRODUCT_ID,
        P.PRODUCT_NAME,
        P.CATEGORY,
        P.BRAND,        
        P.CREATED_AT,        
        P.UPDATED_AT,
        P.RECORD_HASH
    FROM {{ ref('edw_cs_cln_products') }} P
),

CURRENT_DIM AS (
    SELECT *
    FROM {{ this }}
    WHERE IS_ACTIVE = TRUE
),

-- detect changed records
CHANGED AS (
    SELECT S.PRODUCT_ID,
        S.PRODUCT_NAME,
        S.CATEGORY,
        S.BRAND,
        S.RECORD_HASH,
        S.CREATED_AT,
        S.UPDATED_AT
    FROM SOURCE_DATA S
    INNER JOIN CURRENT_DIM D
      ON S.PRODUCT_ID = D.PRODUCT_ID
    WHERE S.RECORD_HASH <> D.RECORD_HASH
),

-- unchanged records
UNCHANGED AS (
    SELECT
        D.PRODUCT_KEY,
        D.PRODUCT_ID,
        D.PRODUCT_NAME,
        D.CATEGORY,
        D.BRAND,
        D.ELT_TS,
        D.CREATED_AT,
        D.UPDATED_AT,
        D.VALID_FROM,
        D.VALID_TO,
        D.IS_ACTIVE,
        D.RECORD_HASH
    FROM CURRENT_DIM D
    LEFT JOIN CHANGED C
      ON D.PRODUCT_ID = C.PRODUCT_ID
    LEFT JOIN SOURCE_DATA S
      ON D.PRODUCT_ID = S.PRODUCT_ID
    WHERE C.PRODUCT_ID IS NULL
      AND S.PRODUCT_ID IS NOT NULL 
),

-- expire old versions when change detected
EXPIRED AS (
    SELECT
        D.PRODUCT_KEY,
        D.PRODUCT_ID,
        D.PRODUCT_NAME,
        D.CATEGORY,
        D.BRAND,
        D.ELT_TS,
        D.CREATED_AT,
        D.UPDATED_AT,
        D.VALID_FROM,
        CURRENT_TIMESTAMP() AS VALID_TO,
        FALSE AS IS_ACTIVE,
        D.RECORD_HASH
    FROM CURRENT_DIM D
    INNER JOIN CHANGED C
      ON D.PRODUCT_ID = C.PRODUCT_ID
),

-- insert new and changed records
NEW_VERSIONS AS (
    SELECT
        {{ dbt_utils.generate_surrogate_key(['S.PRODUCT_ID','S.UPDATED_AT']) }} AS PRODUCT_KEY,
        S.PRODUCT_ID,
        S.PRODUCT_NAME,
        S.CATEGORY,
        S.BRAND,        
        CURRENT_TIMESTAMP()::TIMESTAMP_LTZ(9) AS ELT_TS,
        S.CREATED_AT,
        S.UPDATED_AT,
        CURRENT_TIMESTAMP() AS VALID_FROM,
        NULL AS VALID_TO,
        TRUE AS IS_ACTIVE,
        S.RECORD_HASH
    FROM SOURCE_DATA S
    LEFT JOIN (
      SELECT PRODUCT_ID,
             IS_ACTIVE 
      FROM CURRENT_DIM   
      QUALIFY ROW_NUMBER() OVER (PARTITION BY PRODUCT_ID ORDER BY VALID_FROM DESC) = 1
    ) AS D
      ON S.PRODUCT_ID = D.PRODUCT_ID
    WHERE D.PRODUCT_ID IS NULL OR D.IS_ACTIVE = FALSE
),

-- insert changed records (new active version)
CHANGED_INSERTS AS (
    SELECT
        {{ dbt_utils.generate_surrogate_key(['S.PRODUCT_ID','S.UPDATED_AT']) }} AS PRODUCT_KEY,
        S.PRODUCT_ID,
        S.PRODUCT_NAME,
        S.CATEGORY,
        S.BRAND,        
        CURRENT_TIMESTAMP()::TIMESTAMP_LTZ(9) AS ELT_TS,
        S.CREATED_AT,
        S.UPDATED_AT,
        CURRENT_TIMESTAMP() AS VALID_FROM,
        NULL AS VALID_TO,
        TRUE AS IS_ACTIVE,
        S.RECORD_HASH
    FROM CHANGED S
),

-- delete (no longer in source)
DELETED AS (
    SELECT
        D.PRODUCT_KEY,
        D.PRODUCT_ID,
        D.PRODUCT_NAME,
        D.CATEGORY,
        D.BRAND,        
        D.ELT_TS,
        D.CREATED_AT,
        D.UPDATED_AT,
        D.VALID_FROM,
        CURRENT_TIMESTAMP() AS VALID_TO,
        FALSE AS IS_ACTIVE,
        D.RECORD_HASH
    FROM CURRENT_DIM D
    LEFT JOIN SOURCE_DATA S
      ON D.PRODUCT_ID = S.PRODUCT_ID
    WHERE S.PRODUCT_ID IS NULL
)


SELECT * FROM UNCHANGED
UNION ALL
SELECT * FROM EXPIRED
UNION ALL 
SELECT * FROM NEW_VERSIONS
UNION ALL
SELECT * FROM CHANGED_INSERTS
UNION ALL
SELECT * FROM DELETED