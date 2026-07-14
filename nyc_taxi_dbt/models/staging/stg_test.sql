{{
    config(
    materialized = 'view'
    )
}}


WITH TEST AS (
SELECT "VendorID", fare_amount
FROM raw.yellow_tripdata)

SELECT * FROM test limit 100