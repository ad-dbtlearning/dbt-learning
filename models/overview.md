{# overview.md #}

{% docs __overview__ %}

# DBT + Snowflake POC

## Project Goal

To  build a POC using dbt with Snowflake to demonstrate:

Features are used in POC

1. Data ingestion from one Snowflake database to another
    - Source models were created using source() references to pull data from an existing snowflake database and schema.
    - Data was transformed and loaded into a new schema/database (EDW) using dbt models.
2. Environment-based configuration (dev, uat, prod)
    - Configure multiple targets in profiles.yml
    - Schema and database separation used for each environment.
3. Incremental
    - Incremental models created using ```materialized='incremental'``` with ```merge strategy```.
4. Documentation
    - Metadata and column-level documentation added using ```.yaml``` files in the model directories.
    - Markdown files created with ```docs/``` folder for business logic explanations.
    - Auto-generated docs with

    ```
      dbt docs generate  
      dbt docs serve
    ```

5. Testing
    - Added dbt built-in tests; ```unique```, ```not null```, and custom tests.
    - tests places in ```/tests/``` folder or inline in ``.yml`` files.

6. CI/CD readiness
    - dbt commands used:
       - `dbt build`:  run + test + snapshot
       - `dbt docs generate`: for doc site

## Folder structure used

below folder structure being used

```

dbt_project/ 
├── dbt_project.yml 
├── packages.yml 
├── models/ 
│ ├── source/ 
│ │ └── snowflake/ 
│ │   └── snowflake_sample_data.yml 
│ ├── edw/ 
│ │ ├── staging/ 
│ │ │ ├── stg_customers.sql 
│ │ │ └── stg_orders.sql 
│ │ │ ├── dim/ 
│ │ │ │ ├── dim_customers.sql 
│ │ │ │ └── dim_products.sql 
│ │ │ ├── int/ 
│ │ │ ├── int_customer_orders.sql 
│ │ │ └── int_order_metrics.sql 
│ │ │ ├── fact/ 
│ │ │   ├── fact_orders.sql 
│ │ │   └── fact_revenue.sql 
│ │ │ ├── view/ 
│ │ │   └── vw_customer_summary.sql 
│ │ └── finance/ 
│ |   └── fact_financials.sql 
│ ├── macros/ 
│   └── custom_macros.sql 
│ ├── seeds/ 
│   └── country_codes.csv 
│ ├── snapshots/ 
│   └── customer_snapshots.sql 
│ ├── tests/ 
│   └── unique_customer_id.sql 
└── docs/ 
  └── dim_customers.md 

```
