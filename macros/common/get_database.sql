{% macro get_database(db_type) %}
    {% set mapping = var('database_map') %}  -- already a dict
    {% set env = target.name %}              -- dev / uat / prod

    {% if db_type in mapping %}
        {{ mapping[db_type][env] }}
    {% else %}
        {{ exceptions.raise_compiler_error("Unknown database type: " ~ db_type) }}
    {% endif %}
{% endmacro %}
