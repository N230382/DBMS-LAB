use taxation_database;
show tables;
DROP TABLE info;
DROP TABLE data1;
show tables;
SELECT * FROM income_record;

INSERT INTO income_record 
(income_id,taxpayer_id,income_source,amount, received_date,remarks,category_id,year_id)
VALUES
(1007,101,"villa",850000.00,"2025-03-31","",3,5),
(1008,102,"BIG house",1200000.00,"2025-03-31","",3,5),
(1009,103,"Naidu Enterprises",1800000.00,"2024-03-31","",4,4),
(1010,104,"Akshara School",620000.00,"2024-03-31","",4,4),
(1011,105,"Web Design Projects",750000.00,"2023-03-31","",5,3),
(1012,106,"Professional Consulting",1500000.00,"2023-03-31","",5,3);

-- PART-B 
-- LEVEL-1(UNDERSTANDING)
SELECT COUNT(taxpayer_id) FROM income_record;
SELECT COUNT(*) FROM taxpayer;

SELECT SUM(amount) FROM income_record;

SELECT AVG(amount) FROM income_record;

SELECT MAX(amount) FROM income_record;

SELECT MIN(amount) FROM income_record;

-- LEVEL-2(APPLICATION)
SELECT category_id, COUNT(category_id) as no_of_records
FROM income_record
GROUP BY category_id;

SELECT category_id, SUM(amount) as total_income
FROM income_record
GROUP BY category_id;

SELECT category_id, AVG(amount) as avg_income
FROM income_record
GROUP BY category_id;

SELECT category_id, MAX(amount) as highest_income
FROM income_record
GROUP BY category_id;

SELECT category_id, MIN(amount) as lowest_income
FROM income_record
GROUP BY category_id;

SELECT year_id, SUM(amount) as total_income
FROM income_record
GROUP BY year_id;

SELECT year_id, COUNT(income_id) as no_of_income
FROM income_record
GROUP BY year_id;

SELECT year_id,category_id, SUM(amount) as total_income
FROM income_record
GROUP BY year_id,category_id;


-- LEVEL-3 (MEDIUM TO ADV)
-- TASK-1 Display only those income categories whose total income is greater than ₹10,00,000
SELECT category_id, SUM(amount) as total_income
FROM income_record
GROUP BY category_id
HAVING  SUM(amount)>'1000000.00';

-- TASK-2 Display income categories whose average income is greater than ₹5,00,000
SELECT category_id, AVG(amount) as total_income
FROM income_record
GROUP BY category_id
HAVING  AVG(amount)>'500000.00';

 -- TASK-3 Display financial years having more than three income records. Hint: Use COUNT() with HAVING.
SELECT year_id, COUNT(income_id) as records_greaterthan3
FROM income_record
GROUP BY year_id
HAVING  COUNT(amount)>2;

-- TASK-4 Income categories in descending order of total income 
SELECT category_id, SUM(amount) AS total_income
FROM income_record
GROUP BY category_id
ORDER BY total_income DESC;


-- TASK-5 Categories whose total income is greater than ₹10,00,000
SELECT category_id, SUM(amount) AS total_income
FROM income_record
GROUP BY category_id
HAVING SUM(amount) > 1000000
ORDER BY total_income DESC;

--  TASK-6 Display the total income and average income for each income category.
SELECT category_id,
       SUM(amount) AS total_income,
       AVG(amount) AS average_income
FROM income_record
GROUP BY category_id;

-- TASK-7 Category and financial year combination having the highest total income
SELECT category_id, year_id, SUM(amount) AS total_income
FROM income_record
GROUP BY category_id, year_id
ORDER BY total_income DESC
LIMIT 1;

-- TASK-8 Number of taxpayers who have income records in each financial year
SELECT ir.year_id, COUNT(DISTINCT t.taxpayer_id) AS no_of_taxpayers
FROM taxpayer t
JOIN income_record ir
ON t.taxpayer_id = ir.taxpayer_id
GROUP BY ir.year_id;

-- REAL WORLD ANALYSIS
-- Task 1: Identify the income category that generates the highest total income.
SELECT c.category_name,SUM(i.amount) AS total_income
FROM income_record AS i
JOIN income_category AS c
ON i.category_id = c.category_id
GROUP BY i.category_id
ORDER BY total_income DESC
LIMIT 1;

-- Task 2: Identify the financial year having the highest total recorded income.
SELECT f.year_labe,SUM(i.amount) AS total_income
FROM income_record AS i
JOIN financial_year AS f
ON i.year_id = f.year_id
GROUP BY i.year_id
ORDER BY total_income DESC
LIMIT 1;

-- Task 3: Identify the income category having the highest average income.
SELECT c.category_name,(AVG(i.amount)) AS highest_avg_income
FROM income_record AS i
JOIN income_category AS c
ON i.category_id = c.category_id
GROUP BY i.category_id
ORDER BY highest_avg_income DESC
LIMIT 1;

-- Task 4: Display income categories having more than two income records
SELECT c.category_name, COUNT(i.category_id) AS records_count
FROM income_record AS i
JOIN income_category AS c
ON i.category_id = c.category_id
GROUP BY i.category_id 
HAVING records_count > 2;

-- Task 5: Display financial years having total income greater than ₹10,00,000.
SELECT f.year_labe, SUM(i.amount) AS total_income
FROM income_record AS i
JOIN financial_year AS f
ON i.year_id = f.year_id
GROUP BY i.year_id
HAVING total_income > 1000000;

-- Task 6: Generate a summary report containing Income Category, Number of Records, Total Income, Average Income, Highest Income, and Lowest Income.
SELECT category_id,
       COUNT(income_id) AS number_of_records,
       SUM(amount) AS total_income,
       AVG(amount) AS average_income,
       MAX(amount) AS highest_income,
       MIN(amount) AS lowest_income
FROM income_record
GROUP BY category_id;