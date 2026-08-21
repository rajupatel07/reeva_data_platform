create table if not exists reeva_dataplatform.data_product.dim_batches
select
row_number() over(order by batch_id) as batch_key,
batch_id,
batch_name,
start_date,
end_date,
status,
created_at from reeva_dataplatform.landing.batches;

create or replace table reeva_dataplatform.data_product.dim_batches
(
batch_key	BIGINT,
batch_id	STRING,
batch_name	STRING,
start_date	DATE,
end_date	DATE,
status	STRING,
created_at	TIMESTAMP,
constraint dim_batches_pk primary key(batch_key)
);


insert into reeva_dataplatform.data_product.dim_batches 
select
row_number() over(order by batch_id) as batch_key,
batch_id,
batch_name,
start_date,
end_date,
status,
created_at from reeva_dataplatform.landing.batches;

select * from reeva_dataplatform.landing.batches
