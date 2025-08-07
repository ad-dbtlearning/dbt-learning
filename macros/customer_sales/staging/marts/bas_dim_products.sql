{% macro bas_dim_products() %}

  {% set bas_dim_products_query %}

    use role {{ target.role }};
    use warehouse {{ target.warehouse }};
    use database {{ target.database }}; 

    CREATE TABLE IF NOT EXISTS STAGING.BAS_DIM_PRODUCTS (
      PRODUCT_ID INT,
      PRODUCT_NAME STRING,
      CATEGORY STRING,
      BRAND STRING,
      CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
      UPDATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
    );

  {% endset %}

  {% do run_query(bas_dim_products_query) %}

{% endmacro %}