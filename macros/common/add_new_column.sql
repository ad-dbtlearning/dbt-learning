
{% macro add_new_column(tbl_name,column_name,col_datatype) %}
     
  {% set alter_statement %}

      use role {{ target.role }};
      use warehouse {{ target.warehouse }};
      use database {{  target.database }};

      ALTER TABLE {{tbl_name}} 
      ADD COLUMN IF NOT EXISTS {{column_name}} {{col_datatype}};
      

  {% endset %}

  {% do run_query(alter_statement) %}

{% endmacro %}