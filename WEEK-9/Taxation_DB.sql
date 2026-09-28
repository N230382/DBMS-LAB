SELECT USER FROM dual;

-- PART A
-- task1
SET SERVEROUTPUT ON;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Welcome to TaxationDB');
END;
/

CREATE TABLE Taxpayer (
    taxpayer_id   NUMBER PRIMARY KEY,
    pan_number    VARCHAR2(10) NOT NULL UNIQUE,
    full_name     VARCHAR2(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    occupation    VARCHAR2(150) NOT NULL,
    annual_income NUMBER(12,2) NOT NULL,
    email         VARCHAR2(100) UNIQUE,
    is_active     NUMBER(1) DEFAULT 1
);
INSERT INTO Taxpayer
VALUES (101, 'ABCDE1234F', 'Ravi Kumar',
        DATE '1995-06-15', 'Software Engineer',
        950000.00, 'ravi.kumar@example.com', 1);

INSERT INTO Taxpayer
VALUES (102, 'BCDEF2345G', 'Priya Sharma',
        DATE '1992-11-22', 'Doctor',
        1200000.00, 'priya.sharma@example.com', 1);

INSERT INTO Taxpayer
VALUES (103, 'CDEFG3456H', 'Arjun Reddy',
        DATE '1988-03-10', 'Bussiness Owner',
        1800000.00, 'arjun.reddy@example.com', 1);

INSERT INTO Taxpayer
VALUES (104, 'DEFGH4567J', 'Sneha Patel',
        DATE '1998-08-05', 'Teacher',
        620000.00, 'sneha.patel@example.com', 1);

INSERT INTO Taxpayer
VALUES (105, 'EFGHJ5678K', 'Kiran Rao',
        DATE '1990-01-18', 'Software Consultant',
        750000.00, 'kiran.rao@example.com', 1);

INSERT INTO Taxpayer
VALUES (106, 'FGHJK6789L', 'Meera Singh',
        DATE '1985-12-30', 'Consultant',
        1500000.00, 'meera.singh@example.com', 1);

COMMIT;
SELECT * FROM Taxpayer;

CREATE TABLE Income_Category (
    category_id     NUMBER PRIMARY KEY,
    category_name   VARCHAR2(50) NOT NULL UNIQUE,
    des_cription    VARCHAR2(200) NOT NULL,
    taxable         NUMBER(1) NOT NULL,
    Rental_Income   NUMBER
);
INSERT INTO Income_Category
VALUES (
    1,
    'Salary',
    'Income received from employment',
    1,
    NULL
);

INSERT INTO Income_Category
VALUES (
    2,
    'Business',
    'Income earned from business activities',
    1,
    NULL
);

INSERT INTO Income_Category
VALUES (
    3,
    'House Property',
    'Income received from property or rent',
    1,
    NULL
);

INSERT INTO Income_Category
VALUES (
    4,
    'Capital Gains',
    'Income from transfer of eligible assets',
    1,
    NULL
);

INSERT INTO Income_Category
VALUES (
    5,
    'Other Sources',
    'Income such as bank interest',
    1,
    NULL
);

INSERT INTO Income_Category
VALUES (
    6,
    'Agricultural Income',
    'Income from eligible agricultural activities',
    1,
    NULL
);
COMMIT;

CREATE TABLE Financial_Year (
    year_id          NUMBER PRIMARY KEY,
    year_label       VARCHAR2(9) NOT NULL UNIQUE,
    start_date       DATE NOT NULL,
    end_date         DATE NOT NULL,
    filling_deadline DATE,
    is_current       NUMBER(1) NOT NULL
);
INSERT INTO Financial_Year
VALUES (
    1, '2020-2021',
    DATE '2020-04-01',
    DATE '2021-03-31',
    DATE '2021-07-31',
    0
);

INSERT INTO Financial_Year
VALUES (
    2, '2021-2022',
    DATE '2021-04-01',
    DATE '2022-03-31',
    DATE '2022-07-31',
    0
);

INSERT INTO Financial_Year
VALUES (
    3, '2022-2023',
    DATE '2022-04-01',
    DATE '2023-03-31',
    DATE '2023-07-31',
    0
);

INSERT INTO Financial_Year
VALUES (
    4, '2023-2024',
    DATE '2023-04-01',
    DATE '2024-03-31',
    DATE '2024-07-31',
    0
);

INSERT INTO Financial_Year
VALUES (
    5, '2024-2025',
    DATE '2024-04-01',
    DATE '2025-03-31',
    DATE '2025-07-31',
    0
);

INSERT INTO Financial_Year
VALUES (
    6, '2025-2026',
    DATE '2025-04-01',
    DATE '2026-03-31',
    DATE '2026-07-31',
    0
);

COMMIT;

CREATE TABLE Income_Record(
    income_id NUMBER PRIMARY KEY,
    taxpayer_id NUMBER NOT NULL,
    income_source VARCHAR2(100) NOT NULL,
    amount NUMBER(12,2) NOT NULL,
    received_date DATE NOT NULL,
    remarks VARCHAR2(200),
    category_id NUMBER NOT NULL,
    year_id NUMBER NOT NULL,

    CONSTRAINT fk_income_taxpayer
        FOREIGN KEY (taxpayer_id)
        REFERENCES Taxpayer(taxpayer_id),

    CONSTRAINT fk_income_category
        FOREIGN KEY (category_id)
        REFERENCES Income_Category(category_id),

    CONSTRAINT fk_income_year
        FOREIGN KEY (year_id)
        REFERENCES Financial_Year(year_id)
);

INSERT INTO Income_Record
VALUES (
    1001, 101, 'TechNova Solutions',
    860000.00,
    DATE '2026-03-31',
    NULL, 1, 1
);

INSERT INTO Income_Record
VALUES (
    1002, 102, 'City Care Hospital',
    1200000.00,
    DATE '2026-03-31',
    NULL, 2, 2
);

INSERT INTO Income_Record
VALUES (
    1003, 103, 'Reddy Enterprises',
    850000.00,
    DATE '2026-03-31',
    NULL, 3, 3
);

INSERT INTO Income_Record
VALUES (
    1004, 104, 'Sunrise School',
    60000.00,
    DATE '2026-03-31',
    NULL, 4, 4
);

INSERT INTO Income_Record
VALUES (
    1005, 105, 'Web Design Projects',
    750000.00,
    DATE '2026-03-31',
    NULL, 5, 5
);

INSERT INTO Income_Record
VALUES (
    1006, 106, 'Professional Consulting',
    1500000.00,
    DATE '2026-03-31',
    NULL, 6, 6
);

COMMIT;

SELECT * FROM Taxpayer;
SELECT * FROM Income_Category;
SELECT * FROM Financial_Year;
SELECT * FROM Income_Record;