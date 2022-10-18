--------------------------------------------------------------
/*				  The USING and ON Conditions   	  		*/
--------------------------------------------------------------

--  The USING Condition:

    --  Query: “List the names of students along with the titles of courses that they have taken.”

    --  ERRONEOUS QUERY:
		SELECT name, title
		FROM student NATURAL JOIN takes NATURAL JOIN course;
		
    --  Correct SQL Query:
		SELECT name, title
		FROM (student NATURAL JOIN takes) JOIN course USING (course_id);

-- The ON Condition

    /*  Query: “For each student who has taken some course, find all information
    about that student as well as the information about each course that
    student has taken.” */
	SELECT *
	FROM student JOIN takes ON student.id = takes.id;

    --  The above query is identical to:
	SELECT *
	FROM student, takes
	WHERE student.id = takes.id;	

    --  The two above queries are very similiar to:
	SELECT *
	FROM student NATURAL JOIN takes;
	
    --  We could also simply specify the exact attributes we want, such as:
	
        
