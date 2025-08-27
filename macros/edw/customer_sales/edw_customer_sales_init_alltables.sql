{%  macro edw_customer_sales_init_alltables() %}

  {{ stg_customer() }}
  {{ fact_customer_sales() }}

{% endmacro %}