{% macro stg_customer() %}

    {% set db = get_database('edw') %}
    {% set schema_name = 'STAGING' %}

  {% set stg_customer_query %}

    use role {{ target.role }};
    use warehouse {{ target.warehouse }};
    use database {{ db }};

    CREATE TABLE IF NOT EXISTS {{schema_name}}.STG_CUSTOMER (
      CUST_UNIQUE_KEY STRING,
      CUSTOMER_ID INT,
      CUSTOMER_NAME STRING,
      REGION_ID INT,
      REGION_NAME STRING,
      COUNTRY STRING,
      CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
      UPDATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
    );
  {% endset %}

  {% do run_query(stg_customer_query) %}

{% endmacro %}