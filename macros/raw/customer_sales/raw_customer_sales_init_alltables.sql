{% macro raw_customer_sales_init_alltables() %}
    
    {{ create_schema_if_not_exists(get_database('raw'), 'CS_GENERAL_STAGING') }}

    {{ stg_customers() }}
    {{ stg_products() }}
    {{ stg_region() }}
    {{ stg_promotions() }}
    {{ stg_distributors() }}
    {{ stg_customer_sales()}}    

{% endmacro %}
