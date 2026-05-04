## Setup
Execute finance_dwh.sql to setup raw data

mkdir finance-analytics-demo && cd finance-analytics-demo
Create an AGENTS.md File for project context

## Prompt 1:  Data Discovery
I'm working with FINANCE_DEMO.RAW. Describe the schema of each table, row counts, and how the tables relate to each other.


## Prompt 2: Data Profiling
Profile the TRANSACTIONS table. Show distributions of TRANSACTION_TYPE,
ACCOUNT_TYPE, and CURRENCY. Check for nulls, duplicate TRANSACTION_IDs,
and any amount outliers.

## Prompt 3: Scaffold the Entire dbt Project structure
Initialize a new dbt project called "finance_analytics" in the C:\Gaurav\Project\AI\Snowflake_AI\finance-analytics-demo directory 
targeting Snowflake. Set the profile to use my current Snowflake connection, 
database FINANCE_DEMO, and warehouse FINANCE_DEMO_WH. Use dbt-core with the 
snowflake adapter.

## Prompt 4: Create the full dbt project
Read the tables in FINANCE_DEMO.RAW and create a full dbt project with staging, 
  intermediate, and mart layers. For staging, rename columns to snake_case, 
  cast dates properly, and add surrogate keys using dbt_utils.generate_surrogate_key. 
  For the mart layer, create:
  
  1. mart_daily_transaction_summary - materialized as table, partitioned by 
     transaction_date, with daily volume, net flow, and average amount by 
     business_line and branch_city
  2. mart_compliance_dashboard - materialized as table, joining alerts to 
     customers, with alert aging (days_open), escalation rates by severity, 
     and a 30-day rolling alert trend per customer segment
  
  Write the sources.yml, schema.yml with tests, and add column descriptions.


## Prompt 5: Install and Run
Install dbt dependencies and run the full project. If anything fails, diagnose 
and fix the issue.

## Prompt 6: Run dbt Tests
Run dbt test. If any tests fail, explain why and fix them.


## Prompt 7: Generate dbt Documentation
Generate dbt documentation for the entire project. Make sure every model 
and column has a business-friendly description. Then run dbt docs generate 
and serve.