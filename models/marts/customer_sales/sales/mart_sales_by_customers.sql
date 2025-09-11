{{
    config(
      alias = 'SALES_BY_CUSTOMER'      
    )
}}

WITH SOURCE AS (
    SELECT CUSTOMER_ID
         , CUSTOMER_NAME         
         , SUM(QUANTITY) AS TOTAL_QUANTITY         
         , SUM(DISCOUNT) AS TOTAL_DISCOUNT
         , SUM(NET_PRICE) AS TOTAL_NET_PRICE
         , SUM(TOTAL_REVENUE) AS TOTAL_REVENUE
    FROM {{ref('edw_cs_fact_customer_sales')}}
    GROUP BY CUSTOMER_ID, CUSTOMER_NAME
)

SELECT * FROM  SOURCE