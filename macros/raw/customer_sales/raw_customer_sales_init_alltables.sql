{% macro raw_customer_sales_init_alltables() %}
    
    {{ bas_customers() }}
    {{ bas_products() }}
    {{ bas_region() }}
    {{ bas_promotions() }}
    {{ bas_distributors() }}
    {{ bas_customer_sales()}}    

{% endmacro %}
