import kagglehub
from kagglehub import KaggleDatasetAdapter, dataset_load
import boto3
import io

# Load dataset from kaggle
df = dataset_load(
    adapter=KaggleDatasetAdapter.PANDAS,
    handle="barissoy/sports-car-sales-prediction-via-sentiment-analysis",
    path="sports_car_sales_prediction_via_sentiment_analysis.csv"
)

# Upload to s3
s3 = boto3.client("s3")
csv_buffer = io.StringIO()
df.to_csv(csv_buffer, index=False)
s3.put_object(Bucket="sportcar-sales-prj", Key="sports_car_sales_prediction_via_sentiment_analysis.csv", Body=csv_buffer.getvalue())

print("✅ Dataset uploaded to S3!")