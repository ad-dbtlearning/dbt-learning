{% macro dim_products() %}

  {% set products_query %}

    use role {{ target.role }};
    use warehouse {{ target.warehouse }};
    use database {{  get_database('edw') }}; 

    CREATE TABLE IF NOT EXISTS CS_GENERAL_DIM.DIM_PRODUCTS (
      PRODUCT_KEY STRING,
      PRODUCT_ID INT,
      PRODUCT_NAME STRING,
      CATEGORY STRING,
      BRAND STRING,      
      CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
      UPDATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
      VALID_FROM TIMESTAMP_LTZ,
      VALID_TO TIMESTAMP_LTZ,
      IS_ACTIVE BOOLEAN,            
      RECORD_HASH STRING,
      ELT_TS TIMESTAMP_LTZ      
    );

  {% endset %}

  {% do run_query(products_query) %}

{% endmacro %}