SELECT *
FROM {{ ref('stg_test') }}
WHERE fare_amount < 0