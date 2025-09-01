{%  macro edw_customer_sales_init_alltables() %}

  -- CLN tables
  {{ create_schema_if_not_exists(get_database('edw'), 'CS_GENERAL_CLN') }}
  
  {{ cln_customers() }}
  {{ cln_products() }}
  {{ cln_region() }}
  {{ cln_promotions() }}
  {{ cln_distributors() }}   
  {{ cln_customer_sales() }}

  -- DIM tables
  {{ create_schema_if_not_exists(get_database('edw'), 'CS_GENERAL_DIM') }}
  
  {{ dim_customers() }}
  {{ dim_customer_sales() }}
  {{ dim_products() }}
  {{ dim_region() }}
  {{ dim_promotions() }}
  {{ dim_distributors() }}

  --- FACT tables
  {{ create_schema_if_not_exists(get_database('edw'), 'CS_GENERAL_FACT') }}
  
  {{ fact_customer_sales() }}
  

{% endmacro %}