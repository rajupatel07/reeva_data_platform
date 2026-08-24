create table if not exists reeva_dataplatform.data_product.dim_classes
as
select  
row_number() over(order by class_id) as class_key,
class_id,
batch_id,
class_date,
class_day,
topic,
instructor,
status,
notes
from reeva_dataplatform.landing.classes;

create or replace table reeva_dataplatform.data_product.dim_classes
(
class_key bigint not null,
class_id string not null,
batch_id string not null,
class_date date not null,
class_day string,
topic string  not null,
instructor string not null,
status string not null,
notes string,
constraint dim_classes_pk primary key(class_key)
);

insert into reeva_dataplatform.data_product.dim_classes 
select 
row_number() over(order by class_id) as class_key,
class_id,
batch_id,
class_date,
class_day,
topic,
instructor,
status,
notes
from reeva_dataplatform.landing.classes;

select * from reeva_dataplatform.data_product.dim_classes

