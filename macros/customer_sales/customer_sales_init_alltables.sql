{% macro customer_sales_init_alltables() %}
    
    {{ bas_dim_customers() }}
    {{ bas_dim_products() }}
    {{ bas_dim_region() }}
    {{ bas_dim_promotions() }}
    {{ bas_dim_distributors() }}
    {{ bas_fact_sales()}}    

{% endmacro %}
