USE DATABASE sportcar_db;
USE SCHEMA sportcar_db.analytics;


-- Create dim_country dimension table
CREATE OR REPlACE TABLE dim_country(
    country_id INT AUTOINCREMENT PRIMARY KEY,
    country VARCHAR(50),
    continent VARCHAR(50)
);

INSERT INTO dim_country(country, continent)
SELECT DISTINCT country, continent
FROM sportcar_db.analytics.staging;


-- Create dim_date dimension table
CREATE OR REPlACE TABLE dim_date(
    date_id INT AUTOINCREMENT PRIMARY KEY,
    day INT,
    month INT,
    year INT
);

INSERT INTO dim_date(day, month, year)
SELECT DISTINCT day, month, year
FROM sportcar_db.analytics.staging
ORDER BY year, month, day;


-- Create dim_brand dimension table
CREATE OR REPlACE TABLE dim_brand(
    brand_id INT AUTOINCREMENT PRIMARY KEY,
    brand VARCHAR(50)
);

INSERT INTO dim_brand(brand)
SELECT DISTINCT brand
FROM sportcar_db.analytics.staging;

-- Create fact table
CREATE OR REPLACE TABLE fact_sportcar_sales (
    sales_id INT AUTOINCREMENT PRIMARY KEY,
    date_id INT,
    brand_id INT,
    country_id INT,
    units_sold INT,
    predicted_units_sold NUMERIC,
    avg_sentiment NUMERIC,
    total_engagement INT,
    FOREIGN KEY(date_id) REFERENCES dim_date(date_id),
    FOREIGN KEY(country_id) REFERENCES dim_country(country_id),
    FOREIGN KEY(brand_id) REFERENCES dim_brand(brand_id)
);

INSERT INTO fact_sportcar_sales (date_id, brand_id, country_id, units_sold, predicted_units_sold, avg_sentiment, total_engagement)
SELECT 
    dd.date_id,
    db.brand_id,
    dc.country_id,
    s.units_sold,
    s.predicted_units_sold,
    s.avg_sentiment,
    s.total_engagement
FROM sportcar_db.analytics.staging as s
JOIN dim_date as dd
    ON s.day = dd.day AND s.month = dd.month AND s.year = dd.year
JOIN dim_country as  dc
    ON s.country = dc.country
JOIN dim_brand as db 
    ON s.brand = db.brand;