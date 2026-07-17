WITH trips AS(
    SELECT *
    FROM {{ref('int_trips_time_buckets')}}
)

SELECT  
    pickup_hour,
    pickup_time_bucket,
    COUNT(*) AS total_trips,
    ROUND(SUM(fare_amount)::numeric,2) AS total_fare_amount,
    ROUND(AVG(fare_amount)::numeric,2) AS avg_fare_amount,
    ROUND(SUM(tip_amount)::numeric,2) AS total_tip_amount,
    ROUND(AVG(tip_amount)::numeric,2) AS avg_tip_amount,
    ROUND(SUM(total_amount)::numeric,2) AS total_amount,
    ROUND(AVG(total_amount)::numeric,2) AS avg_total_amount,
    ROUND(SUM(trip_distance)::numeric,2) AS total_trip_distance
FROM trips
GROUP BY pickup_hour, pickup_time_bucket