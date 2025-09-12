{% macro log_audit() %}

    use role {{ target.role }};
    use warehouse {{ target.warehouse }};
    

    {% set sql %}
        insert into {{ get_database('audit_db') }}.AUDIT.RUN_LOG (
            RUN_ID,
            RUN_AT,
            USER_NAME,
            MODEL_NAME,
            STATUS
        )
        values (
            '{{ invocation_id }}',               -- unique id for each dbt run
            current_timestamp,                   -- run timestamp
            current_user,                        -- who executed the run
            '{{ this }}',                        -- model (schema.table)
            '{{ run_result.status if run_result is defined else "SUCCESS" }}'            
        );
    {% endset %}

    {% do run_query(sql) %}

{% endmacro %}