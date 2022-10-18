--------------------------------------------------------------
/*					Natural Join Expressions		  		*/
--------------------------------------------------------------

--  Join Notes:
--  Two Kinds of Join Expressions: INNER and OUTER
--  Three Kinds of OUTTER Joins: LEFT, RIGHT, and FULL
--  Three Conditions to be Used with Joins: NATURAL, ON, and USING

-- The NATURAL JOIN

    --  Query: “For each student, find the set of courses that student has taken.”

    --  Previosuly we learned:
		SELECT name, course_id
		FROM student, takes
		WHERE student.id = takes.id
		ORDER BY name;


    --  Now, we can rewrite using a JOIN as:
		SELECT name, course_id
		FROM student NATURAL JOIN takes
		ORDER BY name;


    /*  The General Form:

        SELECT att_1, att_2, …, att_n
        FROM r_1 NATURAL JOIN r_2 NATURAL JOIN … NATURAL JOIN r_m
        WHERE pred;

        More generally:

        SELECT att_1, att_2, …, att_n
    	FROM E_1, E_2, …, E_m
    	WHERE pred;

        where each E_i can be a single relation or a join expression
    */

    --  Query: "List the names of students along with the titles of courses that they have taken."

		SELECT name, title  --this is incorrect because student shares an additional attribute with course
		FROM student NATURAL JOIN takes NATURAL JOIN course;
		
		SELECT name, title
		FROM student NATURAL JOIN takes, course
		WHERE takes.course_id = course.course_id;

    --  Let us contrast the above query with the following:

            -- The following DOES NOT produce the correct query results:
