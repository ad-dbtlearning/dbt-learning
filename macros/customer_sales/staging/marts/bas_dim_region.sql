{% macro bas_dim_region() %}

  {% set dim_region_query %}

    use role {{ target.role }};
    use warehouse {{ target.warehouse }};
    use database {{ target.database }}; 

    CREATE TABLE IF NOT EXISTS STAGING.BAS_DIM_REGION (
      REGION_ID INT,
      REGION_NAME STRING,
      COUNTRY STRING,
      CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
      UPDATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
    );

  {% endset %}

  {% do run_query(dim_region_query) %}


{% endmacro %}