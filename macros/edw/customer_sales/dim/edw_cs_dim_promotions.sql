{% macro dim_promotions() %}

  {% set promotions_query %}

    use role {{ target.role }};
    use warehouse {{ target.warehouse }};
    use database {{  get_database('edw') }}; 

    CREATE TABLE IF NOT EXISTS CS_GENERAL_DIM.DIM_PROMOTIONS (
      PROMOTION_KEY STRING,
      PROMOTION_ID INT,
      PROMOTION_NAME STRING,
      START_DATE DATE,
      END_DATE DATE,
      DISCOUNT_PERCENT FLOAT,
      CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
      UPDATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
    );

  {% endset %}

  {% do run_query(promotions_query) %}


{% endmacro %}