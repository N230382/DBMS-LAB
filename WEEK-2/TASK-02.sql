use taxation_database;
ALTER TABLE income_record
	DROP COLUMN category_name, 
	DROP COLUMN financial_year;
SELECT * FROM income_record;
ALTER TABLE income_record
	ADD category_id INT,
    ADD year_id INT;
ALTER TABLE income_record
	ADD CONSTRAINT foreign_taxpayer
    FOREIGN KEY (taxpayer_id)
    REFERENCES taxpayer(taxpayer_id);
ALTER TABLE income_record
	ADD CONSTRAINT foreign_category
    FOREIGN KEY (category_id)
    REFERENCES income_category(category_id);
ALTER TABLE income_record
	ADD CONSTRAINT foreign_year
    FOREIGN KEY (year_id)
    REFERENCES financial_year(year_id);
SELECT * FROM income_record;
UPDATE income_record
	SET category_id = 1
    WHERE income_id= 1001;
UPDATE income_record
	SET category_id = 2
    WHERE income_id = 1002;
UPDATE income_record
	SET category_id = 3
    WHERE income_id = 1003;
UPDATE income_record
	SET category_id = 4
    WHERE income_id = 1004;
UPDATE income_record
	SET category_id = 5
    WHERE income_id = 1005;
UPDATE income_record
	SET category_id = 6
    WHERE income_id = 1006;

UPDATE income_record
	SET year_id = 01
    WHERE income_id=1001;
UPDATE income_record
	SET year_id = 02
    WHERE income_id=1002;
UPDATE income_record
	SET year_id = 03
    WHERE income_id=1003;
UPDATE income_record
	SET year_id = 04
    WHERE income_id=1004;
UPDATE income_record
	SET year_id = 05
    WHERE income_id=1005;
UPDATE income_record
	SET year_id = 06
    WHERE income_id=1006;

-- task-1(part-B)
INSERT INTO income_record(income_id,taxpayer_id,income_source,amount, received_date,category_id,year_id) 
	VALUES(1007,999,'Influencer','50000.00','2026-07-20',2,6);
    -- Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails 
    -- (`taxation_database`.`income_record`, CONSTRAINT `foreign_taxpayer` FOREIGN KEY (`taxpayer_id`) REFERENCES `taxpayer` (`taxpayer_id`))
    
-- task-2(part-B)
INSERT INTO income_record(income_id,taxpayer_id,income_source,amount, received_date,category_id,year_id) 
	VALUES(1007,999,'Influencer','50000.00','2026-07-20',20,6);
	-- Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails 
    -- (`taxation_database`.`income_record`, CONSTRAINT `foreign_taxpayer` FOREIGN KEY (`taxpayer_id`) REFERENCES `taxpayer` (`taxpayer_id`))
    
-- task-3(part-B)
INSERT INTO income_record(income_id,taxpayer_id,income_source,amount, received_date,category_id,year_id) 
	VALUES(1007,999,'Influencer','50000.00','2026-07-20',1,15);
    -- Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails 
    -- (`taxation_database`.`income_record`, CONSTRAINT `foreign_taxpayer` FOREIGN KEY (`taxpayer_id`) REFERENCES `taxpayer` (`taxpayer_id`))
    
-- task-4(part-B)
INSERT INTO income_record(income_id,taxpayer_id,income_source,amount, received_date,category_id,year_id) 
	VALUES(1007,101,'Influencer','50000.00','2026-07-20',20,6);
    -- Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails 
    -- (`taxation_database`.`income_record`, CONSTRAINT `foreign_taxpayer` FOREIGN KEY (`taxpayer_id`) REFERENCES `taxpayer` (`taxpayer_id`))
    
-- task-5(part-B)
DELETE from income_category WHERE category_id=2;
 -- Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails 
 -- (`taxation_database`.`income_record`, CONSTRAINT `foreign_category` FOREIGN KEY (`category_id`) REFERENCES `income_category` (`category_id`))



-- PART-C
SELECT DISTINCT occupation FROM taxpayer;
SELECT DISTINCT * FROM income_category;
SELECT DISTINCT * FROM financial_year;
SELECT DISTINCT income_source FROM income_record;


-- PART-D
SELECT full_name
FROM Taxpayer
WHERE taxpayer_id IN (
    SELECT taxpayer_id
    FROM Income_Record
    WHERE category_id = 2
)

UNION

SELECT full_name
FROM Taxpayer
WHERE taxpayer_id IN (
    SELECT taxpayer_id
    FROM Income_Record
    WHERE category_id = 3
);
    
SELECT income_source
	FROM Income_Record
	WHERE year_id = 2

	UNION
	SELECT income_source
	FROM Income_Record
	WHERE year_id = 3;
    
SELECT full_name
FROM Taxpayer
WHERE occupation = 'Teacher'

UNION

SELECT full_name
FROM Taxpayer
WHERE occupation = 'Software Engineer';


-- Part E – INTERSECT
SELECT full_name
FROM Taxpayer
WHERE taxpayer_id IN (
    SELECT taxpayer_id
    FROM Income_Record
    WHERE category_id = 2
)
INTERSECT
SELECT full_name
FROM Taxpayer
WHERE taxpayer_id IN (
    SELECT taxpayer_id
    FROM Income_Record
    WHERE category_id = 3
);

SELECT income_source
	FROM Income_Record
	WHERE year_id = 1
INTERSECT
SELECT income_source
	FROM Income_Record
	WHERE year_id = 2;
 


-- PART-F (MINUS)
SELECT full_name
FROM Taxpayer
WHERE taxpayer_id IN (
    SELECT taxpayer_id
    FROM Income_Record
    WHERE category_id = 2
)

EXCEPT

SELECT full_name
FROM Taxpayer
WHERE taxpayer_id IN (
    SELECT taxpayer_id
    FROM Income_Record
    WHERE category_id = 3
);

SELECT income_source
FROM Income_Record
WHERE year_id = 2

EXCEPT

SELECT income_source
FROM Income_Record
WHERE year_id = 3;


-- PART-G 
-- TASK-01
SELECT full_name
FROM Taxpayer
WHERE taxpayer_id IN (
    SELECT taxpayer_id
    FROM Income_Record
);

-- TASK-02
SELECT full_name
FROM Taxpayer
WHERE occupation IN (
    SELECT occupation
    FROM Taxpayer
    WHERE taxpayer_id IN (
        SELECT taxpayer_id
        FROM Income_Record
        WHERE category_id = 2
    )
);
-- PART-H
-- TASK-01
SELECT full_name
FROM Taxpayer
WHERE taxpayer_id NOT IN (
    SELECT taxpayer_id
    FROM Income_Record
);

-- TASK-2
SELECT DISTINCT occupation
FROM Taxpayer
WHERE taxpayer_id NOT IN (
    SELECT taxpayer_id
    FROM Income_Record
);

SELECT taxpayer_id
FROM Taxpayer;
SELECT DISTINCT taxpayer_id
FROM Income_Record;

-- PART-I 
-- TASK-01
SELECT full_name
FROM Taxpayer
WHERE EXISTS (
    SELECT *
    FROM Income_Record
    WHERE Taxpayer.taxpayer_id = Income_Record.taxpayer_id
);

-- TASK-02
SELECT year_labe
FROM Financial_Year
WHERE EXISTS (
    SELECT *
    FROM Income_Record
    WHERE Financial_Year.year_id = Income_Record.year_id
);

-- PART-J
-- TASK-01
SELECT full_name
FROM Taxpayer
WHERE NOT EXISTS (
    SELECT *
    FROM Income_Record
    WHERE Taxpayer.taxpayer_id = Income_Record.taxpayer_id
);
-- TASK-02
SELECT category_name
FROM Income_Category
WHERE NOT EXISTS (
    SELECT *
    FROM Income_Record
    WHERE Income_Category.category_id = Income_Record.category_id
);


-- PART-k 
-- TASK-1
SELECT full_name
FROM Taxpayer
WHERE annual_income > ANY (
    SELECT annual_income
    FROM Taxpayer
    WHERE occupation = 'Teacher'
);

-- TASK-2
SELECT full_name
FROM Taxpayer
WHERE annual_income > ANY (
    SELECT amount
    FROM Income_Record
    WHERE category_id = 2
);


-- PART-L 
-- TASK-01
SELECT full_name
FROM Taxpayer
WHERE annual_income > ALL (
    SELECT annual_income
    FROM Taxpayer
    WHERE occupation = 'Teacher'
);
-- TASK-02
SELECT full_name
FROM Taxpayer
WHERE annual_income > ALL (
    SELECT amount
    FROM Income_Record
    WHERE category_id = 2
);


-- PART-M
SELECT *
FROM taxpayer
ORDER BY full_name ASC;
	-- ASC ascending order (A → Z)
    
SELECT * FROM taxpayer WHERE annual_income>'800000.00';

SELECT * FROM taxpayer WHERE occupation='Software Engineer';

SELECT * FROM Income_Record WHERE income_id IN (1003,1004,1005);

SELECT * FROM income_record WHERE amount BETWEEN 500000 AND 1000000 ;

SELECT * FROM taxpayer WHERE full_name LIKE 'A%';

ALTER TABLE taxpayer ADD city varchar(20);
UPDATE taxpayer SET city='Vizag' WHERE taxpayer_id=101;
UPDATE Taxpayer SET city = 'Rajamundry' WHERE taxpayer_id IN (102,105);
UPDATE Taxpayer SET city = 'Tuni' WHERE taxpayer_id IN (103, 104,106);
SELECT * FROM taxpayer;

SELECT * FROM taxpayer WHERE is_active = 1;

SELECT COUNT(*) AS total_taxpayers FROM taxpayer;

SELECT MAX(amount) AS highest_income FROM income_record;


-- PART-N
SELECT t.full_name, i.amount 
FROM taxpayer t
JOIN income_Record i 
ON t.taxpayer_id = i.taxpayer_id
WHERE i.amount = (
    SELECT MAX(amount) 
    FROM income_record
);

SELECT c.category_name, COUNT(*) AS total_records
FROM Income_Record i
JOIN Income_Category c ON i.category_id = c.category_id
GROUP BY c.category_name
ORDER BY total_records DESC
LIMIT 1;

SELECT occupation, COUNT(*) AS total_taxpayers FROM Taxpayer GROUP BY occupation;

SELECT COUNT(*) AS active_taxpayers FROM Taxpayer WHERE is_active = 1;

SELECT year_id, COUNT(*) AS total_records
FROM Income_Record
GROUP BY year_id
ORDER BY COUNT(*) DESC
LIMIT 1;

SELECT * FROM income_record;

