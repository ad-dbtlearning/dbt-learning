{%  test non_negative(model, column_name) %}

  WITH NON_NEGATIVE_VALIDATION AS (
    
    SELECT {{column_name}} AS VALUE 
    FROM {{model}}
  
  ) 

  SELECT * 
  FROM NON_NEGATIVE_VALIDATION
  WHERE VALUE < 0

{% endtest %}

