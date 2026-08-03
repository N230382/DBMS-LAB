-- PART-A
use taxation_database;
show tables;
DROP TABLE info;
DROP TABLE data1;
show tables;

-- PART-B
SELECT * FROM  taxpayer t INNER JOIN income_record i ON t.taxpayer_id=i.taxpayer_id;
SELECT 
    t.taxpayer_id,
    t.full_name,
    ic.category_name AS income_category
FROM Taxpayer t
JOIN Income_Record ir
    ON t.taxpayer_id = ir.taxpayer_id
JOIN Income_Category ic
    ON ir.category_id = ic.category_id;
    

SELECT * FROM income_record ir JOIN financial_year fr ON ir.year_id=fr.year_id;
  
SELECT 
    full_name,
    annual_income,
    amount
FROM taxpayer t
INNER JOIN income_record ir ON t.taxpayer_id=ir.taxpayer_id;

SELECT 
	full_name,
    income_source,
    category_name,
    year_labe
FROM taxpayer t
JOIN Income_Record ir
    ON t.taxpayer_id = ir.taxpayer_id
JOIN Income_Category ic
    ON ir.category_id = ic.category_id
JOIN financial_year fr
    ON ir.year_id= fr.year_id;
    
    

-- LEVEL-2
SELECT
    full_name,
    income_source 
FROM Taxpayer t
JOIN Income_Record ir
    ON t.taxpayer_id = ir.taxpayer_id
JOIN Income_Category ic
    ON ir.category_id = ic.category_id
WHERE ic.category_name = 'Business';
select * from income_category;

SELECT 
	full_name,
    income_source
FROM taxpayer t
JOIN income_record ir 
	ON t.taxpayer_id=ir.taxpayer_id
JOIN income_category ic 
	ON ir.category_id=ic.category_id 
where ic.category_name='Agricultural Income';


SELECT 
	t.taxpayer_id,
	t.full_name,
    fr.start_date,
    fr.end_date
FROM taxpayer t 
JOIN income_record ir 
	ON t.taxpayer_id=ir.taxpayer_id
JOIN financial_year fr
	ON ir.year_id=fr.year_id;
    
SELECT 
	t.taxpayer_id,
	t.full_name,
    ic.description
FROM taxpayer t 
JOIN income_record ir 
	ON t.taxpayer_id=ir.taxpayer_id
JOIN income_category ic
	ON ir.category_id=ic.category_id;
    
    
SELECT 
	full_name, pan_number, occupation, income_source, category_name , amount,
    year_labe, start_date, end_date
FROM taxpayer t
INNER JOIN income_record ir
	ON t.taxpayer_id=ir.taxpayer_id
INNER JOIN income_category ic
	ON ir.category_id=ic.category_id
INNER JOIN financial_year fr
	ON ir.year_id=fr.year_id;
    
    

-- LEVEL-3
SELECT t.*
FROM taxpayer t 
LEFT OUTER JOIN income_record ir ON t.taxpayer_id=ir.taxpayer_id;

SELECT ir.*
FROM income_record ir
RIGHT OUTER JOIN income_category ic ON ir.category_id=ic.category_id;

SELECT
    t.*,
    ir.*
FROM Taxpayer t
LEFT JOIN Income_Record ir
ON t.taxpayer_id = ir.taxpayer_id
	UNION
SELECT
    t.*,
    ir.*
FROM Taxpayer t
RIGHT JOIN Income_Record ir
ON t.taxpayer_id = ir.taxpayer_id;

SELECT t.*,fr.*
FROM taxpayer t
CROSS JOIN financial_year fr;

UPDATE Taxpayer
SET occupation = 'Software Engineer'
WHERE taxpayer_id = 105;
SELECT taxpayer_id, full_name, occupation
FROM Taxpayer;
SELECT
    t1.full_name AS Taxpayer1,
    t2.full_name AS Taxpayer2,
    t1.occupation
FROM Taxpayer t1, Taxpayer t2
WHERE t1.occupation = t2.occupation
AND t1.taxpayer_id < t2.taxpayer_id;


-- ADDITIONAL
SELECT 
	full_name, pan_number, income_source, category_name, year_labe
FROM taxpayer t
INNER JOIN income_record ir 
	ON t.taxpayer_id=ir.taxpayer_id
INNER JOIN income_category ic
	ON ir.category_id=ic.category_id
INNER JOIN financial_year fr
	ON ir.year_id=fr.year_id;
    
SELECT t.full_name,t.pan_number, ic.category_name, ic.description
FROM taxpayer t
JOIN income_record ir 
	ON t.taxpayer_id=ir.taxpayer_id
JOIN income_category ic
	ON ir.category_id=ic.category_id;

SELECT 
	ir.taxpayer_id,
    ir.income_source,
    fr.year_labe
FROM income_record ir
JOIN financial_year fr ;

update financial_year
SET year_labe='2025-2026' WHERE year_id=2;
SELECT 
	t.taxpayer_id,
	t.full_name,
	ir.income_source,
    fr.year_labe    
FROM taxpayer t
JOIN income_record ir 
	ON t.taxpayer_id=ir.taxpayer_id
JOIN income_category ic
	ON ir.category_id=ic.category_id
JOIN financial_year fr
	ON ir.year_id=fr.year_id
WHERE fr.year_labe='2025-2026'
AND ic.category_name='Business';


SELECT 
	t.full_name,
    t.pan_number,
    ir.income_source,
    ir.amount,
    ic.category_name,
    ic.description,
    fr.year_labe,
    fr.start_date,
    fr.end_date
FROM taxpayer t
JOIN income_record ir 
	ON t.taxpayer_id=ir.taxpayer_id
JOIN income_category ic
	ON ir.category_id=ic.category_id
JOIN financial_year fr
	ON ir.year_id=fr.year_id;
    
SELECT * FROM financial_year;




    
    
