{% macro bas_dim_distributors() %}

  {% set dim_distributors_query %}

    use role {{ target.role }};
    use warehouse {{ target.warehouse }};
    use database {{ target.database }}; 

    CREATE TABLE IF NOT EXISTS STAGING.BAS_DIM_DISTRIBUTORS (
      DISTRIBUTOR_ID INT,
      DISTRIBUTOR_NAME STRING,
      ZONE STRING,
      CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
      UPDATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
    );

  {% endset %}

  {% do run_query(dim_distributors_query) %}


{% endmacro %}