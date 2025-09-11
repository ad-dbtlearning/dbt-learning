{%  macro dim_customers() %}

  {% set customer_sales_query %}

    use role {{ target.role }};
    use warehouse {{ target.warehouse }};
    use database {{  get_database('edw') }}; 

    CREATE TABLE IF NOT EXISTS CS_GENERAL_DIM.DIM_CUSTOMERS (
      CUSTOMER_KEY STRING,
      CUSTOMER_ID INT,
      CUSTOMER_NAME STRING,
      EMAIL STRING,
      PHONE_NUMBER STRING,      
      ADDRESS STRING,
      LOYALTY_STATUS STRING,
      PREVIOUS_LOYALTY_STATUS STRING,
      ACCOUNT_STATUS STRING,
      PREVIOUS_ACCOUNT_STATUS STRING,            
      CHANNEL STRING,
      REGION_ID INT,
      STORE STRING,                    
      VALID_FROM TIMESTAMP_LTZ,
      VALID_TO TIMESTAMP_LTZ,
      IS_ACTIVE BOOLEAN,            
      RECORD_HASH STRING,
      ELT_TS TIMESTAMP_LTZ,
      UPDATED_AT TIMESTAMP_LTZ
    );

  {% endset %}

  {% do run_query(customer_sales_query ) %}

{%  endmacro %}