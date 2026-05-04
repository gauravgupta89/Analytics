## Prompt 1
### DATA (BUSINESS LOGIC) TRANSFORMATION IMPLEMENTATION

Build the CLEANSED layer: create stored procedures that read from RAW tables,
    apply data cleansing (trim, standardize, deduplicate, null handling, derive
    computed columns), and load into CLEANSED schema tables. Then build MARTS
    layer with star schema Dimensions (SCD Type 2) and Fact tables using MERGE
    statements. Use Snowflake Streams to capture changes.