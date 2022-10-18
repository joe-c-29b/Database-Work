--------------------------------------------------------------
/*		    Procedural Language Control Structures          */
--------------------------------------------------------------

--  The WHILE Loop

    /*
        General Form of the WHILE Loop:

            [ <<label>> ]
            WHILE boolean-expression LOOP
                statements
            END LOOP [ label ];

        Two Simple Examples:

            WHILE num1 > 0 AND num2 > 0 LOOP
                -- Multiple Computations Here
            END LOOP;

            <<loopName>>
            WHILE NOT done LOOP
                -- Multiple Computations Here
            END LOOP loopName;
    */

    --  Below is a toy example of a WHILE loop

CREATE OR REPLACE FUNCTION test_func(num INTEGER)
	RETURNS INTEGER
	LANGUAGE plpgsql
	AS
	$$
		DECLARE
			x INTEGER;
		BEGIN
			x := 0;
			
			<<whileLoop>>
			WHILE (num < 10) LOOP
				x := x + 1;
				num := num + 1;
			END LOOP whileLOOP;
			
			RETURN x;
		END;
	$$;

    --  This function can be invoked by the following SELECT statement:

SELECT test_func(2);

--  The Integer Variant For Loop

    /*
        General Form of the Integer Variant For Loop:

            [ <<label>> ]
            FOR name IN [ REVERSE ] exprs .. exprs [ BY exprs ] LOOP
            -- Multiple Statements Here
            END LOOP [ label ];

        Three Simple Examples:

            FOR i IN 1..10 LOOP
                -- i will take on values 1,2,3,4,5,6,7,8,9,10 within the loop
            END LOOP;

            FOR i IN REVERSE 10..1 LOOP
                -- i will take on values 10,9,8,7,6,5,4,3,2,1 within the loop
            END LOOP;

            FOR i IN REVERSE 10..1 BY 2 LOOP
                -- i will take on values 10,8,6,4,2 within the loop
            END LOOP;
    */

        --  Below is a toy example of a FOR loop
CREATE OR REPLACE FUNCTION test_func(num INTEGER)
	RETURNS INTEGER
	LANGUAGE plpgsql
	AS
	$$
		DECLARE
			x INTEGER;
		BEGIN
			x := 0;
			
			<<forLoop>>
			FOR loopIndex IN num .. 9 LOOP
				x := x + 1;
			END LOOP forLoop;
			
			RETURN x;
		END;
	$$;


    --  This function can be invoked by the following SELECT statement:
SELECT test_func(2);  --the output is the number of times it is able to loop through before the boolean is false


--  The Record Variant For Loop

    /*
        General Form of the Integer Variant For Loop:

            [ <<label>> ]
            FOR target IN query LOOP
                statements
            END LOOP [ label ];
    */

    /*  As an example of a for loop that iterates over individual tuples returned from a
        query, consider the following example.  Suppose we wish to find the total amount of
        money budgeted towards all departments in the university.  We could write the following
        query to accomplish this:   */



    --  We could, albeit more complicatedly, write a function to accomplish the same task as:

CREATE OR REPLACE FUNCTION sumDeptBudget()
RETURNS NUMERIC
LANGUAGE plpgsql
AS
$$
	DECLARE
		total NUMERIC(12,2);
		tuple RECORD;
	BEGIN
		total := 0.0;
		
		FOR tuple IN (SELECT * FROM department) LOOP
			total := total + tuple.budget;
		END LOOP;
		
		RETURN total;
	END;
$$;

    /*  We could invoke the following function using the below syntax to obtain the exact
        same result as the SELECT-FROM statement seen earlier.      */
             
SELECT sumDeptBudget();

--  The IF-THEN-ELSIF Conditional

/*
    General Form of the IF-THEN-ELSIF Conditional:

        IF boolean-expression THEN
            statements
        [ ELSIF boolean-expression THEN
            statements
        [ ELSIF boolean-expression THEN
            statements
        ...]]
        [ ELSE
            statements ]
        END IF;



















