with source as (

    select * from {{ source('nyc_taxi', 'yellow_tripdata') }}

),

renamed as (

    select
        "VendorID" AS vendorid,
        "tpep_pickup_datetime" AS pickup_datetime,
        "tpep_dropoff_datetime" AS dropoff_datetime,
        "passenger_count" AS passenger_count,
        "trip_distance" AS trip_distance,
        CASE "RatecodeID"
            when 1 then 'Standard rate'
            when 2 then 'JFK'
            when 3 then 'Newark'
            when 4 then 'Nassau or Westchester'
            when 5 then 'Negotiated fare'
            when 6 then 'Group ride'
            WHEN 99 then 'Null/Unknown'
            else 'Unknown'
        end    
         AS RatecodeID,
        "store_and_fwd_flag" AS store_and_fwd_flag, 
        "PULocationID" AS pickup_location_id,
        "DOLocationID" AS dropoff_location_id,
        CASE "payment_type"
            when 0 then 'Flex Fare trip'
            when 1 then 'Credit Card'
            when 2 then 'Cash'
            when 3 then 'No Charge'
            when 4 then 'Dispute'
            else 'Unknown'
        end AS payment_type,
        "fare_amount" AS fare_amount,
        "extra" AS extra,
        "mta_tax" AS mta_tax,
        "tip_amount" AS tip_amount,
        "tolls_amount" AS tolls_amount,
        "improvement_surcharge" AS improvement_surcharge,
        "total_amount" AS total_amount,
        "congestion_surcharge" AS congestion_surcharge,
        "airport_fee" AS airport_fee

    from source

),
deduped as (
    select *,
        row_number() over (
            partition by pickup_datetime, dropoff_datetime, vendorid
            order by total_amount desc
        ) as row_num
    from renamed
),

final as (
    select
        {{ dbt_utils.generate_surrogate_key(['pickup_datetime', 'dropoff_datetime', 'vendorid']) }} as trip_id,
        *
    from deduped
    where row_num = 1
)
select * from final