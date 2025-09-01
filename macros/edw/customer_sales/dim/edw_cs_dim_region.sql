{% macro dim_region() %}

  {% set region_query %}

    use role {{ target.role }};
    use warehouse {{ target.warehouse }};
    use database {{  get_database('edw') }}; 

    CREATE TABLE IF NOT EXISTS CS_GENERAL_DIM.DIM_REGION (
      REGION_KEY STRING,
      REGION_ID INT,
      REGION_NAME STRING,
      COUNTRY STRING,
      CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
      UPDATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
    );

  {% endset %}

  {% do run_query(region_query) %}


{% endmacro %}