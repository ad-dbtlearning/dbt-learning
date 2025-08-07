{% macro bas_dim_promotions() %}

  {% set dim_promotions_query %}

    use role {{ target.role }};
    use warehouse {{ target.warehouse }};
    use database {{ target.database }}; 

    CREATE TABLE IF NOT EXISTS STAGING.BAS_DIM_PROMOTIONS (
      PROMOTION_ID INT,
      PROMOTION_NAME STRING,
      START_DATE DATE,
      END_DATE DATE,
      DISCOUNT_PERCENT FLOAT,
      CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
      UPDATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
    );

  {% endset %}

  {% do run_query(dim_promotions_query) %}


{% endmacro %}