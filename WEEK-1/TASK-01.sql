CREATE DATABASE Taxation_database;
USE Taxation_database;
CREATE TABLE Taxpayer(
	taxpayer_id INT Primary Key,
    pan_number VARCHAR(10) Unique,
    full_name VARCHAR(100) Not Null,
    date_of_birth DATE Not NULL,
    occupation VARCHAR(50) Not Null,
    annual_income DECIMAL(12,2) Not Null,
    email VARCHAR(100) Unique,
    is_active BOOLEAN
);
INSERT INTO Taxpayer (taxpayer_id ,pan_number , full_name , date_of_birth,
		occupation, annual_income, email , is_active) VALUES (101 , 'ABCDE1234F', 'Ravi Kumar' ,
        '1995-06-15' , 'Software Engineer' ,'850000.00' , 'ravi.kumarexample.com' ,TRUE);
SELECT * FROM Taxpayer;
INSERT INTO Taxpayer (taxpayer_id ,pan_number , full_name , date_of_birth,
		occupation, annual_income, email , is_active) VALUES (102 , 'BCDEF2345G', 'Priya Sharma' ,
        '1992-11-22' , 'Doctor' ,'120000.00' , 'priya.sharma@example.com' ,TRUE),
        (103, 'CDEFG3456H', 'Arjun Reddy', '1988-03-10', 'Business Owner','1800000.00','arjun.reddy@example.com',TRUE),
        (104, 'DEFGH4567J','Sneha Patel', '1998-08-05', 'Teacher','620000.00', 'sneha.patel@example.com',TRUE),
        (105, 'EFGHJ5678K', 'Kiran Rao','1990-01-18','Freelancer','750000.00','kiran.rao@example.com', TRUE),
        (106, 'FGHJK6789L','Meera Singh', '1985-12-30','Consultant','150000.00','meera.singh@example.com',TRUE);
SELECT * FROM Taxpayer;
INSERT INTO Taxpayer(taxpayer_id ,pan_number , full_name , date_of_birth,
		occupation, annual_income, email , is_active) VALUES (107 , 'XYZLM2345T', 'Vishnu Sharma' ,
        '1999-07-13' , 'Professor' ,'250000.00' , 'vishnu.sharma@example.com' ,FALSE);
UPDATE Taxpayer SET annual_income = '950000.00' WHERE taxpayer_id= 101;
UPDATE Taxpayer SET occupation='Software Consultant' WHERE taxpayer_id= 105;
UPDATE Taxpayer SET is_active=TRUE WHERE taxpayer_id= 106;
DELETE FROM Taxpayer WHERE taxpayer_id=107;
ALTER TABLE Taxpayer ADD rental_income VARCHAR(15);
SELECT * FROM Taxpayer;



CREATE TABLE Income_Category(category_id INT Primary Key, category_name VARCHAR(50) Not Null, 
	description VARCHAR(200) Not Null ,taxable boolean Not Null );
INSERT INTO Income_Category (category_id, category_name, description, taxable) VALUES 
	(1, 'Salary', 'Income received from employment', TRUE),
    (2, 'Business', 'Income earned from business activities',TRUE),
    (3, 'House Property', 'Income received from property or rent',TRUE),
    (4, 'Capital Gains' ,'Income from transfer of eligible assets' ,TRUE),
    (5, 'Other Sources', 'Income such as bank interest',TRUE),
    (6 ,'Agricultural Income', 'Income from eligible agricultural activities',FALSE);
SELECT * FROM Income_Category;
rollback;


CREATE TABLE Financial_Year(year_id INT Primary Key,year_labe VARCHAR(9) Not Null, start_date DATE Not Null, end_date DATE Not Null,
		filling_deadline DATE , is_current BOOLEAN Not Null);
INSERT INTO Financial_Year(year_id, year_labe, start_date, end_date , filling_deadline, is_current) VALUES
	(1, '2020-2021', '2020-04-01', '2021-03-31', '2021-07-31' ,FALSE),
    (2, '2021-2022', '2021-04-01', '2022-03-31', '2022-07-31' ,FALSE ),
    (3, '2022-2023','2022-04-01', '2023-03-31', '2023-07-31', FALSE),
    (4 ,'2023-2024', '2023-04-01', '2024-03-31', '2024-07-31', FALSE),
    (5, '2024-2025', '2024-04-01', '2025-03-31', '2025-07-31', FALSE),
    (6,'2025-2026' ,'2025-04-01','2026-03-31','2026-07-31',TRUE);
SELECT * FROM Financial_Year;


CREATE TABLE Income_Record (
	income_id INT Primary Key,
	taxpayer_id INT Not Null,
	income_source VARCHAR(100) Not Null,
	category_name VARCHAR(50) Not Null, 
	amount DECIMAL(12,2) Not Null,
	received_date DATE Not Null,
	financial_year VARCHAR(9) Not Null
);
INSERT INTO Income_Record (income_id,taxpayer_id ,income_source ,category_name ,amount ,received_date,financial_year) VALUES
	(1001, 101, 'TechNova Solutions','Salary', '850000.00','2026-03-31','2025-2026'),
    (1002, 102, 'City Car Hospital', 'Salary', '1200000.00' ,'2026-03-31' ,'2025-2026'),
    (1003, 103, 'Reddy Enterprises','Business', '1800000.00','2026-03-31','2025-2026'),
    (1004, 104, 'Sunrise School','Salary', '620000.00','2026-03-31','2025-2026'),
    (1005,105, 'Web Design Projects','Business','7500000.00','2026-03-31','2025-2026'),
    (1006,106, 'Professional Consulting', 'Business', '1500000.00','2026-03-31','2025-2026');
    
SELECT * FROM income_record;


-- PART D TASK
-- TASK-1
INSERT INTO Taxpayer() 
VALUES
	(107,'GHJK7890M','Vikram Dutt','1995-05-01','Architech','150000.00','vikram.dutt@example.com',1,'','','Hyderabad');

-- TASK-2
UPDATE Taxpayer SET annual_income='950000.00' WHERE taxpayer_id=101;

-- TASK-3
UPDATE Taxpayer SET occupation='Software Consultant' WHERE taxpayer_id=105;

-- TASK-4
UPDATE Taxpayer SET is_active=0 WHERE taxpayer_id=106;
SELECT * FROM taxpayer;

-- TASK-5
DELETE FROM Taxpayer WHERE taxpayer_id=107;

-- TASK-6
ALTER TABLE income_category ADD rental_income INT;
SELECT * FROM income_category;


-- PART E TASK
-- TASK-1
ALTER TABLE Taxpayer ADD phone_number VARCHAR(10);

-- TASK-2
ALTER TABLE income_record ADD remarks VARCHAR(50);

-- TASK-3
ALTER TABLE taxpayer MODIFY COLUMN occupation VARCHAR(100);

-- TASK-4
CREATE TABLE Tax_Office(office_id INT Primary Key, office_name VARCHAR(20) Not Null, city VARCHAR(20) Not Null);
INSERT INTO Tax_Office() VALUES (1,'DELL','Hyderabad');
INSERT INTO Tax_Office() VALUES (2, 'HP', 'Mumbai');
SELECT * FROM Tax_Office;
			
-- TASK-5
TRUNCATE TABLE Tax_Office;
SELECT * FROM Tax_Office;

-- TASK-6
DROP TABLE Tax_Office;


-- PART-F 
INSERT INTO taxpayer() VALUES (101,'ABCDE2304F', 'Vikram Dutt' ,
        '1995-06-1' , 'Architech' ,'150000.00' , 'vikram.dutt@example.com' ,TRUE);
        -- column count doesn't match value
SELECT * FROM taxpayer;
        
-- exp-2
INSERT INTO taxpayer() VALUES (107,'ABCDE1234F', 'Vikram Dutt' ,
        '1995-06-1' , 'Architech' ,'150000.00' , 'vikram.dutt@example.com' ,TRUE);
        -- column count doesn't match value(it is not unique)

-- exp-3
INSERT INTO taxpayer() VALUES (107,'ABCDE145f', ' ' ,
        '1995-06-11' , 'Architech-Assit' ,'150000.00' , 'vikram@example.com' ,TRUE);
        -- not null constraint prevents the insertion
        
        
	
USE taxation_database;
SHOW TABLES;






			