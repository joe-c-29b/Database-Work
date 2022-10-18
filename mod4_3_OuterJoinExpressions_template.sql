--------------------------------------------------------------
/*		              OUTER JOIN Expressions           		*/
--------------------------------------------------------------

--  OUTER JOIN Expressions Introduction

    /*  Query: “Find all information about every student, as well as the information
        about each course that student has taken.”      */
			SELECT * FROM student NATURAL JOIN takes;
            -- ERRONEOUS! DOES NOT CONSIDER ALL STUDENTS!
		SELECT * 
		FROM student LEFT OUTER JOIN takes ON takes.id = student.id;


--  INNER JOINS

    /*  The alternative, INNER JOIN, is the default JOIN type, and the keyword
        "INNER" is optional.  The following two queries are identical:        */



--  LEFT and RIGHT OUTER JOINs

    /*  Query: “Find all information about students, as well as the information
        about each course that student has taken.”      */
		SELECT * 
		FROM student NATURAL LEFT OUTER JOIN takes;
		SELECT *  --the NATURAL and ON operators are interchangeable here only because this is an outer join
		FROM student RIGHT OUTER JOIN takes ON takes.id = student.id;

    --  Query: “Find the name and ID of all students who have not taken a course.”
		SELECT name, ID
		FROM student NATURAL LEFT OUTER JOIN takes
		WHERE course_id IS NULL;


--  FULL OUTER JOINs

    /*  Query: "Display a list of all students in the Comp. Sci. department, 
	along with the course sections, if any, that they have taken in Spring 2009; 
	all course sections from Spring 2009 must be displayed, even if no student 
	from the Comp. Sci. department has taken the course section." */
	SELECT *
	FROM (SELECT *
		FROM student
		WHERE dept_name = ‘Comp. Sci.’)
	NATURAL FULL OUTER JOIN
		(SELECT *
		FROM takes
		WHERE semester = ‘Spring’ AND year = 2009);  --this will not work because the subqueries are not aliased, which is a requirement in Postgresql
	
    --  Alternatively, using the WITH construct:
	WITH Left_t AS 
		(SELECT *
		FROM student
		WHERE dept_name = 'Comp.Sci'),
		Right_t AS
		(SELECT *
		FROM takes
		WHERE semester = 'Spring' AND year = 2009)
	SELECT *
	FROM Left_t NATURAL FULL OUTER JOIN Right_t;


-- The ON Clause

	-- ON Clause Example with OUTER JOIN Expression:
		SELECT * FROM student LEFT OUTER JOIN takes ON takes.id = student.id;

	-- The following query DOES NOT produce the same results as the above:
		SELECT *
		FROM student LEFT OUTER JOIN takes ON TRUE
		WHERE takes.id = student.id;














