# Sports Car Sales Analytics Project

Project Overview

This project is an end-to-end data analytics pipeline that ingests, transforms, models, and visualizes sports car sales data using Python, Snowflake, and Power BI.

The solution covers:

  - Data ingestion and transformation with Python
  - Secure cloud storage integration (AWS S3)
  - Dimensional modeling in Snowflake
  - BI-ready semantic views
  - Interactive reporting in Power BI
  - Brands analyzed include Ferrari, McLaren, and Aston Martin.

Architecture Overview

  Tech Stack
  
  - Python – Data ingestion and transformation
  - AWS S3 – Cloud object storage
  - Snowflake – Cloud data warehouse
  - SQL – Data modeling and analytics
  - Power BI – Visualization and reporting

High Level Overview
  
  Python → AWS S3 → Snowflake Staging → Fact & Dimension Tables → Analytics View → Power BI


├── python_scripts/
│   ├── save_to_s3.py
│   └── transform.py

├── sql_scripts/
│   ├── 01_create_secure_s3_access.sql
│   ├── 02_create_staging_table.sql
│   ├── 03_create_fact_and_dim_tables.sql
│   └── analytics_view.sql

├── BI_Report/
│   └── analytics_report.pbix

└── README.md


Python Scripts

- save_to_s3.py
   - Extracts raw data.
   - Saves processed files to AWS S3 in parquet format.
   - Acts as the ingestion layer for Snowflake.

- transform.py
    - Cleans and transforms raw data.
    - Prepares datasets for loading into Snowflake.
    - Applies validation and formatting logic


Snowflake SQL Scripts

  - 01_create_secure_s3_access.sql
    - Creates secure integration between Snowflake and AWS S3.
    - Defines storage integrations and access permissions.

  - 02_create_staging_table.sql
    - Creates staging tables for raw data ingestion
    - Used as an intermediate layer before transformations

  - 03_create_fact_and_dim_tables.sql

      - Builds the dimensional model using a star schema.

      - Creates:
      
        - fact_sportcar_sales
        - dim_brand
        - dim_country
        - dim_date

  - analytics_view.sql

    - Creates a BI-ready semantic analytics view
    - Joins fact and dimension tables 
    - Applies business logic and filters 
    - Uses clear, descriptive column aliases for reporting


Data Model

  - Fact Table: fact_sportcar_sales

    - Contains transactional and analytical measures:
    
        - Units sold
        - Predicted units sold
        - Average sentiment score
        - Total engagement

- Dimension Tables

    - Brand – Car brand details
    - Country – Country and continent
    - Date – Day, month, year attributes


Power BI Report

  - File: analytics_report.pbix

  - The Power BI report connects directly to Snowflake and uses the analytics view to provide:

      - Sales performance by brand
      - Geographic insights using map and filled map visuals
      - Time-based trends (year, month, day)
      - Sentiment and engagement analysis
      - Clean, professional dashboard design

How to Run the Project

  1) Run Python scripts to process and upload data to S3

  2) Execute Snowflake SQL scripts in order:

      - 01_create_secure_s3_access.sql
      - 02_create_staging_table.sql
      - 03_create_fact_and_dim_tables.sql
      - analytics_view.sql

  3) Open analytics_report.pbix in Power BI

  4) Refresh data to load analytics from Snowflake
