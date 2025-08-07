{% macro create_all_schemas() %}
    {% do create_schema_if_not_exists('STAGING') %}
    {% do create_schema_if_not_exists('SALES_FIN') %}
    
{% endmacro %}
