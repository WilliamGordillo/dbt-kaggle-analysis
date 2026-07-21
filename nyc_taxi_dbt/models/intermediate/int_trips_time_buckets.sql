WITH trips AS(
    SELECT *
    FROM {{ ref('stg_yellow_trips') }}
)

SELECT *,
        date_part( 'hour', pickup_datetime) AS pickup_hour,
        date_part( 'hour', dropoff_datetime) AS dropoff_hour,
        date_part( 'dow', pickup_datetime) AS pickup_dow,
        case date_part( 'dow', pickup_datetime)
            when 0 then 'Sunday'
            when 1 then 'Monday'
            when 2 then 'Tuesday'
            when 3 then 'Wednesday'
            when 4 then 'Thursday'
            when 5 then 'Friday'
            when 6 then 'Saturday'
        end AS pickup_dow_name,
        date_part('month', pickup_datetime) AS month,
        CASE 
            WHEN date_part('hour', pickup_datetime) BETWEEN 7 AND 9 THEN 'Morning Rush'
            WHEN date_part('hour', pickup_datetime) BETWEEN 11 AND 15 THEN 'Midday'
            WHEN date_part('hour', pickup_datetime) BETWEEN 16 AND 19 THEN 'Evening Rush'
            WHEN date_part('hour', pickup_datetime) BETWEEN 20 AND 23 THEN 'Night'
            ELSE 'Off Peak'
        END AS pickup_time_bucket,
        {{ get_duration_minutes( 'pickup_datetime','dropoff_datetime') }} AS trip_duration
FROM trips