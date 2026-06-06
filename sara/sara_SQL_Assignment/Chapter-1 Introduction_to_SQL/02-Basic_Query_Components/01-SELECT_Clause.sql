-- ============================================
-- Chapter 1: Basic Query Components
-- 01. The Select Clause
-- ============================================
-- The SELECT clause specifies which columns to retrieve from a table.
-- It can include:
-- - Column names
-- - Expressions and calculations
-- - Literal values
-- - DISTINCT to remove duplicates
-- - ALL to include duplicates (default)

USE company;

-- Setup: Create sample data
CREATE TABLE IF NOT EXISTS employees (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    salary DECIMAL(10,2),
    department VARCHAR(50),
    hire_date DATE
);

INSERT INTO employees (first_name, last_name, email, salary, department, hire_date) VALUES
('John', 'Doe', 'john@email.com', 75000, 'Sales', '2022-01-15'),
('Jane', 'Smith', 'jane@email.com', 82000, 'IT', '2023-02-20'),
('Bob', 'Johnson', 'bob@email.com', 60000, 'Sales', '2023-03-10'),
('Alice', 'Williams', 'alice@email.com', 72000, 'HR', '2023-04-05'),
('Mike', 'Brown', 'mike@email.com', 68000, 'IT', '2023-05-12'),
('Sara', 'Davis', 'sara@email.com', 75000, 'Sales', '2023-06-01');

-- ============================================
-- 1. SELECT ALL COLUMNS (*)
-- ============================================
SELECT * FROM employees;

-- ============================================
-- 2. SELECT SPECIFIC COLUMNS
-- ============================================
-- Retrieve only first_name and last_name
SELECT first_name, last_name FROM employees;

-- Retrieve first_name, email, and salary
SELECT first_name, email, salary FROM employees;

-- ============================================
-- 3. PROJECTIONS: Reordering Columns
-- ============================================
-- Retrieve in different order
SELECT salary, first_name, email FROM employees;

-- ============================================
-- 4. DISTINCT: Remove Duplicates
-- ============================================
-- Get unique departments (removes duplicates)
SELECT DISTINCT department FROM employees;

-- Get unique salary values
SELECT DISTINCT salary FROM employees;

-- DISTINCT with multiple columns
SELECT DISTINCT department, salary FROM employees;

-- ============================================
-- 5. ALL: Include All Rows (Default Behavior)
-- ============================================
-- Explicitly include duplicates (redundant - ALL is default)
SELECT ALL department FROM employees;

-- ============================================
-- 6. LITERAL ATTRIBUTES: Fixed Values
-- ============================================
-- Select literal strings and numbers
SELECT 'Employee' AS label, first_name, salary FROM employees;

-- Mix columns with literals
SELECT 'Active' AS status, first_name, 'Company XYZ' AS company FROM employees;

-- ============================================
-- 7. ARITHMETIC EXPRESSIONS
-- ============================================
-- Calculate annual salary (monthly * 12)
SELECT first_name, salary, salary * 12 AS annual_salary FROM employees;

-- Calculate salary increase (10% raise)
SELECT first_name, salary, salary * 1.1 AS new_salary FROM employees;

-- Calculate years of service
SELECT first_name, YEAR(CURDATE()) - YEAR(hire_date) AS years_of_service FROM employees;

-- ============================================
-- 8. STRING CONCATENATION
-- ============================================
-- Combine first and last names
SELECT CONCAT(first_name, ' ', last_name) AS full_name FROM employees;

-- Alternative syntax with AS
SELECT first_name, last_name, CONCAT(first_name, ' ', last_name) AS full_name FROM employees;

-- ============================================
-- 9. COLUMN ALIASES (Renaming Output)
-- ============================================
-- Using AS keyword (explicit)
SELECT 
    first_name AS 'First Name',
    last_name AS 'Last Name',
    salary AS 'Monthly Salary'
FROM employees;

-- Without AS keyword (implicit)
SELECT 
    first_name 'Employee Name',
    salary 'Salary Amount'
FROM employees;

-- ============================================
-- 10. COMBINING PROJECTIONS, EXPRESSIONS, AND ALIASES
-- ============================================
SELECT
    emp_id AS 'Employee ID',
    CONCAT(first_name, ' ', last_name) AS 'Full Name',
    email AS 'Email Address',
    salary AS 'Monthly Salary',
    salary * 12 AS 'Annual Salary',
    department AS 'Department',
    YEAR(CURDATE()) - YEAR(hire_date) AS 'Years in Company'
FROM employees;

-- ============================================
-- 11. SELECT WITH MATHEMATICAL FUNCTIONS
-- ============================================
SELECT
    first_name,
    salary,
    ROUND(salary * 1.15, 2) AS 'Salary with 15% Bonus',
    FLOOR(salary / 12) AS 'Weekly Estimate',
    CEIL(salary / 26) AS 'Bi-weekly Amount'
FROM employees;

-- ============================================
-- 12. COUNTING WITH SELECT
-- ============================================
-- Count total number of rows
SELECT COUNT(*) AS total_employees FROM employees;

-- But note: More detail on COUNT() in Aggregate Functions section
