WITH trips AS(
    SELECT *
    FROM {{ref('int_trips_time_buckets')}}
)

SELECT
    payment_type,
    pickup_dow,
    count(*) AS total_trips,
    ROUND(SUM(total_amount)::numeric,2) AS total_amount,
    ROUND(SUM(tip_amount)::numeric,2) AS total_tip_amount
FROM trips
GROUP BY payment_type, pickup_dow