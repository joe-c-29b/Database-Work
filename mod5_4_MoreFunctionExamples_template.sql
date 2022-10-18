--------------------------------------------------------------
/*		         More Function Examples in SQL              */
--------------------------------------------------------------

/*  Below is an example of two functions with the same name, that have different
    input arguments.  Both functions perform the same task: they return the
    number of credits that a student is taking for a given year and semester.
    The first function takes the student ID number, the year, and the semester,
    and returns the number of credits taken in that semester.  The second function
    takes only the student ID as input, and returns the number of credits the
    student is registered for during the current semester.

    The first function is shown below.      */



    --  We can invoke the function in the SELECT clause of a query like this:



    /*  The second function takes only the student ID as input, and returns the
        number of credits the student is registered for during the current semester.

        The second function is shown below.     */

        CREATE OR REPLACE FUNCTION num_student_courses(s_id varchar(5))
		RETURNS INTEGER
        	LANGUAGE plpgsql
        	AS $$

        	-- Declare Variables to be Used in Function Definition
        	DECLARE cur_month INTEGER;
        	DECLARE cur_year INTEGER;
        	DECLARE cur_sem VARCHAR(6);
        	DECLARE num_courses INTEGER;

        	-- Begin Function Body
        	BEGIN

        		-- Get the Current Year and Month
        		SELECT EXTRACT(YEAR FROM NOW()) INTO cur_year;
        		SELECT EXTRACT(MONTH FROM NOW()) INTO cur_month;

        		-- Determine the Semester Based on the Month
        		IF (cur_month = 8 OR cur_month = 9 OR cur_month = 10
        			OR cur_month = 11 OR cur_month = 12)
        			THEN cur_sem := 'Fall';
        		ELSIF (cur_month = 1 OR cur_month = 2 OR cur_month = 3 OR
        				cur_month = 4 OR cur_month = 5)
        			THEN cur_sem := 'Spring';
        		ELSE
        			-- Return 0 credits if summer months
        			num_courses := 0;
        			RETURN num_courses;
        		END IF;

        		-- Query to Find Number of Course Sections Taken
        		SELECT COUNT(*) INTO num_courses
        		FROM takes
        		WHERE ID = s_id AND year = cur_year AND semester = cur_sem;

        		-- Return Results
        		RETURN num_courses;

        	END;
        	$$;


    --  We can invoke the function in the SELECT clause of a query like this:



CREATE OR REPLACE FUNCTION num_student_courses(s_id VARCHAR(5), yearr INTEGER, semesterr VARCHAR(6))
RETURNS INTEGER
LANGUAGE plpgsql
AS
$$
	DECLARE
		num_courses INTEGER;
	BEGIN
		SELECT COUNT(*) INTO num_courses
		FROM takes
		WHERE id = s_id AND year = yearr AND semester = semesterr;
		
		RETURN num_courses;
	END;
$$;

CREATE OR REPLACE FUNCTION num_student_courses(s_id varchar(5))
RETURNS INTEGER
-- Specify Language Being Used for Function Definition
-- plpgsql = Procedural Language PostgreSQL
LANGUAGE plpgsql
AS $$
-- Declare Variables to be Used in Function Definition
	DECLARE cur_month INTEGER;
	DECLARE cur_year INTEGER;
	DECLARE cur_sem VARCHAR(6);
	DECLARE num_courses INTEGER;
-- Begin Function Body
	BEGIN
-- Get the Current Year and Month
		SELECT EXTRACT(YEAR FROM NOW()) INTO cur_year;
		SELECT EXTRACT(MONTH FROM NOW()) INTO cur_month;
-- Determine the Semester Based on the Month
		IF (cur_month = 8 OR cur_month = 9 OR cur_month = 10
		OR cur_month = 11 OR cur_month = 12)
		THEN cur_sem := 'Fall';
		ELSIF (cur_month = 1 OR cur_month = 2 OR cur_month = 3 OR
		cur_month = 4 OR cur_month = 5)
		THEN cur_sem := 'Spring';
		ELSE
-- Return 0 credits if summer months
		num_courses := 0;
		RETURN num_courses;
		END IF;
-- Query to Find Number of Course Sections Taken
		SELECT COUNT(*) INTO num_courses
		FROM takes
		WHERE ID = s_id AND year = cur_year AND semester =
		cur_sem;
		
		RETURN num_courses;
	END;
$$;

    /*  The functions we have created can be dropped from the database.
        However, since the two functions we wish to drop have the same name,
        we must specify which function we are referring to by indicating the
        number and data type of the input arguments.        */
		
		SELECT num_student_courses('24746', 2010, 'Fall');
		
		SELECT num_student_courses('12345');
