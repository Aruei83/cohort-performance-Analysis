-- 08_course_cohort_ranking
-- purpose.rank every course/cohort that has run in the program
-- by attendance rate, alongside its completion rate, to spot which specific
-- offerings are underperforming and whether any course repeats near the 
-- bottom across multiple cohorts
WITH att AS (
	SELECT
    e.course_id,
    e.cohort_id,
    c.course_name,
    ROUND(100.0 * SUM(a.status IN ('present','Late'))
		/ COUNT(*), 1) AS attendance_rate
        
	FROM enrolments e
    JOIN courses c USING(course_id)
    JOIN attendance a USING(enrolment_id)
    WHERE a.status != ' Not recorded'
    GROUP BY course_id, cohort_id, course_name
    
    ),
    comp AS (
    SELECT
    course_id,
    cohort_id,
    c.course_name,
    ROUND(100.0 * SUM(e.status = 'Completed')/ COUNT(*), 1) AS completion_rate,
    COUNT(*) AS enrolled
    
	FROM enrolments e
    JOIN courses c USING(course_id)
    GROUP BY course_id, cohort_id, course_name
    )
    SELECT 
        att.course_name,
		att.cohort_id,
		att.attendance_rate,
		comp.completion_rate,
		comp.enrolled
	FROM att
    JOIN comp USING(course_id,cohort_id)
    ORDER BY att.attendance_rate ASC;
    
-- results; data analysis appears twice in the weakest five ( cohort 4 and 
-- cohort 5 )
    
    
    