-- ============================================
-- Chapter 3: Intermediate SQL
-- 02. View Architectures
-- 01. Create View
-- ============================================
-- A VIEW is a virtual table based on a SELECT query

USE company;

-- Setup
CREATE TABLE IF NOT EXISTS employees (
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    salary DECIMAL(10,2),
    department VARCHAR(50),
    hire_date DATE
);

INSERT IGNORE INTO employees VALUES
(1, 'Alice', 'Smith', 90000, 'Sales', '2020-01-15'),
(2, 'Bob', 'Johnson', 75000, 'IT', '2021-03-20'),
(3, 'Charlie', 'Brown', 70000, 'Sales', '2022-06-10'),
(4, 'Diana', 'Davis', 65000, 'HR', '2023-02-01'),
(5, 'Eve', 'Wilson', 62000, 'IT', '2023-05-12');

-- ============================================
-- 1. CREATE VIEW: Basic Syntax
-- ============================================
-- Simple view - all employees in IT
CREATE OR REPLACE VIEW it_employees AS
SELECT emp_id, first_name, last_name, salary
FROM employees
WHERE department = 'IT';

-- Use the view like a table
SELECT * FROM it_employees;

-- ============================================
-- 2. CREATE VIEW: With Calculations
-- ============================================
-- View with computed columns
CREATE OR REPLACE VIEW employee_salary_report AS
SELECT 
    emp_id,
    CONCAT(first_name, ' ', last_name) AS full_name,
    salary AS monthly_salary,
    salary * 12 AS annual_salary,
    ROUND(salary * 1.1, 2) AS salary_with_10pct_raise
FROM employees;

-- Query the view
SELECT * FROM employee_salary_report WHERE emp_id = 1;

-- ============================================
-- 3. CREATE VIEW: With JOIN
-- ============================================
CREATE TABLE IF NOT EXISTS departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

INSERT INTO departments VALUES
(1, 'Sales'),
(2, 'IT'),
(3, 'HR');

-- View combining multiple tables
CREATE OR REPLACE VIEW employee_departments AS
SELECT 
    e.emp_id,
    CONCAT(e.first_name, ' ', e.last_name) AS name,
    d.dept_name,
    e.salary
FROM employees e
LEFT JOIN departments d ON e.department = d.dept_name;

-- Query the view
SELECT * FROM employee_departments;

-- ============================================
-- 4. CREATE VIEW: With AGGREGATES
-- ============================================
-- View with GROUP BY
CREATE OR REPLACE VIEW department_salary_summary AS
SELECT 
    department,
    COUNT(*) AS employee_count,
    ROUND(AVG(salary), 2) AS avg_salary,
    SUM(salary) AS total_payroll,
    MAX(salary) AS highest_salary,
    MIN(salary) AS lowest_salary
FROM employees
GROUP BY department;

-- Query the aggregate view
SELECT * FROM department_salary_summary;

-- ============================================
-- 5. CREATE VIEW: WITH CHECK OPTION
-- ============================================
-- Ensures updates through view maintain WHERE condition
CREATE OR REPLACE VIEW high_earners AS
SELECT emp_id, first_name, salary
FROM employees
WHERE salary > 70000
WITH CHECK OPTION;

-- Insert through view - succeeds
-- INSERT INTO high_earners VALUES (6, 'Frank', 80000);

-- Update through view - must maintain salary > 70000
-- UPDATE high_earners SET salary = 60000 WHERE emp_id = 1;
-- ERROR: Check option failed (salary would be <= 70000)

-- ============================================
-- 6. VIEW: Read-Only
-- ============================================
-- Views with multiple tables often become read-only
CREATE OR REPLACE VIEW employee_full_details AS
SELECT 
    e.emp_id,
    e.first_name,
    e.last_name,
    e.salary,
    YEAR(CURDATE()) - YEAR(e.hire_date) AS years_employed
FROM employees e
LEFT JOIN departments d ON e.department = d.dept_name;

-- This view can be queried
SELECT * FROM employee_full_details;

-- But cannot be updated (has JOIN)
-- UPDATE employee_full_details SET salary = 80000 WHERE emp_id = 1;

-- ============================================
-- 7. DROP VIEW
-- ============================================
-- Drop a view
DROP VIEW IF EXISTS it_employees;

-- Drop multiple views
DROP VIEW IF EXISTS high_earners, employee_salary_report;

-- ============================================
-- 8. SHOW VIEWS
-- ============================================
-- List all views
SHOW TABLES;

-- Get view definition
SHOW CREATE VIEW employee_departments;

-- ============================================
-- 9. VIEW BASED ON VIEW (Nested View)
-- ============================================
-- View built from another view
CREATE OR REPLACE VIEW high_earners_summary AS
SELECT 
    name,
    department AS dept,
    salary
FROM employee_departments
WHERE salary > 75000;

SELECT * FROM high_earners_summary;

-- ============================================
-- 10. VIEW WITH DISTINCT
-- ============================================
CREATE OR REPLACE VIEW unique_departments AS
SELECT DISTINCT department
FROM employees;

SELECT * FROM unique_departments;

-- ============================================
-- 11. VIEW WITH SUBQUERY
-- ============================================
CREATE OR REPLACE VIEW above_average_earners AS
SELECT *
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

SELECT * FROM above_average_earners;

-- ============================================
-- 12. PRACTICAL VIEW EXAMPLES
-- ============================================

-- Example 1: Manager View
CREATE OR REPLACE VIEW manager_overview AS
SELECT 
    department,
    COUNT(*) AS total_staff,
    ROUND(AVG(salary), 2) AS avg_salary,
    SUM(salary) AS payroll_cost
FROM employees
GROUP BY department
ORDER BY payroll_cost DESC;

-- Example 2: HR Dashboard
CREATE OR REPLACE VIEW hr_dashboard AS
SELECT 
    CONCAT(first_name, ' ', last_name) AS employee_name,
    department,
    salary,
    YEAR(CURDATE()) - YEAR(hire_date) AS tenure_years,
    CASE 
        WHEN salary > 80000 THEN 'Senior'
        WHEN salary > 65000 THEN 'Mid-Level'
        ELSE 'Entry-Level'
    END AS salary_band
FROM employees;

-- Example 3: Payroll View
CREATE OR REPLACE VIEW payroll_report AS
SELECT 
    emp_id,
    CONCAT(first_name, ' ', last_name) AS name,
    salary,
    ROUND(salary * 0.15, 2) AS tax_deduction,
    ROUND(salary * 0.92, 2) AS net_pay
FROM employees;

-- ============================================
-- 13. MODIFYING VIEWS
-- ============================================
-- ALTER VIEW (MySQL 5.7.17+)
-- ALTER VIEW employee_departments AS
-- SELECT ... (new definition);

-- Or recreate with CREATE OR REPLACE VIEW

-- ============================================
-- 14. VIEW BENEFITS
-- ============================================
-- - Simplify complex queries
-- - Reuse common logic
-- - Hide complexity from users
-- - Provide data security (show only needed columns)
-- - Create consistent interfaces

-- ============================================
-- 15. VIEW LIMITATIONS
-- ============================================
-- - Cannot use INTO clause in subqueries
-- - Cannot reference temporary tables
-- - Cannot use multiple tables in UPDATE (usually)
-- - Performance: Not pre-computed (computed on each query)
-- - Materialized views (if supported) pre-compute for speed
