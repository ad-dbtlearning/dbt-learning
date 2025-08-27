{% macro bas_products() %}

  {% set bas_products_query %}

    use role {{ target.role }};
    use warehouse {{ target.warehouse }};
    use database {{  get_database('raw') }}; 

    CREATE TABLE IF NOT EXISTS BAS_CUSTOMER_SALES.BAS_PRODUCTS (
      PRODUCT_ID INT,
      PRODUCT_NAME STRING,
      CATEGORY STRING,
      BRAND STRING,
      CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
      UPDATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
    );

  {% endset %}

  {% do run_query(bas_products_query) %}

{% endmacro %}