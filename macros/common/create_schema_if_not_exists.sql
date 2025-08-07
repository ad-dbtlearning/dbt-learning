-- macros/shared/create_schema_if_not_exists.sql
{% macro create_schema_if_not_exists(schema_name) %}
    {% set sql %}
        CREATE SCHEMA IF NOT EXISTS {{ schema_name }}
    {% endset %}

    {{ log("Ensuring schema exists: " ~ schema_name, info=True) }}
    {{ run_query(sql) }}
{% endmacro %}
