CREATE TABLE instructor (
	ID 			varchar(5),
	name		varchar(20) NOT NULL,
	dept_name	varchar(20),
	salary		numeric(8,2),
	CONSTRAINT instructor_pkey PRIMARY KEY	(ID)
);


--CREATE TABLE instructor (
--	ID 			varchar(5),
--	name		varchar(20) CONSTRAINT insNotNull NOT NULL,
--	dept_name	varchar(20),
--	salary		numeric(8,2),
--	CONSTRAINT instructor_pkey PRIMARY KEY	(ID)
--);

CREATE TABLE department (
	dept_name	varchar(20),
	building	varchar(15),
	budget		numeric(12,2) CONSTRAINT positiveBudget CHECK(budget > 0.00)
);

CREATE TABLE section (
	course_id		varchar(20),
	sec_id			varchar(15),
	semester		varchar(8)
		CONSTRAINT semesterCheck CHECK (semester IN ('Fall', 'Winter', 'Spring', 'Summer')),
	year			numeric(4,0),
	building		varchar(15),
	room_number		varchar(4),
	time_slot_id	varchar(4),
	CONSTRAINT section_pkey PRIMARY KEY (course_id, sec_id, semester, year),
	CONSTRAINT section_fkey_1 FOREIGN KEY (course_id) REFERENCES course (course_id) ON DELETE CASCADE,
	CONSTRAINT section_fkey_2 FOREIGN KEY (building, room_number) REFERENCES classroom (building, room_number)
		ON DELETE SET NULL
);

CREATE TABLE student (
	ID				varchar(5),
	name			varchar(20) 	NOT NULL,
	dept_name		varchar(20) 	DEFAULT 'Exploratory Studies',
	tot_cred		numeric(3,0)	DEFAULT 0
);

UPDATE student
SET dept_name = 'Physics'
WHERE name = 'John Cena';
	
ALTER TABLE student ADD favIceCream varchar(20);
ALTER TABLE student DROP favIceCream;
ALter tABLE student ADD CONSTRAINT iceCreamCheck CHECK(favIceCream IN ('Chocolate', 'vanilla'));
ALTER TABLE student DROP CONSTRAINT iceCreamCheck;
	
INSERT INTO instructor (ID, name, dept_name, salary)
VALUES ('99999', 'Fred Flintstone', 'comp.sci',);
	

	
	
INSERT INTO student (ID, name)
VALUES ('98765', 'John Cena');
	
SELECT * 
FROM student;
	
