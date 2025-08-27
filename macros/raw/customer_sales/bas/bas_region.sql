{% macro bas_region() %}

  {% set region_query %}

    use role {{ target.role }};
    use warehouse {{ target.warehouse }};
    use database {{  get_database('raw') }}; 

    CREATE TABLE IF NOT EXISTS BAS_CUSTOMER_SALES.BAS_REGION (
      REGION_ID INT,
      REGION_NAME STRING,
      COUNTRY STRING,
      CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
      UPDATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
    );

  {% endset %}

  {% do run_query(region_query) %}


{% endmacro %}