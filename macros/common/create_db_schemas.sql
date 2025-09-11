{% macro create_db_schemas() %}

    --{# Get database names for EDW and RAW based on env #}
    {% set edwdb = get_database('edw') %}
    {% set rawdb = get_database('raw') %}

    --{# Create EDW schemas #}
    {% do create_schema_if_not_exists(database=edwdb, schema='STAGING') %}
    {% do create_schema_if_not_exists(database=edwdb, schema='FACT_SALES') %}

    --{# Create RAW schemas #}
    {% do create_schema_if_not_exists(database=rawdb, schema='BAS_CUSTOMER_SALES') %}

{% endmacro %}