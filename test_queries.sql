--Question 6
SELECT ID,
	(SELECT COUNT(*) AS secs_taught
	FROM teaches AS TT
	WHERE TT.ID = II.ID)
FROM instructor AS II;

--Question 7
SELECT *
FROM section NATURAL JOIN classroom
WHERE room_number = '134';
SELECT *
FROM section INNER JOIN classroom USING (room_number)
WHERE room_number = '134'
ORDER BY course_id;

SELECT *
FROM section INNER JOIN classroom using (room_number, building);

SELECT *
FROM section;


SELECT room_number, COUNT (sec_id)
FROM classroom INNER JOIN section USING (room_number)
GROUP BY room_number
ORDER BY room_number;

SELECT room_number, COUNT (sec_id)
FROM section NATURAL JOIN classroom
GROUP BY room_number
ORDER BY room_number;

--Question 11
SELECT EXTRACT (DAY FROM NOW());

--Question 27
SELECT name, course_id
FROM student NATURAL JOIN takes
ORDER BY student.id;

--Question 28
SELECT '2003-04-25';

