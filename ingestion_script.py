# load_taxi.py
import pandas as pd
from sqlalchemy import create_engine

engine = create_engine("postgresql://dbt_user:Something123@localhost:5432/nyc_taxi")

df = pd.read_parquet("nyc_taxi_data/yellow_tripdata_2023-01.parquet")

# Load into a raw schema
df.to_sql(
    "yellow_tripdata",
    engine,
    schema="raw",
    if_exists="replace",
    index=False,
    chunksize=10000
)
print(f"Loaded {len(df):,} rows")