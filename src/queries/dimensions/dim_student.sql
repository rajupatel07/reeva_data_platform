create table if not exists reeva_dataplatform.data_product.dim_student as
select 
row_number() over (order by student_id) as student_key,
student_id,
name as student_name,
email,
city,
country,
phone_no,
linkedin_link,
github_link,
created_at
from reeva_dataplatform.landing.students;

create or replace table reeva_dataplatform.data_product.dim_students
(student_key bigint not null,
student_id int not null,
student_name string not null,
email string not null,
city string,
country string,
phone_no string,
linkedin_link string,
github_link string,
created_at timestamp,
constraint pk_dim_students primary key (student_key)
);

insert into reeva_dataplatform.data_product.dim_students
select 
row_number() over (order by student_id) as student_key,
student_id,
name as student_name,
email,
city,
country,
phone_no,
linkedin_link,
github_link,
created_at
from reeva_dataplatform.landing.students;

select * from reeva_dataplatform.data_product.dim_students

