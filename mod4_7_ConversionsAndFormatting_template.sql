--------------------------------------------------------------
/*		        Type Conversions and Formatting             */
--------------------------------------------------------------

--  The CAST Function

    /*
        General Form:
        CAST(expression AS type)
    */

    /*  Query: "Obtain a list of instrctor IDs and names ordered by the ID number."  */

        --  Incorrect Query
		SELECT ID, name
		FROM instructor
		ORDER BY ID;

        --  Correct Query
		SELECT CAST(ID AS integer) AS inst_id, name
		FROM instructor
		ORDER BY inst_id;



    -- Other Examples of CAST Function

        -- Example 1
		SELECT 	CAST('1' AS BOOLEAN),
				CAST('0' AS BOOLEAN),
				CAST('true' AS BOOLEAN),
				CAST('false' AS BOOLEAN),
				CAST('T' AS BOOLEAN),
				CAST('F' AS BOOLEAN);

        -- Example 2
		SELECT 	CAST('2019-07-14' AS DATE),
				CAST('13-July-2019' AS DATE);

        -- Example 3
		SELECT 5, CAST (5 AS numeric);

--  Other Conversion Functions

    /*
        General Forms:
            to_char(timestamp, text)
            to_char(interval, text)
            to_char(int, text)
            to_char(double precision, text)
            to_char(numeric, text)
            to_number(text, text)
            to_date(text, text)
            to_timestamp(text, text)
    */

    --  TO_CHAR()

        --  A Simple Example
		SELECT TO_CHAR(2017, '9,999'); ---9 is a placeholder for any digit 0-9; the comma is identifying that you would like your number to have a comma to identify thousand digit


        --  A More Complicated Example

            CREATE TABLE payTable (
            first_name		CHAR(30),
            last_name		CHAR(30),
            amount			numeric,
            payment_date	TIMESTAMP
            );

            INSERT INTO payTable
            VALUES ('Derrin', 'Doe', 2378.00, '9/20/2020 8:32:00');

            INSERT INTO payTable
            VALUES ('Jain', 'Strain', 5678.75, '9/25/2020 16:27:00');

            INSERT INTO payTable
            VALUES ('Peter', 'Piper', 3454.87, '9/27/2020 13:08:00');

		SELECT 
			first_name || ' ' || last_name ||
			'paid' ||
			TO_CHAR(amount, 'L9999D99')
			|| ' at ' ||
			TO_CHAR(payment_date, 'hH24:MI:SS')
			|| ' on ' ||
			TO_CHAR(payment_date, 'Mon-DD-YYYY')
			FROM payTable;


    --  TO_NUMBER()

		SELECT TO_NUMBER('12,345.6-', '99G999D9S');
		

    --  TO_DATE()
		SELECT TO_DATE('10 Feb 2017', 'DD Mon YYYY');


    /*
        More information about these conversion functions can be found at:
        https://www.postgresql.org/docs/11/functions-formatting.html
    */

--  The ROUND Function

		SELECT ROUND(3.14159265358979, 2) AS pi;

--  The COALESCE Function

    /*
        General Form:
        COALESCE(argument_1, argument_2, …);
    */

    --  A Simple Example:
	SELECT COALESCE(NULL, 3 + NULL, 2, 1234);



    --  Query: “Display all instructors' IDs and salaries, but show null values as 0.”

    -- First, insert an instructor with a null salary
	INSERT INTO instructor (id, name, dept_name, salary)
	VALUES ('20202', 'Nosal Instruc', 'Comp. Sci.', NULL);
	
	
	SELECT ID, COALESCE(salary, 0) AS salary
	FROM instructor
	ORDER BY ID;
	
