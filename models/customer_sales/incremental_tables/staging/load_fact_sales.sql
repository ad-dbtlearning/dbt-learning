{{ config(
  schema = 'SALES_FIN',
  alias = 'BAS_FACT_SALES'
) }}

WITH source_data AS (

  SELECT
    sale_id,
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
  *
FROM
  source_data
