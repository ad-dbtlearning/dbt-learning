{% macro cln_customers() %}

  {% set customers_query %}

    use role {{ target.role }};
    use warehouse {{ target.warehouse }};
    use database {{  get_database('edw') }}; 

    CREATE TABLE IF NOT EXISTS CS_GENERAL_CLN.CLN_CUSTOMERS (
      CUSTOMER_ID INT,
      CUSTOMER_NAME STRING,
      EMAIL STRING,
      PHONE_NUMBER STRING,      
      ADDRESS STRING,
      LOYALTY_STATUS STRING,
      PREVIOUS_LOYALTY_STATUS STRING,
      ACCOUNT_STATUS STRING,
      PREVIOUS_ACCOUNT_STATUS STRING,            
      CHANNEL STRING,
      REGION_ID INT,
      STORE STRING,
      CREATED_AT TIMESTAMP_LTZ(9) DEFAULT CURRENT_TIMESTAMP(),
      UPDATED_AT TIMESTAMP_LTZ(9) DEFAULT CURRENT_TIMESTAMP(),
      RECORD_HASH STRING
    );

  {% endset %}

  {% do run_query(customers_query) %}
  
{% endmacro %}