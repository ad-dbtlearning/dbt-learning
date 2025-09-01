{% macro stg_products() %}

  {% set stg_products_query %}

    use role {{ target.role }};
    use warehouse {{ target.warehouse }};
    use database {{  get_database('raw') }}; 

    CREATE TABLE IF NOT EXISTS CS_GENERAL_STAGING.STG_PRODUCTS (
      PRODUCT_ID INT,
      PRODUCT_NAME STRING,
      CATEGORY STRING,
      BRAND STRING,
      CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
      UPDATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
    );

  {% endset %}

  {% do run_query(stg_products_query) %}

{% endmacro %}