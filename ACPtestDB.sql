CREATE TABLE customers (
	customer_ID VARCHAR(7),
	customer_name VARCHAR(15),
	business_name VARCHAR(20),
	customer_notes VARCHAR(300),
	address VARCHAR(7)
	);
					   
CREATE TABLE customer_contact_numbers (
	customer_ID VARCHAR(7),
	phone_number VARCHAR(15),
	phone_type VARCHAR(7)
	
	);
	
CREATE TABLE customer_email (
	customer_ID VARCHAR(7),
	email VARCHAR(30),
	email_type VARCHAR(7)
	
	);