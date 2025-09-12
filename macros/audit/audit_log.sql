{%  macro audit_log() %}
 

  {% set query %}

    use role {{ target.role }};
    use warehouse {{ target.warehouse }};
    use database {{ get_database('audit_db') }};

    CREATE SCHEMA IF NOT EXISTS AUDIT;

    CREATE TABLE IF NOT EXISTS AUDIT.RUN_LOG (
        RUN_ID STRING,
        RUN_AT TIMESTAMP_LTZ,
        USER_NAME STRING,
        MODEL_NAME STRING,
        STATUS STRING
    );

  {% endset %}

  {% do run_query(query) %}

{%  endmacro %}