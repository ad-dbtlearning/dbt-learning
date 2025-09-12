{{
    config(
      alias = 'SALES_BY_REGION'      
    )
}}

WITH SOURCE AS (
    SELECT REGION_NAME
         , SUM(QUANTITY) AS TOTAL_QUANTITY 
         , SUM(DISCOUNT) AS TOTAL_DISCOUNT
         , SUM(NET_PRICE) AS TOTAL_NET_PRICE
         , SUM(TOTAL_REVENUE) AS TOTAL_REVENUE
    FROM {{ref('edw_cs_fact_customer_sales')}}
    GROUP BY REGION_NAME
)

SELECT * FROM  SOURCE