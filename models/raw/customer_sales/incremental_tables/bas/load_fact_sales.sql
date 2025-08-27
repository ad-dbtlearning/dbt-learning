{{ config(
  alias = 'BAS_CUSTOMER_SALES'
) }}

WITH source_data AS (

  SELECT
    SALE_ID,
    sales_date,
    customer_id,
    product_id,
    quantity,
    unit_price,
    promotion_id,
    discount,
    net_price,
    total_revenue,
    CURRENT_TIMESTAMP AS created_at,
    CURRENT_TIMESTAMP AS updated_at
  FROM
    {{ ref('seed_fact_sales') }}
)
SELECT
    SALE_ID AS SALES_ID,
    sales_date,
    customer_id,
    product_id,
    quantity,
    unit_price,
    promotion_id,
    discount,
    net_price,
    total_revenue,
    CURRENT_TIMESTAMP AS created_at,
    CURRENT_TIMESTAMP AS updated_at
FROM
  source_data
