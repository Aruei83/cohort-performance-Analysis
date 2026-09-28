-- 02_attendance_by_day_week
-- purpose ; find which day of the week has the weakest 
-- Attendance ,across all courses and cohorts
 
SELECT DISTINCT status
FROM attendance;

SELECT DAYNAME(session_date) day_of_weeks,
		SUM(status IN('present','Late')) / COUNT(*) AS attendance_rate
        
FROM attendance
WHERE status != 'Not Recorded'
GROUP BY DAYNAME(session_date)
ORDER BY attendance_rate ASC;
 
 --- FRIDAY HAS WEAKEST ATTENDANCE RATE(53.5%)
 
 -- Attendance rate by day of the week ,by cohort
 WITH cohort_attendance AS(
	SELECT c.cohort_label,DAYNAME(a.session_date) day_of_week,
		SUM(a.status IN ('present', ' Late')) / COUNT(*) AS attendance_rate
	FROM attendance a
    JOIN enrolments e ON a.enrolment_id = e.enrolment_id
    JOIN cohorts c ON e.cohort_id = e.cohort_id
	WHERE a.status != 'Not recorded'
    GROUP BY c.cohort_label, DAYNAME(a.session_date)
)
SELECT cohort_label,day_of_week,attendance_rate,
	RANK() OVER(PARTITION BY cohort_label ORDER BY attendance_rate) rank_
FROM cohort_attendance;
-- FRIDAY HAS WEAKEST ATTENDANCE RATE ACROSS ALL COHORTS

-- attendance by month of the year 
-- attendance by schedule (MWF VS MTWTF)

