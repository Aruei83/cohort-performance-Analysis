-- 05_schedule_comparison.sql

-- question 
-- Does the number of training days per week affect attendance?

-- cohorts 1 to 5 used a three-day of the week (MWF),which cohort 6
-- used a Five-day week (MTWTF).

SELECT
	c.Schedule,
    ROUND(100 * SUM(a.status IN ('present', 'Late')) / COUNT(*),1
    ) AS attendance_rate,
    COUNT(*)  AS sessions
    
FROM attendance a
JOIN enrolments e ON a.enrolment_id = e.enrolment_id
JOIN cohorts c ON e.cohort_id = c.cohort_id

WHERE a.status <>' Not Recorded'
GROUP BY c.Schedule;

-- result;
-- attendance is almost the same under both schedules;
-- 58.0% for the five day of the week and 58.9% for the three day week.
-- the difference is less than on percentage point, suggesting
-- that the change in weekly schedule had little difference in
-- attendance based on the available data.

