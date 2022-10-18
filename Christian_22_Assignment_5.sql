/*
    Name: Joseph Christian
    DTSC660: Data and Database Managment with SQL
    Module 5
    Assignment 5
*/

--------------------------------------------------------------------------------
/*				                 Question 1          		  		          */
--------------------------------------------------------------------------------



CREATE OR REPLACE FUNCTION Christian_22_monthlyPayment (Principle NUMERIC(11, 2),
														APR NUMERIC(11, 6),
														years INTEGER)  
	RETURNS MONEY				
	LANGUAGE plpgsql
	AS
	$$
		DECLARE m_payment MONEY;
		DECLARE	i DECIMAL(7, 6);
		DECLARE	Pr NUMERIC(11, 2);
		DECLARE	n NUMERIC(6, 0);
		
		BEGIN
			i := (APR/12);
			Pr := Principle;
			n := years * 12;
			
			SELECT Pr*(
					i+(
						i/(
							((1+i)^n)-1))) INTO m_payment;
							
			RETURN m_payment;
		END
	$$;

SELECT Christian_22_monthlyPayment (250000.00, 0.04125, 30);


--------------------------------------------------------------------------------
/*				                  Question 2           		  		          */
--------------------------------------------------------------------------------
---CREATE TABLE---
CREATE TABLE student_course_nums (
	ID VARCHAR(5), 
	name VARCHAR(20), 
	tot_courses INTEGER,
	CONSTRAINT student_course_numsPK PRIMARY KEY (ID));
DROP TABLE student_course_nums;

---CREATE PROCEDURE---
	CREATE OR REPLACE PROCEDURE	Christian_22_stuCourseNumsProc(IN ID VARCHAR(5))
	LANGUAGE plpgsql
	AS 
	$$
		DECLARE tot_courses2 INTEGER;
		DECLARE ID VARCHAR(5);
		DECLARE name VARCHAR(20);
		
		
		BEGIN
			SELECT COUNT(*) INTO tot_courses2
			FROM takes
			WHERE takes.ID = Christian_22_stuCourseNumsProc.ID;

			
			IF (SELECT Christian_22_stuCourseNumsProc.ID IN 
						(SElECT student_course_nums.ID 
						 FROM student_course_nums))
			
				THEN UPDATE student_course_nums 
					 SET tot_courses = tot_courses2
					 WHERE Christian_22_stuCourseNumsProc.ID = student_course_nums.ID;

			ELSIF (SELECT Christian_22_stuCourseNumsProc.ID NOT IN 
				   		(SElECT student_course_nums.ID 
						 FROM student_course_nums))
			
				THEN
					INSERT INTO student_course_nums 
						SELECT student.ID, student.name, tot_courses2
						FROM student 
						WHERE Christian_22_stuCourseNumsProc.ID = student.ID;
			
			END IF;	
		END;
	$$;
	
---CALL PROCEDURE---
CALL Christian_22_stuCourseNumsProc('79352');

---CHECK TABLE---	
SELECT * FROM student_course_nums;


	


---TESTING for already existing ID updates---
INSERT INTO student_course_nums						--purposefully input a false quantity on the table n the tot_courses column
	SELECT ID, name, '5'
	FROM student
	WHERE id = '35175';
	
SELECT * FROM student_course_nums;					--check that false value has populated
CALL Christian_22_stuCourseNumsProc('35175');		--Call the procedure for the ID with the false tot_courses
SELECT * FROM student_course_nums;					--Confirm that false quantity was changed
SELECT COUNT(id) FROM takes WHERE id = '35175';		--check how many courses should be in tot_courses
----------------------------------------------
