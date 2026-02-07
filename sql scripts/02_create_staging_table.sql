USE DATABASE sportcar_db;
USE SCHEMA sportcar_db.analytics;

CREATE OR REPLACE TABLE staging (
day INT,
month INT,
year INT,
brand VARCHAR(50),
country VARCHAR(50),
continent VARCHAR(50),
units_sold INT,
predicted_units_sold NUMERIC,
avg_sentiment NUMERIC,
total_engagement INT

);

COPY INTO staging
FROM @my_stg/cleaned_sportcar_sales.parquet
FILE_FORMAT = (TYPE = 'PARQUET')
MATCH_BY_COLUMN_NAME = CASE_INSENSITIVE;