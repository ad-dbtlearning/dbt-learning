{%  macro fact_customer_sales() %}

    {% set db = get_database('edw') %}
    {% set schema_name = 'FACT_SALES' %}

  {% set fact_customer_sales_query %}    
    
    use role {{ target.role }};
    use warehouse {{ target.warehouse }};
    use database {{ db }};

    CREATE TABLE IF NOT EXISTS {{schema_name}}.FACT_CUSTOMER_SALES (
      UNIQUE_KEY STRING,
      SALES_ID INT, 
      SALES_DATE DATE,
      CUSTOMER_ID INT,
      CUSTOMER_NAME STRING,
      PRODUCT_ID INT,
      PRODUCT_NAME STRING, 
      QUANTITY INT,
      UNIT_PRICE NUMBER(18,2),
      PROMOTION_ID INT,
      PROMOTION_NAME STRING,
      DISCOUNT NUMBER(18,2),
      NET_PRICE NUMBER(18,2),
      TOTAL_REVENUE NUMBER(18,2),
      CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
      UPDATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
    );


  {% endset %}
     {{ log("Creating FACT_CUSTOMER_SALES:\n" ~ create_sql, info=True) }}
    {% do run_query(fact_customer_sales_query) %}

{% endmacro %}