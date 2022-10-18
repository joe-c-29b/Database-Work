CREATE TABLE branch (
		branch_name	VARCHAR(40),
		branch_city	VARCHAR(40) CHECK(branch_city = 'Brooklyn' 
									  OR branch_city = 'Bronx' 
									  OR branch_city = 'Manhattan' 
									  OR branch_city = 'Yonkers' ),
		assets		MONEY,
	CONSTRAINT branchPK PRIMARY KEY (branch_name)

);

CREATE TABLE customer (
		cust_ID		VARCHAR(40),
		customer_name	VARCHAR(40) NOT NULL,
		customer_street	VARCHAR(40),
		customer_city	VARCHAR(40),
	CONSTRAINT customerPK PRIMARY KEY (cust_ID)

);

CREATE TABLE loan (
		loan_number	VARCHAR(40),
		branch_name	VARCHAR(40),
		amount		MONEY DEFAULT '$0.00',
	CONSTRAINT loanPK PRIMARY KEY (loan_number)
		
);

CREATE TABLE borrower (
		cust_ID		VARCHAR(40),
		loan_number	VARCHAR(40),
	CONSTRAINT borrowerPK PRIMARY KEY (cust_ID, loan_number),
	CONSTRAINT borrowerFK FOREIGN KEY (cust_ID) REFERENCES customer (cust_ID)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT borrowerFK_2 FOREIGN KEY (loan_number) REFERENCES loan (loan_number)
		ON DELETE CASCADE
		ON UPDATE CASCADE


);

CREATE TABLE account (
		account_number	VARCHAR(40),
		branch_name	VARCHAR(40),
		balance		MONEY,
	CONSTRAINT accountPK PRIMARY KEY (account_number)

);

CREATE TABLE depositor (
		cust_ID		VARCHAR(40),
		account_number	VARCHAR(40),
	CONSTRAINT depositorPK PRIMARY KEY (cust_ID, account_number),
	CONSTRAINT depositorFK FOREIGN KEY (cust_ID) REFERENCES customer (cust_ID)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT depositorFK_2 FOREIGN KEY (account_number) REFERENCES account (account_number)
		ON DELETE CASCADE
		ON UPDATE CASCADE

);

--------------------------------------------------------------
--------------------------------------------------------------
--------------------------------------------------------------
--Question 2:
--Write a query to find the cust_ID and customer name of each customer at the bank who only has
--a loan at the bank, and no account.

SELECT cust_ID, customer_name
FROM customer JOIN borrower USING (cust_id)
WHERE cust_ID NOT IN 	(SELECT cust_ID
			FROM customer NATURAL JOIN depositor);
--try this with natural joins later, mostly short form, rewrite later to have a long-form just in case

--Question 3:
--Write a query to find the cust_ID and customer name of each customer who lives on the same
--street and in the same city as customer ‘12345’. Include customer ‘12345’ in your query results.

SELECT cust_ID, customer_name
FROM customer AS C
WHERE C.customer_street IN (
	SELECT Cu.customer_street
	FROM customer AS Cu
	WHERE Cu.cust_ID = '12345'
)
AND
C.customer_city IN (
	SELECT Cu.customer_city
	FROM customer AS Cu
	WHERE Cu.cust_ID = '12345'
);

--this is currently in long-form, try for a short-form to submit instead, this should be a backup


--Question 4:
--Write a query to find the name of each branch that has at least one customer who has an account
--in the bank and who lives in “Harrison”.


SELECT branch_name
FROM branch NATURAL JOIN account
WHERE account_number IN (
	SELECT account_number
	FROM customer NATURAL JOIN depositor
	WHERE customer.customer_city = 'Harrison');
	



Question 5:
--Write a query to find each customer who has an account at every branch located in “Brooklyn”.
SELECT cust_id
FROM (SELECT cust_id, COUNT(cust_id) AS num_brook_accounts
	FROM branch AS B NATURAL JOIN account NATURAL JOIN depositor
	WHERE B.branch_city = 'Brooklyn'
	GROUP BY cust_id) AS foo
JOIN 
	(SELECT COUNT(DISTINCT branch_name) AS num_branch
	FROM branch AS C
	WHERE C.branch_city = 'Brooklyn') AS bar
ON foo.num_brook_accounts = bar.num_branch;

Question 6:
SELECT student.id
FROM student NATURAL LEFT OUTER JOIN takes
WHERE takes.id IS NULL;


