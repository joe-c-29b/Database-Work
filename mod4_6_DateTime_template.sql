--------------------------------------------------------------
/*		            Date and Time Data Types           		*/
--------------------------------------------------------------

/* A few data types for specifying dates and times:

	1)	DATE: A calendar date containing a (four-digit) year, month, and day of the month
	2)	TIME: The time of day, in hours, minutes, and seconds.  A variant, TIME(p),
		can be used to specify the number of fractional digits for seconds
		(the default being 0).  It is also possible to store time-zone information
		along with the time by specifying TIME WITH TIMEZONE.
	3)	TIMESTAMP: A combination of DATE and TIME.  A variant, TIMESTAMP(p) can
		be used to specify the number of fractional digits for seconds
		(the default being 6).  Time-zone information is also stored if
		WITH TIMEZONE is specified.

	--	Date and time values can be specified like this:

		DATE ‘2018-04-25’
		TIME ‘09:30:00’
		TIMESTAMP ‘2018-04-25 10:29:01.45’
*/

--	Create Example Table

	CREATE TABLE testing_time (
		date_1 DATE,
		date_2 DATE,
		time_1 TIME,
		time_2 TIME,
		interval_1 INTERVAL
	);
	
	INSERT INTO testing_time
	VALUES ('2020-08-21', '2010-08-21', '01:30:00', '09:45:00',
		   	'1 year 3 months 4 days 10 hours 6 minutes 8 seconds');
	
	
	
	
	
	
	DROP TABLE testing_time;

--	Insert Example Values


-- 	Get Current Date and/or Time
	SELECT CURRENT_DATE, 
		CURRENT_TIME, 
		LOCALTIME, 
		CURRENT_TIMESTAMP, 
		LOCALTIMESTAMP, 
		NOW();


--	EXTRACT Operation

	-- General Form:  EXTRACT(field FROM data_value)
	SELECT EXTRACT (year FROM NOW());
	SELECT EXTRACT (day FROM CURRENT_DATE);
	SELECT EXTRACT (hour FROM LOCALTIMESTAMP);
	

-- 	Example Arithmetic and Comparison Operations

	SELECT date_1 - date_2
	FROM testing_time;
	
	SELECT NOW() - interval_1
	FROM testing_time;

--	Scalar SELECT Statements

	
	SELECT DATE '2020-08-21';
	SELECT TIME '09:30:00';
	SELECT TIMESTAMP '8/21/2020 15:32:00';



--	Example: Regular String Value
	SELECT '2020-08-21';
	SELECT '09:30:00';
	SELECT '8/21/2020 15:32:00';