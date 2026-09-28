-- 01_data-quality_checks
-- purpose; checks the underlying records before trusting any analysis built
-- on them

USE arel_program;

-- Attendance data quality checks 
-- Enrollments per status- unknown records
SELECT status ,COUNT(*) AS total_enrollments 
FROM enrollments
GROUP BY status;


-- missing contact information for students
SELECT 
	SUM(email ='') AS missing_email,
    SUM(email ='') AS missing_phone 
FROM students;
    
-- 195 missing_email and 195 missing_phone

-- 

