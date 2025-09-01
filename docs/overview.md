
{% docs __overview__ %}

# dbt POC Documentation

This POC demonstrates implementation of **dbt (Data Build Tool)** for building a modern data stack with **Snowflake** as the warehouse. 

The Project includes incremental loads, full load, reporting views, seeds, macros, and test.

## Project Folder Structure

```
├── analyses/              # Custom SQL analyses not included in dbt runs
├── data/                  # Static CSVs used for reference
├── dbt_internal_packages/ # Auto-installed dbt adapter macros (dbt-adapters, dbt-snowflake)
├── dbt_packages/          # External dbt packages (dependencies)
├── docs/                  # Documentation markdowns and schema.yml for dbt docs
├── logs/                  # Execution logs
├── macros/                # Custom macros for reusable SQL logic
│   ├── common
│   ├── edw/customer_sales
│   ├── raw/customer_sales
│   └── utils
├── models/                # Core dbt models (SQL transformations)
│   ├── analytics
│   ├── edw/customer_sales/incremental_tables
│   └── raw/customer_sales/{full_load_tables, incremental_tables}
├── seeds/                 # Reference data tables loaded into DB
├── snapshots/             # Point-in-time tracking of slowly changing data
├── target/                # Compiled SQL, manifest, and run artifacts
├── tests/                 # Custom data tests
└── dbt_project.yml        # Main dbt project configuration

```

### 1. Macros for Schema Creation & Init tables

Defined in **on-run-start**:

``` yml
// dbt_project.yml

Call macros to create schemas and tables

```

### 2. Incremental Models

- Implemented for RAW and EDW layers.
- Uses `delete+insert` **strategy** for efficient reprocessing.

Example:

``` yml    
    +materialized: incremental
    +incremental_strategy: delete+insert
    +on_schema_change: ignore
```

### 3. Full Load Models

- Certain **BAS tables** in **RAW layer** are build as full-refresh tables.

Example:

```yml
+materialized: table
+on_schema_change: ignore
```

### 4. Views for Reporting

- EDW reporting layer models are materialized as views.

``` yml

+materialized: view

```

### 6. Tags for Model Grouping

Models are grouped with **tags** for easy filtering:

``` YML
+tags: ["incremental_tables", "customer_sales"]
+tags: ["edw", "reporting"]

```

### 7. Seeds 

- Files are located in /seeds/customer_sales, load master data to snowflake.
- Configure with environment.

``` yml

seeds:
  +quote_columns: false
  +schema: "SEED"
  
```

### 8. Custom Macros

- `macros/common`:- Common macros
- `macros/raw/customer_sales`:- RAW layer macros
- `macros/edw/customer_sales`:- EDW layer macros

### 9. Testing Framework



{% enddocs %}