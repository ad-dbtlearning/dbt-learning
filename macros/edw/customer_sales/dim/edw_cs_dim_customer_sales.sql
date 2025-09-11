{%  macro dim_customer_sales() %}

  {% set customer_sales_query %}

    use role {{ target.role }};
    use warehouse {{ target.warehouse }};
    use database {{  get_database('edw') }}; 

    CREATE TABLE IF NOT EXISTS CS_GENERAL_DIM.DIM_CUSTOMER_SALES (
      CUSTOMER_SALES_KEY BIGINT AUTOINCREMENT PRIMARY KEY,
      SALES_ID INT,
      SALES_DATE DATE,
      CUSTOMER_ID INT,
      PRODUCT_ID INT,
      QUANTITY INT,
      UNIT_PRICE FLOAT,
      PROMOTION_ID INT,
      DISCOUNT FLOAT,
      NET_PRICE FLOAT,
      TOTAL_REVENUE FLOAT,
      VALID_FROM TIMESTAMP_LTZ(9) DEFAULT CURRENT_TIMESTAMP(),
      VALID_TO TIMESTAMP_LTZ(9),
      IS_ACTIVE BOOLEAN DEFAULT TRUE,      
      CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
      UPDATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
    );

  {% endset %}

  {% do run_query(customer_sales_query ) %}

{%  endmacro %}