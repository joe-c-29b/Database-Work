---using distinct
SELECT DISTINCT dept_name
FROM instructor;

---find the names of all instructors in the Comp Science department who have a salary greater than 70K
SELECT name
FROM instructor
WHERE dept_name = 'Comp. Sci.' AND salary > 70000;

---find the names of all instructors, along with their department names and department building names
SELECT name, instructor.dept_name, building
FROM instructor, department
WHERE instructor.dept_name = department.dept_name;

---for all instructors in the university who have taught some course, find their names and course ID of all courses they taught
SELECT name AS instructor_name, course_id
FROM instructor, teaches
WHERE instructor.id = teaches.id;

---for all instructors in the Computer Science department who have taught some course, find their names and the ccourse ID of all courses they taught
SELECT name, course_id
FROM instructor, teaches
WHERE dept_name = 'Comp. Sci.' AND instructor.id = teaches.id;

---find the names of all instructors whose salary is greater than at least one instructor in the Biology department
SELECT DISTINCT T.name
FROM instructor AS T, instructor AS S
WHERE T.salary > S.salary AND S.dept_name = 'Biology'; 

---find all instructors that have an a' in their name either capital or lowercase
SELECT *
FROM instructor
WHERE (name LIKE '%a%') OR (name LIKE '%A%');

---find the names of all departments whose building name includes the substring 'Watson'
SELECT dept_name, building
FROM department
WHERE building LIKE '%Watson%';

---find and list the names of all instructors in the physics department in alphabetical order
SELECT name
FROM instructor
WHERE dept_name = 'Physics'
ORDER BY name;

---find and list all information about instructors at the university. order the query results first in desc order of salary then by asc order of name in the event that several instructors have the same salary
SELECT *
FROM instructor
ORDER BY salary ASC, name DESC;

---find the names of instructors with salary amounts between 90K and 100K
SELECT name
FROM instructor
WHERE salary BETWEEN 90000 AND 100000;

SELECT name
FROM instructor
WHERE salary <= 100000 AND salary >= 90000;

---find the names of all instructors who have a null value for their salary
SELECT name
FROM instructor
WHERE salary IS NULL;

---find the names of all instructors who have a nonnull value for their salary
SELECT name
FROM instructor
WHERE salary IS NOT NULL;

---find the set of all courses taught either in Fall 2017 or in SPring 2018 or in both
(SELECT course_id
FROM section
WHERE semester = 'Fall' AND year = 2017)
UNION
(SELECT course_id
FROM section
WHERE semester = 'Spring' AND year = 2018);

---find the set of all courses taught in both Fall 2017 and Spring 2018
(SELECT course_id
FROM section
WHERE semester = 'Fall' AND year = 2017)
INTERSECT
(SELECT course_id
FROM section
WHERE semester = 'Spring' AND year = 2018);

---find the set of all courses taught in both Fall 2017 but not in Spring 2018
(SELECT course_id
FROM section
WHERE semester = 'Fall' AND year = 2017)
EXCEPT
(SELECT course_id
FROM section
WHERE semester = 'Spring' AND year = 2018);

---find the average salary of instructos in the computer science department
SELECT AVG (salary)
FROM instructor
WHERE dept_name = 'Comp. Sci';

---find the number of instructors who taught a course in the SPring 2018 semester
SELECT COUNT (DISTINCT ID)
FROM teaches
WHERE semester = 'Spring' AND year = 2018;

---find the name of each department and average salary of instructors in each department only for departments aving an average salary greater than 42000
SELECT dept_name, AVG (salary) AS avg_salary
FROM instructor
GROUP BY dept_name
HAVING AVG (salary) > 42000;

---for each course esection offered in 2017, find the average total credits(tot_cred) of all students nrolled in the section, if the section has at least 2 students
SELECT course_id, semester, year, sec_id, AVG(tot_cred)
FROM student, takes
WHERE student.ID = takes.ID AND year = 2017
GROUP BY course_id, semester, year, sec_id
HAVING COUNT(takes.id) >= 2;

---set membership
---find the set of all courses taught in both Fall 2017 and Spring 2018
(SELECT course_id
FROM section
WHERE semester = 'Fall' AND year = 2017)
INTERSECT
(SELECT course_id
FROM section
WHERE semester = 'Spring' AND year = 2018);
--instead
SELECT DISTINCT course_id
FROM section
WHERE semester = 'Fall' AND year = 2017 AND
	course_id IN (SELECT DISTINCT course_id
					FROM section
					WHERE semester = 'Spring' AND year = 2018);


---find the names of all instructors other than those named Mozart or Einstein
SELECT DISTINCT name
FROM instructor
WHERE name NOT IN ('Mozart', 'Einstein');


---patternmatching
---find all instructors that have an a in their name, either capital or lowercase
SELECT NAME
FROM instructor
WHERE (name LIKE '%a%') OR (name LIKE '%A%');

---find the names of all departments whose building name includes the substring 'Watson'
SELECT dept_name
FROM department
WHERE building LIKE '%Watson%';


---nested subqueries
---set membership
---find all courses ttaught in both the fall 2017 and spring 2018 semesters
--(SELECT course_id
--FROM section
--WHERE semester = 'Fall' AND year = 2017)
--INTERSECT
--(SELECT course_id
--FROM section
--WHERE semester = 'Spring' AND year = 2018);
SELECT DISTINCT course_id
FROM section
WHERE semester = 'Fall' AND year = '2017'
AND course_id IN (SELECT course_id
				   	FROM section
				   	WHERE semester = 'Spring' AND year = 2018);

---find the names of all instructors other than those named Mozart or Einstein
SELECT DISTINCT name
FROM instructor
WHERE name NOT IN ('Mozart', 'Einstein');

---find the total number of students who have taken course sections taught by the instructor with the ID 34175
SELECT COUNT (DISTINCT ID)
FROM takes
WHERE (course_id, sec_id, semester, year) IN 
(SELECT course_id, sec_id, semester, year
FROM teaches
WHERE teaches.ID = '34175');

---find the names of all instructors whose salary is greater than at least one instructor in the bio department
SELECT name
FROM instructor
WHERE salary > SOME (SELECT salary FROM instructor WHERE dept_name = 'Biology');

---find the names of all instructors that have a salary value greater than that of each instructor in the bio dep
SELECT name
FROM instructor
WHERE salary > ALL (SELECT salary, FROM instructor WHERE dept_name = 'Biology');

---find the departments that have the highest average salary
SELECT dept_name, AVG(salary)
FROM instructor
GROUP BY dept_name
HAVING AVG(salary) > SOME (SELECT AVG(salary)
FROM instructor
GROUP BY dept_name);

---find all courses taught in both the fall 2017 and spring 2018 semester
SELECT course_id
FROM section AS S
WHERE semester = 'Fall' AND year = '2017' AND
EXISTS (SELECT * FROM section AS T WHERE semester = 'Spring' and year = '2018' and S.course_id = T.course_id);

---find all students who have taken all courses offered in the bio department
SELECT S.ID, S.name
FROM Student AS S
WHERE NOT EXISTS (( SELECT course_id
				  FROM course
				  WHERE dept_name = 'Biology') 
				  EXCEPT( SELECT T.course_id
						FROM takes AS T
						WHERE S.ID = T.ID));

SELECT course_id
FROM course
WHERE dept_name = 'Biology';

SELECT DISTINCT T.course_id
FROM takes AS T, Student AS S, course AS C
WHERE S.ID = T.ID 
	   AND T.course_id = C.course_id
	   AND C.dept_name = 'Biology';
	   
SELECT C.course_id
FROM course AS C
WHERE dept_name = 'Biology'
EXCEPT 
(SELECT T.course_id
FROM takes AS T, Student AS S
WHERE S.ID = T.ID);

---find the total number of distinct  students who have taken course sections taught by the instructor with the ID 10101
--SELECT COUNT (DISTINCT ID)
--FROM takes
--WHERE (course_id, sec_id, semester, year) IN 
--(SELECT course_id, sec_id, semester, year
--FROM teaches
--WHERE teaches.ID = '34175');
SELECT COUNT (DISTINCT ID)
FROM Takes AS T
WHERE EXISTS (SELECT course_id, sec_id, semester, year
			 FROM teaches AS Te
			 WHERE Te.ID = '10101'
			 AND T.course_id = Te.course_id
			 AND T.sec_id = Te.sec_id
			 AND T.semester = Te.semester
			 AND T.year = Te.year);
			 
---find all courses that were offered at most once in 2017
SELECT T.course_id
FROM course AS T
WHERE 1 >= (SELECT COUNT(R.course_id)
		   FROM section AS R
		   WHERE T.course_id = R.course_id AND R.year = '2017');
		   
---find the average instructors salaries of those departments where the average salary is greater than 42000
SELECT dept_name, AVG(salary) AS avg_salary
FROM instructor AS I
GROUP BY dept_name
HAVING AVG(salary) > 42000;

SELECT dept_name, avg_salary
FROM (SELECT dept_name, AVG(salary) AS avg_salary 
	  FROM instructor 
	  GROUP BY dept_name) AS dept_avg(dept_name, avg_salary)
WHERE avg_salary > 42000;

---find the maximum across all departments of the total of all instructors salaries in each department
SELECT dept_name, max_salary
FROM (SELECT dept_name, MAX(salary) AS max_salary FROM instructor GROUP BY dept_name) AS dept_max(dept_name, max_salary)
ORDER BY max_salary;

SELECT MAX(tot_salary)
FROM (SELECT dept_name, SUM(salary) AS tot_salary FROM instructor GROUP BY dept_name) AS dept_max(dept_name, tot_salary);

---with clause
---find the names and bugets of departments with the max budget --temporary relation to house the definition of a subquery, can be used multiple times throughout the query
WITH max_budget (value) AS  
	(SELECT MAX(budget)
	FROM department)
SELECT dept_name, budget
FROM department, max_budget
WHERE department.budget = max_budget.value;

---find all departments where the total salary is greater than the average of the total salary at all departments
WITH sum_salary (dept_name, value) AS
	(SELECT dept_name, SUM(salary) FROM instructor GROUP BY dept_name), 
	avg_salary (value) AS (SELECT AVG(value) FROM sum_salary)
SELECT dept_name
FROM sum_salary, avg_salary
WHERE sum_salary.value > avg_salary.value;

---scalar subqueries
---scalar means it is a single number, no direction or magnitude
---find the names of all departments along with the number of instructors in each department
SELECT dept_name, (SELECT COUNT(*) 
				   FROM instructor 
				   WHERE department.dept_name = instructor.dept_name) 
				   AS instructor_tot
FROM department
ORDER BY dept_name;

--SELECT dept_name, COUNT(DISTINCT ID)
--FROM instructor
--GROUP BY dept_name;

---scalar without a FROM clause
---find the average number of sections taught per instructor(regardless of year/semester); sections taught by multiple instructors count once per instructor
SELECT 1.0*(SELECT COUNT(*) FROM teaches) / (SELECT COUNT(*) FROM instructor);

---deleting stuff
DELETE FROM instructor
WHERE dept_name IN (SELECT dept_name
				   FROM department
				   WHERE buidling = 'Watson');
				   
---delete the records of all instructors with a salary below the average at the university
DELETE FROM instructor
WHERE salary < (SELECT AVG(salary)
			   FROM instructor);
			   
SELECT AVG(salary)
FROM instructor;


---insertion
---make each student in the music department who has earned more than 144 credit hours an instructor in the music department with a salary of 18K
INSERT INTO instructor
SELECT ID, name, 18000
FROM student
WHERE tot_cred > 144 AND dept_name = 'Music';

---updating
---give a 5% salary raise to instructors whose salary is less than average
UPDATE instructor
SET salary = salary * 1.05
WHERE salary < (SELECT AVG(salary)
			   FROM instructor);
			   
---give all instructors whose salary is over 100k a 3% salary raise and give all other instructors a 5% raise
UPDATE instructor
SET salary = salary * 1.03
WHERE salary > 100000;
UPDATE instructor
SET salary = salary * 1.05
WHERE salary < 100000;


