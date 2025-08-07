{% macro bas_dim_customers() %}

  {% set bas_dim_customers_query %}

    use role {{ target.role }};
    use warehouse {{ target.warehouse }};
    use database {{ target.database }}; 

    CREATE TABLE IF NOT EXISTS STAGING.BAS_DIM_CUSTOMERS (
      CUSTOMER_ID INT,
      CUSTOMER_NAME STRING,
      REGION_ID INT,
      CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
      UPDATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
    );

  {% endset %}

  {% do run_query(bas_dim_customers_query) %}
  
{% endmacro %}