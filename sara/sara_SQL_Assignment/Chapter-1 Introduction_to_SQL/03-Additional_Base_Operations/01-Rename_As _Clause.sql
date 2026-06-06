-- ============================================
-- Chapter 1: Additional Base Operations
-- 01. The Rename Operation (AS Clause)
-- ============================================
-- The RENAME operation (AS clause) creates aliases for columns and tables.
-- This improves readability and allows temporary renaming without modifying the database.

USE company;

-- ============================================
-- 1. COLUMN ALIASES (Renaming Columns in Output)
-- ============================================
-- Using AS keyword (explicit)
SELECT first_name AS 'First Name', last_name AS 'Last Name'
FROM employees;

-- Without AS keyword (implicit)
SELECT first_name 'First Name', last_name 'Last Name'
FROM employees;

-- With or without quotes
SELECT 
    first_name FirstName,
    last_name LastName,
    salary MonthlySalary
FROM employees;

-- ============================================
-- 2. TABLE ALIASES (Renaming Tables in Query)
-- ============================================
-- Short alias
SELECT e.emp_id, e.first_name, e.salary
FROM employees e;

-- Longer alias
SELECT emp.emp_id, emp.first_name, emp.salary
FROM employees emp;

-- ============================================
-- 3. RENAMING WITH EXPRESSIONS
-- ============================================
-- Arithmetic expressions with aliases
SELECT 
    first_name,
    salary,
    salary * 12 AS annual_salary,
    salary * 1.1 AS new_salary_after_raise
FROM employees;

-- String operations with aliases
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,
    email AS email_address
FROM employees;

-- ============================================
-- 4. RENAMING IN DERIVED TABLES
-- ============================================
-- The derived table and its columns must have aliases
SELECT 
    emp_id,
    full_name,
    annual_salary
FROM (
    SELECT 
        emp_id,
        CONCAT(first_name, ' ', last_name) AS full_name,
        salary * 12 AS annual_salary
    FROM employees
) AS emp_summary;

-- ============================================
-- 5. MULTIPLE ALIASES IN ONE QUERY
-- ============================================
SELECT 
    e.emp_id AS 'Employee ID',
    CONCAT(e.first_name, ' ', e.last_name) AS 'Full Name',
    e.salary AS 'Monthly Salary',
    ROUND(e.salary * 1.15, 2) AS 'With 15% Bonus',
    e.department AS 'Dept',
    YEAR(CURDATE()) - YEAR(e.hire_date) AS 'Years of Service'
FROM employees e;

-- ============================================
-- 6. USING ALIASES IN WHERE AND ORDER BY
-- ============================================
-- Note: Cannot use aliases in WHERE clause (evaluated before SELECT)
-- But CAN use aliases in ORDER BY (evaluated after SELECT)

-- This WORKS - alias used in ORDER BY
SELECT 
    first_name,
    salary * 12 AS annual_salary
FROM employees
ORDER BY annual_salary DESC;

-- This FAILS - alias used in WHERE (if unsupported in MySQL version)
-- SELECT first_name, salary * 12 AS annual_salary
-- FROM employees
-- WHERE annual_salary > 900000;   -- Will error

-- Correct way to filter by expression:
SELECT 
    first_name,
    salary * 12 AS annual_salary
FROM employees
WHERE salary * 12 > 900000;

-- ============================================
-- 7. PRACTICAL EXAMPLES
-- ============================================

-- Example 1: Employee Report with Aliases
SELECT 
    e.emp_id AS 'ID',
    CONCAT(e.first_name, ' ', e.last_name) AS 'Employee Name',
    e.email AS 'Contact Email',
    e.salary AS 'Monthly Pay',
    ROUND(e.salary * 12, 2) AS 'Annual Salary',
    e.department AS 'Department'
FROM employees e
ORDER BY 'Annual Salary' DESC;

-- Example 2: Salary Analysis with Aliases
SELECT 
    first_name,
    salary AS current_salary,
    ROUND(salary * 1.1, 2) AS salary_10pct_raise,
    ROUND(salary * 0.05, 2) AS bonus_5pct,
    ROUND((salary * 1.1) + (salary * 0.05), 2) AS total_compensation
FROM employees;

-- Example 3: Date Calculations with Aliases
SELECT 
    first_name,
    hire_date,
    YEAR(CURDATE()) - YEAR(hire_date) AS years_employed,
    DATEDIFF(CURDATE(), hire_date) AS days_employed
FROM employees;

-- ============================================
-- 8. BEST PRACTICES FOR ALIASES
-- ============================================
-- Use meaningful, descriptive aliases
-- Use quotes for aliases with spaces
-- Use table aliases to disambiguate columns in multi-table queries
-- Avoid using column names as aliases (confusing)
-- Keep aliases short but clear
