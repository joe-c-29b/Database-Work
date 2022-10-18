--------------------------------------------------------------
/*		  Generating Unique Key Values and Sequences        */
--------------------------------------------------------------

--  The SERIAL Data Type
		CREATE TABLE autoIDgen (
			id SERIAL NOT NULL,
			name VARCHAR(30),
			CONSTRAINT autoIDgen_pkey PRIMARY KEY (id)		
		);
		
		INSERT INTO autoIDgen (name)
		VALUES ('Fred');
		INSERT INTO autoIDgen (name)
		VALUES ('susan');
		
		SELECT *
		FROM autoIDgen;


DROP TABLE autoIDgen;

--	Sequences

    /*
        Information about sequences can be found at:
        https://www.postgresql.org/docs/9.5/sql-createsequence.html
    */

	CREATE SEQUENCE IF NOT EXISTS id_numbers
	INCREMENT BY 3
	MINVALUE 10000 MAXVALUE 99999
	START WITH 11111;
    

    CREATE TABLE talent_agents (
    	ID INTEGER,
    	name VARCHAR(30),
    	company VARCHAR(30),
    	CONSTRAINT talent_agents_pkey PRIMARY KEY (ID)
    );

    CREATE TABLE talent_clients (
    	ID INTEGER,
    	name VARCHAR(30),
    	talent VARCHAR(30),
    	CONSTRAINT talent_clients_pkey PRIMARY KEY (ID)
    );

    INSERT INTO talent_agents (ID, name, company)
    VALUES (nextval('id_numbers'), 'Mary', 'Mary''s Got Talent');

    INSERT INTO talent_clients (ID, name, talent)
    VALUES (nextval('id_numbers'), 'Samantha', 'Juggling');

SELECT currval('id_numbers');
SELECT setval('id_numbers', 25000);

    INSERT INTO talent_agents (ID, name, company)
    VALUES (nextval('id_numbers'), 'Peter', 'Mary''s Got Talent');

    INSERT INTO talent_clients (ID, name, talent)
    VALUES (nextval('id_numbers'), 'Paul', 'Breathing Fire');
	
    -- Selection Option I
SELECT *
FROM talent_agents;

SELECT *
FROM talent_clients;

	-- Selection Option II
SELECT *
FROM (
	SELECT * FROM talent_agents
	UNION
	SELECT * FROM talent_clients) AS foobar(id, name, company_talent)
	ORDER BY CAST(foobar.id AS integer);
	
DROP TABLE talent_agents;
DROP TABLE talent_clients;
