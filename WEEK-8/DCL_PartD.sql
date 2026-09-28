USE taxation_database;

-- PARTD
-- task1
CREATE USER 'tax_clerk1'@'localhost'
IDENTIFIED BY 'Tax@123';
SHOW GRANTS FOR 'tax_clerk1'@'localhost';
SELECT * FROM taxation_database.Income_Record;
SHOW GRANTS;

-- task2
GRANT SELECT ON taxation_database.Taxpayer TO 'tax_clerk1'@'localhost';
SHOW GRANTS FOR 'tax_clerk1'@'localhost';
SELECT CURRENT_USER();
SELECT * FROM taxation_database.Taxpayer;

-- task3
GRANT INSERT ON taxation_database.Income_Record TO 'tax_clerk1'@'localhost';
INSERT INTO taxation_database.Income_Record ()
VALUES
(1010, 101, 'DCL Test Income', 50000.00,
 '2026-03-31', 'DCL Test', 5, 6);

-- task4
UPDATE taxation_database.Income_Record SET amount = 60000 WHERE income_id = 1004; -- Output: denied bcz premsion not granted
-- DBMS_LAB connection i.e, Administartor
CREATE VIEW Taxpayer_Income_Summary AS SELECT
    t.taxpayer_id,
    t.full_name,
    ic.category_name,
    fy.year_label,
    ir.income_source,
    ir.amount
FROM Taxpayer t JOIN Income_Record ir ON t.taxpayer_id = ir.taxpayer_id JOIN Income_Category ic
    ON ir.category_id = ic.category_id JOIN Financial_Year fy ON ir.year_id = fy.year_id;
SHOW FULL TABLES WHERE Table_type = 'VIEW';
GRANT SELECT ON taxation_database.Taxpayer_Income_Summary TO 'tax_clerk1'@'localhost';
SHOW GRANTS FOR 'tax_clerk1'@'localhost';
    -- Switched to Tax clerk 1 connection
SELECT * FROM taxation_database.Taxpayer_Income_Summary;

-- task5
GRANT SELECT
ON taxation_database.Taxpayer_Income_Summary
TO 'tax_data_entry'@'localhost';
SELECT * FROM taxation_database.Taxpayer_Income_Summary;
SELECT * FROM taxation_database.Taxpayer; -- because we did not grant SELECT on Taxpayer to tax_data_entry

-- task6
    -- switch to Administartor connection
REVOKE INSERT ON taxation_database.Income_Record FROM 'tax_clerk1'@'localhost';
    -- switch to Tax Clerk1
INSERT INTO taxation_database.Income_Record ()
VALUES
(1011, 101, 'Revoke Test', 40000.00,
 '2026-03-31', 'Test', 5, 6); -- Error bcz permision denied
