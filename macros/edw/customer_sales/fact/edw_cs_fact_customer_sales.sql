{%  macro fact_customer_sales() %}

    {% set db = get_database('edw') %}
    {% set schema_name = 'CS_GENERAL_FACT' %}

  {% set fact_customer_sales_query %}    
    
    use role {{ target.role }};
    use warehouse {{ target.warehouse }};
    use database {{ db }};

    CREATE TABLE IF NOT EXISTS {{schema_name}}.FACT_CUSTOMER_SALES (
      UNIQUE_SK STRING,
      CUSTOMER_SALES_KEY INT,
      SALES_ID INT, 
      SALES_DATE DATE,
      CUSTOMER_KEY BIGINT,
      CUSTOMER_ID INT,
      CUSTOMER_NAME STRING,
      COUNTRY STRING,
      PRODUCT_ID INT,
      PRODUCT_NAME STRING, 
      QUANTITY INT,
      UNIT_PRICE NUMBER(18,2),
      PROMOTION_ID INT,
      PROMOTION_NAME STRING,
      PROMOTION_START_DATE DATE,
      PROMOTION_END_DATE DATE,
      PROMOTION_DISCOUNT NUMBER(18,2),
      DISCOUNT NUMBER(18,2),
      NET_PRICE NUMBER(18,2),
      TOTAL_REVENUE NUMBER(18,2),
      CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
      UPDATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
      SALES_DATE_KEY STRING,
      SALES_DAY_OF_MONTH INT,
      SALES_DAY_NAME STRING,
      SALES_DAY_OF_WEEK INT,
      SALES_WEEK_NUM INT,
      SALES_MONTH_NUM INT,
      SALES_MONTH_NAME STRING,
      SALES_QUARTER INT,
      SALES_YEAR INT,
      IS_WEEKEND BOOLEAN
    );


  {% endset %}
     {{ log("Creating FACT_CUSTOMER_SALES:\n" ~ create_sql, info=True) }}
    {% do run_query(fact_customer_sales_query) %}

{% endmacro %}