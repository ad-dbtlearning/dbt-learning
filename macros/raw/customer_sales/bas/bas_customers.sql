{% macro bas_customers() %}

  {% set bas_customers_query %}

    use role {{ target.role }};
    use warehouse {{ target.warehouse }};
    use database {{  get_database('raw') }}; 

    CREATE TABLE IF NOT EXISTS BAS_CUSTOMER_SALES.BAS_CUSTOMERS (
      CUSTOMER_ID INT,
      CUSTOMER_NAME STRING,
      REGION_ID INT,
      CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
      UPDATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
    );

  {% endset %}

  {% do run_query(bas_customers_query) %}
  
{% endmacro %}