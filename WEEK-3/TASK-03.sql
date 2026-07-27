use taxation_database;
show tables;

-- PART-A
describe taxpayer;
SHOW COLUMNS FROM taxpayer;
select * from taxpayer;

-- PART-B
-- LEVEL-1
SELECT UPPER(full_name) FROM taxpayer;
SELECT LOWER(occupation) FROM taxpayer;
SELECT LENGTH(full_name) FROM taxpayer;
SELECT LEFT(taxpayer_id,4) FROM taxpayer;
SELECT CONCAT(full_name,' - ',occupation) FROM taxpayer;

-- LEVEL-2
SELECT REPLACE(category_name,'Income','Inc') FROM income_category;
SELECT TRIM(full_name) FROM taxpayer;
SELECT LEFT(full_name,locate(' ',full_name)-1)FROM taxpayer;

-- LEVEL-3
SELECT CONCAT('taxpayer :',full_name) as line1, concat('occupation :',occupation) as line2 FROM taxpayer;
SELECT full_name FROM taxpayer WHERE LEFT(pan_number,2)='AB';

-- PART-C
-- LEVEL-1
SELECT ROUND(annual_income,1)FROM taxpayer;
SELECT ABS(annual_income-500000) FROM taxpayer;
SELECT SQRT(annual_income) FROM taxpayer;

-- LEVEL-2
SELECT MOD(annual_income, 1000) AS remainder FROM taxpayer;
SELECT ROUND(annual_income,2) FROM taxpayer;
SELECT ceiling(annual_income) FROM taxpayer;
SELECT FLOOR(annual_income) FROM taxpayer;

-- LEVEL-3
SELECT FLOOR(RAND() * 100) + 1;
SELECT SQRT(annual_income) FROM taxpayer;
SELECT annual_income,
       annual_income * 1.10 AS incremented_income
FROM taxpayer;

-- PART-D
-- LEVEL-1
SELECT CURDATE();
SELECT NOW();
SELECT YEAR(start_date) FROM financial_year;
SELECT MONTH(start_date) FROM financial_year;
SELECT DAY(start_date) FROM financial_year;

-- LEVEL-2
SELECT DATE_ADD(start_date, INTERVAL 1 YEAR) AS financial_year_end_date FROM financial_year;
SELECT DATE_ADD(start_date, INTERVAL 30 DAY) AS start_date_after_30_days FROM financial_year;
SELECT DATE_SUB(start_date, INTERVAL 7 DAY) AS start_date_before_7_days FROM financial_year;

-- LEVEL-3
SELECT DATEDIFF(CURDATE(), start_date) AS days_difference FROM financial_year;
SELECT * FROM financial_year WHERE YEAR(start_date) = YEAR(CURDATE());

-- PART-E
-- LEVEL-1
SELECT CONVERT(annual_income, SIGNED) AS annual_income_integer FROM taxpayer;
SELECT CONVERT(taxpayer_id, CHAR) AS taxpayer_id_char FROM taxpayer;

-- LEVEL-2
SELECT CAST(start_date AS DATETIME) AS financial_year_datetime FROM financial_year;
SELECT CAST(annual_income AS DECIMAL(10,4)) AS annual_income_decimal FROM taxpayer;

-- LEVEL-3
SELECT CAST(annual_income AS CHAR) AS annual_income_string FROM taxpayer;
SELECT annual_income,
       CAST(annual_income AS DECIMAL(10,2)) * 0.10 AS tax
FROM taxpayer;






