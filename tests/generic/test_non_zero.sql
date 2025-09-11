{% test non_zero(model, column_name) %}

  WITH NON_ZERO_VALIDATION AS (

    SELECT {{column_name}} AS VALUE 
    FROM {{model}}
        
  )

  SELECT * 
  FROM NON_ZERO_VALIDATION
  WHERE VALUE = 0

{% endtest %}