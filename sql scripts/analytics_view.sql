CREATE OR REPLACE VIEW sportcar_db.analytics.car_report AS
SELECT 
    s.sales_id,
    s.units_sold,
    s.predicted_units_sold,
    s.avg_sentiment,
    s.total_engagement,

    db.brand AS car_brand,

    dc.country AS country_name,
    dc.continent AS continent,

    dd.day AS sales_day,
    dd.month AS sales_month,
    dd.year AS sales_year
    
FROM sportcar_db.analytics.fact_sportcar_sales s

LEFT JOIN sportcar_db.analytics.dim_brand db 
    ON s.brand_id = db.brand_id
LEFT JOIN sportcar_db.analytics.dim_country dc 
    ON s.country_id = dc.country_id
LEFT JOIN sportcar_db.analytics.dim_date dd 
    ON s.date_id = dd.date_id
    
WHERE s.predicted_units_sold IS NOT NULL;