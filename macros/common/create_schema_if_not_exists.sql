-- macros/shared/create_schema_if_not_exists.sql
{% macro create_schema_if_not_exists(database, schema) %}
    {% set full_schema_name = database ~ '.' ~ schema %}

    {% set sql %}
        CREATE SCHEMA IF NOT EXISTS {{ full_schema_name }}
    {% endset %}

    {{ log("Ensuring schema exists: " ~ full_schema_name, info=True) }}
    {{ run_query(sql) }}
{% endmacro %}
