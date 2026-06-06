-- ============================================
-- Chapter 2: Advanced SQL
-- 01. Aggregate Functions and Partitioning
-- 01a. Basic Column Aggregations
-- ============================================
-- Aggregate functions compute values across multiple rows.
-- Common functions: AVG, MIN, MAX, SUM, COUNT

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

INSERT INTO employees VALUES
(1, 'Alice', 'Smith', 90000, 'Management', '2021-01-15'),
(2, 'Bob', 'Johnson', 75000, 'Sales', '2022-03-20'),
(3, 'Charlie', 'Brown', 70000, 'Sales', '2022-06-10'),
(4, 'Diana', 'Davis', 65000, 'HR', '2023-02-01'),
(5, 'Eve', 'Wilson', 62000, 'IT', '2023-05-12'),
(6, 'Frank', 'Miller', 72000, 'IT', '2023-07-01');

-- ============================================
-- 1. COUNT: Count Number of Rows
-- ============================================
-- Count all employees
SELECT COUNT(*) AS total_employees FROM employees;

-- Count non-NULL emails (hypothetically)
SELECT COUNT(emp_id) AS total_employees FROM employees;

-- Count distinct departments
SELECT COUNT(DISTINCT department) AS unique_departments FROM employees;

-- ============================================
-- 2. SUM: Sum of Column Values
-- ============================================
-- Total salary of all employees
SELECT SUM(salary) AS total_salary FROM employees;

-- Total salary for a specific department
SELECT SUM(salary) AS sales_payroll FROM employees WHERE department = 'Sales';

-- ============================================
-- 3. AVG: Average Value
-- ============================================
-- Average salary of all employees
SELECT AVG(salary) AS avg_salary FROM employees;

-- Average salary by department (will use GROUP BY)
SELECT department, AVG(salary) AS avg_salary FROM employees GROUP BY department;

-- ============================================
-- 4. MIN: Minimum Value
-- ============================================
-- Lowest salary
SELECT MIN(salary) AS lowest_salary FROM employees;

-- Earliest hire date
SELECT MIN(hire_date) AS earliest_hire FROM employees;

-- Lowest salary in IT department
SELECT MIN(salary) AS lowest_it_salary FROM employees WHERE department = 'IT';

-- ============================================
-- 5. MAX: Maximum Value
-- ============================================
-- Highest salary
SELECT MAX(salary) AS highest_salary FROM employees;

-- Latest hire date
SELECT MAX(hire_date) AS latest_hire FROM employees;

-- Highest salary in Sales
SELECT MAX(salary) AS highest_sales_salary FROM employees WHERE department = 'Sales';

-- ============================================
-- 6. COMBINING MULTIPLE AGGREGATES
-- ============================================
-- Multiple aggregates in one query
SELECT 
    COUNT(*) AS employee_count,
    SUM(salary) AS total_salary,
    AVG(salary) AS average_salary,
    MIN(salary) AS lowest_salary,
    MAX(salary) AS highest_salary
FROM employees;

-- With WHERE clause
SELECT 
    COUNT(*) AS it_employees,
    AVG(salary) AS avg_it_salary,
    SUM(salary) AS total_it_salary
FROM employees
WHERE department = 'IT';

-- ============================================
-- 7. AGGREGATE WITH WHERE CLAUSE
-- ============================================
-- Filter before aggregating
SELECT 
    COUNT(*) AS senior_employees,
    AVG(salary) AS avg_senior_salary
FROM employees
WHERE salary > 70000;

-- Employees hired after 2022
SELECT 
    COUNT(*) AS recent_hires,
    AVG(salary) AS avg_recent_salary
FROM employees
WHERE YEAR(hire_date) >= 2023;

-- ============================================
-- 8. AGGREGATE WITH DISTINCT
-- ============================================
-- Count unique departments
SELECT COUNT(DISTINCT department) AS num_departments FROM employees;

-- Average of distinct salaries (no duplicates)
SELECT AVG(DISTINCT salary) AS avg_distinct_salary FROM employees;

-- ============================================
-- 9. NULL HANDLING IN AGGREGATES
-- ============================================
-- Aggregates ignore NULL values (except COUNT(*))

-- If we had NULL values:
-- SELECT AVG(salary) FROM employees;  -- Ignores NULLs
-- SELECT COUNT(salary) FROM employees;  -- Counts non-NULL
-- SELECT COUNT(*) FROM employees;  -- Counts all rows

-- ============================================
-- 10. PRACTICAL EXAMPLES
-- ============================================

-- Example 1: Employee Statistics
SELECT 
    COUNT(*) AS 'Total Employees',
    ROUND(AVG(salary), 2) AS 'Average Salary',
    MIN(salary) AS 'Minimum Salary',
    MAX(salary) AS 'Maximum Salary',
    MAX(salary) - MIN(salary) AS 'Salary Range'
FROM employees;

-- Example 2: Department Summary
SELECT 
    COUNT(*) AS 'Employee Count',
    SUM(salary) AS 'Total Payroll',
    ROUND(AVG(salary), 2) AS 'Average Salary'
FROM employees
WHERE department = 'Sales';

-- Example 3: Salary Distribution
SELECT 
    'All Employees' AS department,
    COUNT(*) AS count,
    ROUND(AVG(salary), 2) AS avg_salary
FROM employees;

-- ============================================
-- 11. ROUNDING WITH AGGREGATES
-- ============================================
-- Use ROUND to format monetary values
SELECT 
    ROUND(AVG(salary), 2) AS avg_salary,
    ROUND(SUM(salary), 2) AS total_salary,
    ROUND(MAX(salary), 0) AS max_salary
FROM employees;

-- ============================================
-- 12. MATHEMATICAL OPERATIONS WITH AGGREGATES
-- ============================================
-- Calculate salary increases
SELECT 
    SUM(salary) * 1.1 AS total_with_10pct_raise,
    ROUND(AVG(salary) * 0.05, 2) AS avg_bonus_5pct
FROM employees;
