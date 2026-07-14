{{
    config(
    materialized = 'view'
    )
}}


WITH TEST AS (
SELECT "VendorID", fare_amount
FROM {{source('nyc_taxi', 'yellow_tripdata')}}
WHERE fare_amount > 0
)

SELECT * FROM test limit 100