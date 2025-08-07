{%  macro bas_fact_sales() %}

  {% set bas_fact_sales_query %}

    use role {{ target.role }};
    use warehouse {{ target.warehouse }};
    use database {{ target.database }}; 

    CREATE TABLE IF NOT EXISTS SALES_FIN.BAS_FACT_SALES (
      SALE_ID INT,
      SALES_DATE DATE,
      CUSTOMER_ID INT,
      PRODUCT_ID INT,
      QUANTITY INT,
      UNIT_PRICE FLOAT,
      PROMOTION_ID INT,
      DISCOUNT FLOAT,
      NET_PRICE FLOAT,
      TOTAL_REVENUE FLOAT,
      CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
      UPDATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
    );

  {% endset %}

  {% do run_query(bas_fact_sales_query) %}

{%  endmacro %}