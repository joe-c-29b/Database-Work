--------------------------------------------------------------
/*		The CREATE TABLE Statement and Its Extensions       */
--------------------------------------------------------------
    /*
        Information about the CREATE TABLE statement can be found at:
        https://www.postgresql.org/docs/9.1/sql-createtable.html
    */

--	CREATE TABLE ... LIKE Command
	CREATE TABLE new_student (
		LIKE student
	);



--	CREATE TABLE ... AS Command

	CREATE TABLE compSci_instructors AS (
		SELECT *
		FROM instructor
		WHERE dept_name = 'Comp. Sci.');
