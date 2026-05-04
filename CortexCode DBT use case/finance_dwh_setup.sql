-- Create Warehouse for the demo
CREATE OR REPLACE WAREHOUSE FINANCE_DEMO_WH
  WITH WAREHOUSE_SIZE = 'XSMALL'
  AUTO_SUSPEND = 60
  AUTO_RESUME = TRUE;

-- Create Database and schemas
CREATE OR REPLACE DATABASE FINANCE_DEMO;
CREATE SCHEMA FINANCE_DEMO.RAW;
CREATE SCHEMA FINANCE_DEMO.ANALYTICS;
CREATE SCHEMA FINANCE_DEMO.ML;

USE SCHEMA FINANCE_DEMO.RAW;

-- Transactions table (Generate Synthetic Finance data)
CREATE OR REPLACE TABLE TRANSACTIONS AS
SELECT
    UNIFORM(100000, 999999, RANDOM()) AS TRANSACTION_ID,
    DATEADD('day', -UNIFORM(0, 730, RANDOM()), CURRENT_DATE()) AS TRANSACTION_DATE,
    ARRAY_CONSTRUCT('Checking','Savings','Brokerage','Credit Card','Loan')
        [UNIFORM(0,4,RANDOM())]::STRING AS ACCOUNT_TYPE,
    ARRAY_CONSTRUCT('Deposit','Withdrawal','Transfer','Fee','Interest',
                    'Dividend','Wire','ACH','Check','ATM')
        [UNIFORM(0,9,RANDOM())]::STRING AS TRANSACTION_TYPE,
    ROUND(UNIFORM(-50000, 200000, RANDOM()) / 100.0, 2) AS AMOUNT,
    ARRAY_CONSTRUCT('USD','EUR','GBP','JPY','CHF')
        [UNIFORM(0,4,RANDOM())]::STRING AS CURRENCY,
    ARRAY_CONSTRUCT('New York','London','Singapore','Zurich','Hong Kong',
                    'Chicago','San Francisco','Toronto')
        [UNIFORM(0,7,RANDOM())]::STRING AS BRANCH_CITY,
    ARRAY_CONSTRUCT('Retail','Institutional','Private Banking','Wealth Mgmt')
        [UNIFORM(0,3,RANDOM())]::STRING AS BUSINESS_LINE,
    UNIFORM(10000, 99999, RANDOM()) AS CUSTOMER_ID
FROM TABLE(GENERATOR(ROWCOUNT => 500000));

-- Customer profiles (Generate Synthetic Finance data)
CREATE OR REPLACE TABLE CUSTOMERS AS
SELECT
    CUSTOMER_ID,
    ARRAY_CONSTRUCT('High','Medium','Low')[UNIFORM(0,2,RANDOM())]::STRING AS RISK_RATING,
    ARRAY_CONSTRUCT('Active','Inactive','Dormant','Closed')
        [UNIFORM(0,3,RANDOM())]::STRING AS ACCOUNT_STATUS,
    DATEADD('day', -UNIFORM(365, 7300, RANDOM()), CURRENT_DATE()) AS ONBOARDING_DATE,
    ROUND(UNIFORM(1000, 50000000, RANDOM()) / 100.0, 2) AS TOTAL_AUM,
    ARRAY_CONSTRUCT('Retail','HNWI','UHNWI','Institutional')
        [UNIFORM(0,3,RANDOM())]::STRING AS CLIENT_SEGMENT
FROM (SELECT DISTINCT CUSTOMER_ID FROM TRANSACTIONS);

-- Compliance / suspicious activity flags (Generate Synthetic Finance data)
CREATE OR REPLACE TABLE COMPLIANCE_ALERTS AS
SELECT
    UNIFORM(1, 99999, RANDOM()) AS ALERT_ID,
    DATEADD('day', -UNIFORM(0, 365, RANDOM()), CURRENT_DATE()) AS ALERT_DATE,
    UNIFORM(10000, 99999, RANDOM()) AS CUSTOMER_ID,
    ARRAY_CONSTRUCT('Structuring','Velocity','Geo Anomaly','Large Cash',
                    'Sanctions Match','Unusual Pattern')
        [UNIFORM(0,5,RANDOM())]::STRING AS ALERT_TYPE,
    ARRAY_CONSTRUCT('Open','Under Review','Escalated','Closed - No Action',
                    'Closed - SAR Filed')
        [UNIFORM(0,4,RANDOM())]::STRING AS STATUS,
    ARRAY_CONSTRUCT('Low','Medium','High','Critical')
        [UNIFORM(0,3,RANDOM())]::STRING AS SEVERITY
FROM TABLE(GENERATOR(ROWCOUNT => 10000));

