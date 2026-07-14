

WITH TEST AS (
SELECT "VendorID" AS  vendorid, "fare_amount"
FROM {{ source('nyc_taxi', 'yellow_tripdata' )}}
WHERE fare_amount > 0
)

SELECT * FROM test