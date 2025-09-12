{% macro cln_products() %}

  {% set products_query %}

    use role {{ target.role }};
    use warehouse {{ target.warehouse }};
    use database {{  get_database('edw') }}; 

    CREATE TABLE IF NOT EXISTS CS_GENERAL_CLN.CLN_PRODUCTS (
      PRODUCT_ID INT,
      PRODUCT_NAME STRING,
      CATEGORY STRING,
      BRAND STRING,      
      CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
      UPDATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
      RECORD_HASH STRING
    );

  {% endset %}

  {% do run_query(products_query) %}

{% endmacro %}