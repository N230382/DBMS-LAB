-- PART-A
-- LEVEL-1
CREATE VIEW MAX_amount AS 
SELECT * FROM income_record WHERE amount IN (select MAX(amount) FROM income_record);
SELECT * FROM MAX_amount;

CREATE VIEW lowest_amount AS
SELECT * FROM income_record WHERE amount=( SELECT MIN(amount) FROM income_record);
SELECT * FROM lowest_amount;

SELECT AVG(amount) FROM income_record;
CREATE VIEW average_amount AS
SELECT * FROM income_record WHERE amount>( SELECT AVG(amount) FROM income_record);
SELECT * FROM average_amount;

CREATE VIEW high_amount AS
SELECT * FROM income_record WHERE amount = ( SELECT MAX(amount) FROM income_record);
SELECT * FROM high_amount;

CREATE VIEW business_occu AS 
SELECT * FROM taxpayer WHERE occupation='Business Owner';
SELECT * FROM business_occu;
SELECT * FROM taxpayer;

-- LEVEL-2
-- Task 1: Create a view displaying taxpayers who have at least one income record.
CREATE VIEW taxpayer_income AS 
SELECT * FROM taxpayer WHERE taxpayer_id= ANY ( SELECT taxpayer_id FROM income_record);
SELECT * FROM taxpayer_income;

-- Task 2: Create a view displaying taxpayers who have income in the Business category.
CREATE VIEW taxpay_withbusiness AS
SELECT *
FROM taxpayer
WHERE taxpayer_id IN (
    SELECT taxpayer_id
    FROM income_record
    WHERE category_id IN (
        SELECT category_id
        FROM income_category
        WHERE category_name = 'Business'
    )
);
SELECT * FROM taxpay_withbusiness;
SELECT * FROM income_category;

-- Task 3: Create a view displaying income records belonging to the financial year 2025-2026.
CREATE VIEW income_year AS
SELECT * FROM income_record where year_id IN (
	SELECT year_id FROM financial_year WHERE year_labe='2025-2026');
SELECT * FROM income_year;
SELECT * FROM financial_year;

-- Task 4: Create a view displaying income records whose amount is greater than the minimum Business income. 
CREATE VIEW minim_income_amount AS
SELECT * FROM income_record WHERE amount >(
	SELECT MIN(amount) FROM income_record WHERE category_id IN( 
		SELECT category_id FROM income_category WHERE category_name='Business')
	);
SELECT * FROM minim_income_amount;

-- Task 5: Create a view displaying income records whose amount is less than the maximum Salary income.
CREATE VIEW max_amount_salary AS
SELECT * FROM income_record WHERE amount <(
	SELECT MAX(amount) FROM income_record WHERE category_id IN( 
		SELECT category_id FROM income_category WHERE category_name='Salary')
	);
SELECT * FROM max_amount_salary;

-- Task 6: Create a view displaying taxpayers who have income records greater than the average income.
CREATE VIEW avg_income_amoun AS
SELECT taxpayer_id,full_name FROM taxpayer WHERE taxpayer_id IN(
	SELECT taxpayer_id FROM income_record WHERE amount >(
		SELECT AVG(amount) FROM income_record)
);
SELECT * FROM avg_income_amoun;

-- Task 7: Create a view displaying income categories that have at least one income record.
CREATE VIEW income_category_in_inr AS
SELECT taxpayer_id,full_name FROM taxpayer WHERE taxpayer_id IN(
	SELECT taxpayer_id FROM income_record WHERE category_id = ANY (
		SELECT category_id FROM income_category )
	);
SELECT * FROM income_category_in_inr;

-- Task 8: Create a view displaying taxpayers who have no income records in the Investment category. 
CREATE VIEW taxpay_no_investment AS
SELECT taxpayer_id, full_name
FROM taxpayer
WHERE taxpayer_id NOT IN (
    SELECT taxpayer_id
    FROM income_record
    WHERE category_id IN (
        SELECT category_id
        FROM income_category
        WHERE category_name = 'Investment'
    )
);
SELECT * FROM taxpay_no_investment;


-- LEVEL-3
-- Task 1: Create a view displaying the taxpayer having the highest recorded income.
CREATE VIEW highest_record_inc AS
SELECT taxpayer_id, full_name 
FROM taxpayer
WHERE taxpayer_id IN(
	SELECT taxpayer_id 
    FROM income_record 
    WHERE amount =(
		SELECT MAX(amount) 
        FROM income_record
	)
);
SELECT * FROM highest_record_inc;

-- Task 2: Create a view displaying all income records having an amount greater than the average Business income. 
CREATE VIEW inc_greater_business_avg AS
SELECT taxpayer_id,full_name  
FROM taxpayer 
WHERE taxpayer_id IN(
	SELECT taxpayer_id
	FROM income_record
	WHERE amount > (
		SELECT AVG(amount)
		FROM income_record
		WHERE category_id IN (
			SELECT category_id
			FROM income_category
			WHERE category_name = 'Business'
		)
	)
);
SELECT * FROM inc_greater_business_avg;

-- Task 2: Create a view displaying all income records having an amount greater than the average Business income. 
CREATE VIEW taxpay_greater_avg_total AS
SELECT taxpayer_id, full_name
FROM taxpayer
WHERE taxpayer_id IN (
    SELECT taxpayer_id
    FROM income_record
    GROUP BY taxpayer_id
    HAVING SUM(amount) > (
        SELECT AVG(total_income)
        FROM (
            SELECT taxpayer_id, SUM(amount) AS total_income
            FROM income_record
            GROUP BY taxpayer_id
        ) AS income_totals
    )
);
SELECT * FROM taxpay_greater_avg_total;

-- Task 4: Create a view displaying income records having an amount greater than at least one Investment income record. 
CREATE VIEW income_greater_investment AS
SELECT *
FROM income_record
WHERE amount > ANY (
    SELECT amount
    FROM income_record
    WHERE category_id IN (
        SELECT category_id
        FROM income_category
        WHERE category_name = 'Investment'
    )
);
SELECT * FROM income_greater_investment;

-- Task 5: Create a view displaying income records having an amount greater than every Investment income record. 
CREATE VIEW inc_greater_all_investment AS
SELECT *
FROM income_record
WHERE amount > ALL (
    SELECT amount
    FROM income_record
    WHERE category_id IN (
        SELECT category_id
        FROM income_category
        WHERE category_name = 'Investment'
    )
);
SELECT * FROM inc_greater_all_investment;

-- Task 6: Create a view displaying the income category that contains the highest income record.
CREATE VIEW category_highest_income AS
SELECT category_id, category_name
FROM income_category
WHERE category_id IN (
    SELECT category_id
    FROM income_record
    WHERE amount = (
        SELECT MAX(amount)
        FROM income_record
    )
);
SELECT * FROM category_highest_income;

-- Task 7: Financial year having the highest total income
CREATE VIEW highest_total_income_year AS
SELECT year_id, SUM(amount) AS total_income
FROM income_record
GROUP BY year_id
HAVING SUM(amount) >= ALL (
    SELECT SUM(amount)
    FROM income_record
    GROUP BY year_id
);
SELECT * FROM highest_total_income_year;


-- Task 8: Taxpayers whose total income is greater than the average total income
CREATE VIEW taxpayer_greater_avg_income AS
SELECT taxpayer_id, full_name
FROM taxpayer
WHERE taxpayer_id IN (
    SELECT taxpayer_id
    FROM income_record
    GROUP BY taxpayer_id
    HAVING SUM(amount) > (
        SELECT AVG(total_income)
        FROM (
            SELECT taxpayer_id, SUM(amount) AS total_income
            FROM income_record
            GROUP BY taxpayer_id
        ) AS income_totals
    )
);

SELECT * FROM taxpayer_greater_avg_income;


-- Real- world
-- Task 1 — Taxpayer who has the highest individual income
SELECT taxpayer_id, full_name
FROM taxpayer
WHERE taxpayer_id IN (
    SELECT taxpayer_id
    FROM income_record
    WHERE amount = (
        SELECT MAX(amount)
        FROM income_record
    )
);

-- Task 2 — Taxpayers whose income is above the overall average income
SELECT taxpayer_id, full_name
FROM taxpayer
WHERE taxpayer_id IN (
    SELECT taxpayer_id
    FROM income_record
    WHERE amount > (
        SELECT AVG(amount)
        FROM income_record
    )
);

-- Task 3 — Income category containing the highest income record
SELECT category_id, category_name
FROM income_category
WHERE category_id IN (
    SELECT category_id
    FROM income_record
    WHERE amount = (
        SELECT MAX(amount)
        FROM income_record
    )
);

-- Task 4 — Taxpayers who have Business income but no Investment income
SELECT taxpayer_id, full_name
FROM taxpayer
WHERE taxpayer_id IN (
    SELECT taxpayer_id
    FROM income_record
    WHERE category_id IN (
        SELECT category_id
        FROM income_category
        WHERE category_name = 'Business'
    )
)
AND taxpayer_id NOT IN (
    SELECT taxpayer_id
    FROM income_record
    WHERE category_id IN (
        SELECT category_id
        FROM income_category
        WHERE category_name = 'Investment'
    )
);

-- Task 5 — Income records greater than every Investment income record
SELECT *
FROM income_record
WHERE amount > ALL (
    SELECT amount
    FROM income_record
    WHERE category_id IN (
        SELECT category_id
        FROM income_category
        WHERE category_name = 'Investment'
    )
);

-- Task 6 — Income records greater than at least one Investment income record
SELECT *
FROM income_record
WHERE amount > ANY (
    SELECT amount
    FROM income_record
    WHERE category_id IN (
        SELECT category_id
        FROM income_category
        WHERE category_name = 'Investment'
    )
);

-- Task 7 — Taxpayer(s) having the highest total income
SELECT taxpayer_id, full_name
FROM taxpayer
WHERE taxpayer_id IN (
    SELECT taxpayer_id
    FROM income_record
    GROUP BY taxpayer_id
    HAVING SUM(amount) >= ALL (
        SELECT SUM(amount)
        FROM income_record
        GROUP BY taxpayer_id
    )
);

-- Task 8 — Income records above the average income of their category
SELECT i.*
FROM income_record i
JOIN (
    SELECT category_id, AVG(amount) AS avg_amount
    FROM income_record
    GROUP BY category_id
) a
ON i.category_id = a.category_id
WHERE i.amount > a.avg_amount;