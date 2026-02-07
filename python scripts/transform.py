import pandas as pd
from config import access_key, access_secret_key
import logging
import time

logging.basicConfig(
    level=logging.INFO,
    format= '%(asctime)s - %(levelname)s - %(message)s' 
)

logger = logging.getLogger(__name__)

country_to_continent_map = {
    "China": "Asia",
    "Germany": "Europe",
    "Italy": "Europe",
    "Middle East": "Middle East",
    "UK": "Europe",
    "USA": "North America"

}

logging.info('Script starting.')

for i in range(5, 0, -1):  # 5, 4, 3, 2, 1
    logging.info(str(i))
    time.sleep(1)


try:
    df = pd.read_csv("s3://sportcar-sales-prj/raw_data/sportscar_sales.csv", 
                 storage_options={"profile": "default"})
except FileNotFoundError as e:
    logging.error("File does not exist in S3 path") 
    raise

# Create new column date
df['date'] = pd.to_datetime(df['week'])
logger.info("Converted 'week' column to datetime in 'date'.")

# Drop old week column
df.drop(columns=['week'], inplace=True)
logger.info("Dropped old 'week' column.")

# Reorder to make date first
cols = ['date'] + [c for c in df.columns if c != 'date']
df = df[cols]

# Create year, month, day
df['year'] = df['date'].dt.year
df['month'] = df['date'].dt.month
df['day'] = df['date'].dt.day
logger.info("Created 'year', 'month', 'day' columns from 'date'.")

# Drop original date column
df.drop(columns=['date'], inplace=True)

# Reorder to make day, month, year first
cols=['day','month','year'] + [c for c in df.columns if c not in ['day','month','year']]
df = df[cols]

# Rename region to country
df.rename(columns={"region": "country"}, inplace=True)

# Create Continent column and map to dictionary
df['continent'] = df['country'].map(country_to_continent_map)
logger.info("Mapped 'country' to 'continent'.")

# Handle missing continent info
df['continent'] = df['continent'].fillna('Other')

# Reorder continent after country
other_cols = [c for c in df.columns if c != 'continent']
country_idx = other_cols.index('country') + 1
other_cols.insert(country_idx, 'continent')
df = df[other_cols]
logger.info("Reordered columns with 'continent' after 'country'.")

# Save cleaned CSV back to S3
output_path = "s3://sportcar-sales-prj/cleaned_dataset/cleaned_sportcar_sales.parquet"
df.to_parquet(output_path, engine='pyarrow', index=False, storage_options={"profile": "default"})
logger.info(f"Cleaned CSV saved to {output_path}.")
