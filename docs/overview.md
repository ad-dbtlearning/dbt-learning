{% docs __overview__ %}

# Overview

In this project, I implement dbt (Data Build Tool) to build a modern data stack with Snowflake as the data warehouse.

### It demonstrates how dbt can be used to:

#### Load Data from CSV files into the Raw Layer

- 	Clean & Organize data into a structured Cleansed Layer
- 	Build Incremental Models to process only new or updated records efficiently
- 	Create Dimensions & Facts for analytics
- 	Implement Slowly Changing Dimensions (SCD Type-2) to track historical changes in customer data
- 	Log Audit Information: Each dbt run is recorded in a logging table
- 	Add Tests (uniqueness, not null, non-zero, non-negative) to ensure data quality
- 	Develop Reporting / Mart Layer for business insights such as sales by customers, region, and time
- 	DAGs: In dbt, each model is a node, and dependencies between models form a Directed Acyclic Graph (DAG). This ensures models are built in the correct order. (See DAG section for a graphical representation.)

### Next Steps and Expansions

- Python Integration
  -  Build Python models for scenarios not possible in SQL
  -	Example: Fetch data directly from APIs

- CI/CD Implementation	
  - Automate dbt build, test, and deployment using Azure DevOps or GitHub Actions
  -	Enforce data quality checks before deployment

- Data Orchestration with Azure Data Factory (ADF)
  -	Use ADF pipelines to load data from multiple sources (SAP, Salesforce, API, Blob, etc.) into the RAW Layer
  -	Automate end-to-end workflows (Extract → Load → dbt Transform → Report)
  -	Schedule daily and real-time runs
- Multi-Platform dbt Extension
  -	Extend support for multi-cloud platforms (Snowflake + Databricks + Synapse)
  -	Maintain a unified dbt codebase with adapters for different warehouses


## Project Folder Structure

```
dbt_project/
├── models/                         # SQL models (core transformations)
│   ├── raw/                        # Raw layer - source-aligned models
│   │   └── customer_sales/
│   │       ├── full_load_tables/   # One-time or snapshot full loads
│   │       └── incremental_tables/ # Incremental loads (append/merge)
│   │
│   ├── edw/                        # Enterprise Data Warehouse - curated layer
│   │   └── customer_sales/         # Project name
│   │       ├── full_load_tables/   # Full load EDW tables
│   │       └── incremental_tables/ # Incremental EDW tables
│   │           ├── cln/            # Cleaned staging layer
│   │           ├── dim/            # Dimensions (SCDs, reference data)
│   │           └── fact/           # Fact tables (transactions, measures)
│   │
│   ├── marts/                      # Presentation/reporting layer
│   │   ├── customer_sales/         # Sales reporting marts
│   │   │   └── sales/
│   │   └── finance/
│   │
│   └── schema.yml                  # Tests + documentation for models
│
├── macros/                         # Create SF tables & Custom functions
│   ├── common/                     # Utility macros (e.g., surrogate keys)
│   ├── edw/                        # EDW-Tables' specific macros
│   │   └── customer_sales/         # Project Name
│   │       ├── cln/                # Cleaning/staging Tables' macros
│   │       ├── dim/                # Dimension handling Tables' macros
│   │       └── fact/               # Fact building Tables's macros
│   └── raw/                        # Raw layer-specific Tables' macros
│       └── customer_sales/
│           ├── dimensions/         # Dimension creation Tables' macros
│           └── stg/                # Staging Tables' macros
│
├── seeds/                          # Load data to SF from csv using seed
│   └── customer_sales/             # Lookup or reference datasets
│
├── docs/                           # Project documentation (Markdown/diagrams)
│   ├── overview.md
│
├── tests/                          # Custom and generic tests
│   └── generic/                    # Reusable generic test definitions
│
├── dbt_project.yml                 # Main dbt project config
└── packages.yml                    # External dbt packages (dependencies)

```



{% enddocs %}
