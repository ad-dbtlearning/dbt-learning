{% macro cln_promotions() %}

  {% set promotions_query %}

    use role {{ target.role }};
    use warehouse {{ target.warehouse }};
    use database {{  get_database('edw') }}; 

    CREATE TABLE IF NOT EXISTS CS_GENERAL_CLN.CLN_PROMOTIONS (
      PROMOTION_ID INT,
      PROMOTION_NAME STRING,
      START_DATE DATE,
      END_DATE DATE,
      DISCOUNT_PERCENT FLOAT,
      VALID_FROM TIMESTAMP_LTZ(9) DEFAULT CURRENT_TIMESTAMP(),
      VALID_TO TIMESTAMP_LTZ(9),
      IS_ACTIVE BOOLEAN DEFAULT TRUE,
      CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
      UPDATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
    );

  {% endset %}

  {% do run_query(promotions_query) %}


{% endmacro %}