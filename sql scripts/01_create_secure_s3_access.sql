USE DATABASE sportcar_db;
USE SCHEMA sportcar_db.analytics;

CREATE OR REPLACE STAGE my_stg
  URL = 's3://sportcar-sales-prj/cleaned_dataset/'
  STORAGE_INTEGRATION = S3_FULL_INT;


