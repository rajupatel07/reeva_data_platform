-- 1. Create Table Definition
create or replace table reeva_dataplatform.data_product.dim_date (
    date_key INT NOT NULL,
    date DATE NOT NULL,
    year INT NOT NULL,
    quarter INT NOT NULL,
    month INT NOT NULL,
    month_name STRING NOT NULL,
    week_of_year INT NOT NULL,
    day INT NOT NULL,
    day_name STRING NOT NULL,
    day_of_week INT NOT NULL,
    is_weekend BOOLEAN NOT NULL,
    CONSTRAINT pk_dim_date PRIMARY KEY (date_key)
);

-- 2. Insert Transformed using Sequence CTE
insert into reeva_dataplatform.data_product.dim_date
With dates as(
SELECT 
        explode(
            sequence(
                to_date('2020-08-01'),
                to_date('2030-07-30'),
                INTERVAL 1 DAY
            )
        ) AS date
)
SELECT 
    CAST(date_format(date, 'yyyyMMdd') AS INT) AS date_key,
    date,
    CAST(year(date) AS INT)                     AS year,
    CAST(quarter(date) AS INT)                  AS quarter,
    CAST(month(date) AS INT)                    AS month,
    date_format(date, 'MMMM')                   AS month_name,
    CAST(weekofyear(date) AS INT)               AS week_of_year,
    CAST(day(date) AS INT)                      AS day,
    date_format(date, 'EEEE')                   AS day_name,
    CAST(dayofweek(date) AS INT)                AS day_of_week,
    CASE 
        WHEN dayofweek(date) IN (1, 7) THEN TRUE 
        ELSE FALSE 
    END                                         AS is_weekend
FROM dates;

select * from reeva_dataplatform.data_product.dim_date