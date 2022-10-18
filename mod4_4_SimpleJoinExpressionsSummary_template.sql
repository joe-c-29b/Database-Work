--------------------------------------------------------------
/*		            JOIN Expressions Summary            	*/
--------------------------------------------------------------

-- Let's Consider a Toy Example:

    CREATE TABLE favSweets (
        person varchar(30),
        iceCream varchar(30),
        candy varchar(30)
    );

    CREATE TABLE favDrinks (
        person varchar(30),
        juice varchar(30),
        soda varchar(30)
    );

    INSERT INTO favSweets (person, iceCream, candy)
    VALUES ('Susan', 'Vanilla', 'Skittles');

    INSERT INTO favSweets (person, iceCream, candy)
    VALUES ('Nick', 'Chocolate', 'M&Ms');

    INSERT INTO favSweets (person, iceCream, candy)
    VALUES ('Carol', 'Chocolate Chip', 'Milky Way');

    INSERT INTO favDrinks (person, juice, soda)
    VALUES ('Nick', 'Orange Juice', 'Coca-Cola');

    INSERT INTO favDrinks (person, juice, soda)
    VALUES ('Carol', 'Apple Juice', 'Sprite');

    INSERT INTO favDrinks (person, juice, soda)
    VALUES ('Peter', 'Grape Juice', 'Mountain Dew');

--	View Tables

	SELECT *
	FROM favSweets;

	SELECT *
	FROM favDrinks;

--  NATURAL INNER JOIN



	-- ERRONEOUS QUERY: Need to specify how the join operation should merge data



    -- Correct query below:



--	USING Condition



--	ON Condition (Note: Duplicates Columns)



--  LEFT OUTER JOIN



--  RIGHT OUTER JOIN



--  FULL OUTER JOIN

    
