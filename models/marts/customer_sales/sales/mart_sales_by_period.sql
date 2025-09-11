{{
    config(
      alias = 'SALES_BY_PERIOD'
    )
}}

WITH SOURCE AS (
    SELECT CUSTOMER_ID
         , CUSTOMER_NAME
         , PRODUCT_ID
         , PRODUCT_NAME
         , SALES_YEAR         
         , SALES_DAY_NAME
         , SALES_MONTH_NAME
         , SALES_QUARTER         
         , SUM(QUANTITY) AS TOTAL_QUANTITY                  
         , SUM(NET_PRICE) AS TOTAL_NET_PRICE
         , SUM(TOTAL_REVENUE) AS TOTAL_REVENUE
    FROM {{ref('edw_cs_fact_customer_sales')}}
    GROUP BY CUSTOMER_ID
         , CUSTOMER_NAME
         , PRODUCT_ID
         , PRODUCT_NAME
         , SALES_YEAR         
         , SALES_DAY_NAME
         , SALES_MONTH_NAME
         , SALES_QUARTER         
)

SELECT * FROM  SOURCE