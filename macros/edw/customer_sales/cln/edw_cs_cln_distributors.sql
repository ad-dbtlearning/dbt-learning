{% macro cln_distributors() %}

  {% set distributors_query %}

    use role {{ target.role }};
    use warehouse {{ target.warehouse }};
    use database {{  get_database('edw') }}; 

    CREATE TABLE IF NOT EXISTS CS_GENERAL_CLN.CLN_DISTRIBUTORS (
      DISTRIBUTOR_ID INT,
      DISTRIBUTOR_NAME STRING,
      ZONE STRING,      
      CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
      UPDATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
    );

  {% endset %}

  {% do run_query(distributors_query) %}


{% endmacro %}