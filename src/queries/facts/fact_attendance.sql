create or replace table reeva_dataplatform.data_product.fact_attendance
(
    attendance_id       STRING,
    student_key         BIGINT,
    class_key           BIGINT,
    batch_key           BIGINT,
    date_key            INT,
    attendance_status   STRING,
    joined_at           TIMESTAMP,
    remarks             STRING,
    attendance_count    INT,
    present_flag        INT,
    absent_flag         INT,
    late_flag           INT,

    CONSTRAINT pk_fact_attendance PRIMARY KEY (attendance_id)
);
-- 2. Insert Transformed 
INSERT INTO reeva_dataplatform.data_product.fact_attendance (
    attendance_id,
    student_key,
    class_key,
    batch_key,
    date_key,
    attendance_status,
    joined_at,
    remarks,
    attendance_count,
    present_flag,
    absent_flag,
    late_flag
)
SELECT
    a.attendance_id,
    ds.student_key,
    dc.class_key,
    db.batch_key,
    dd.date_key,
    a.attendance_status,
    -- FIXED: Handles 'nan' and malformed strings by safely converting to NULL
    TRY_CAST(a.joined_at AS TIMESTAMP) AS joined_at,
    a.remarks,
    CASE
        WHEN a.attendance_status = 'Present' THEN 1
        ELSE 0
    END AS attendance_count,

    CASE 
        WHEN a.attendance_status = 'Present' THEN 1
        ELSE 0
    END AS present_flag,

    CASE
        WHEN a.attendance_status = 'Absent' THEN 1
        ELSE 0
    END AS absent_flag,

    CASE 
        WHEN a.attendance_status = 'Late' THEN 1
        ELSE 0
    END AS late_flag

FROM reeva_dataplatform.landing.attendance a

LEFT JOIN reeva_dataplatform.data_product.dim_students ds
    ON a.student_id = ds.student_id

LEFT JOIN reeva_dataplatform.data_product.dim_classes dc
    ON a.class_id = dc.class_id

LEFT JOIN reeva_dataplatform.data_product.dim_batches db
    ON dc.batch_id = db.batch_id

LEFT JOIN reeva_dataplatform.data_product.dim_date dd
    ON dc.class_date = dd.date;

 
