-- ============================================
-- Chapter 1: Set Operations
-- 01. Union / Union All Queries
-- ============================================
-- UNION combines results from multiple SELECT statements
-- - UNION: Removes duplicate rows
-- - UNION ALL: Includes all rows (including duplicates)

USE company;

-- Setup tables
CREATE TABLE IF NOT EXISTS sales_employees (
    emp_id INT,
    name VARCHAR(50),
    salary DECIMAL(10,2)
);

CREATE TABLE IF NOT EXISTS it_employees (
    emp_id INT,
    name VARCHAR(50),
    salary DECIMAL(10,2)
);

INSERT INTO sales_employees VALUES
(1, 'John Doe', 75000),
(2, 'Jane Smith', 82000),
(3, 'Bob Johnson', 60000);

INSERT INTO it_employees VALUES
(4, 'Alice Williams', 72000),
(5, 'Mike Brown', 68000),
(1, 'John Doe', 75000);  -- Same person in both tables

-- ============================================
-- 1. UNION: Combine Without Duplicates
-- ============================================
-- Get all unique employees from both departments
SELECT name, salary FROM sales_employees
UNION
SELECT name, salary FROM it_employees;

-- ============================================
-- 2. UNION ALL: Combine With Duplicates
-- ============================================
-- Get all employees including duplicates
SELECT name, salary FROM sales_employees
UNION ALL
SELECT name, salary FROM it_employees;

-- ============================================
-- 3. UNION: Different Tables, Same Schema
-- ============================================
-- Combine employees from different years/periods

CREATE TABLE IF NOT EXISTS employees_2022 (
    emp_id INT,
    name VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS employees_2023 (
    emp_id INT,
    name VARCHAR(50)
);

INSERT INTO employees_2022 VALUES
(1, 'Alice'), (2, 'Bob'), (3, 'Charlie');

INSERT INTO employees_2023 VALUES
(2, 'Bob'), (3, 'Charlie'), (4, 'Diana');

-- All employees from both years (no duplicates)
SELECT name FROM employees_2022
UNION
SELECT name FROM employees_2023;

-- All employees from both years (with duplicates)
SELECT name FROM employees_2022
UNION ALL
SELECT name FROM employees_2023;

-- ============================================
-- 4. UNION: Multiple Tables
-- ============================================
-- Combine from 3 or more tables
SELECT name FROM employees_2022
UNION
SELECT name FROM employees_2023
UNION
SELECT name FROM sales_employees;

-- ============================================
-- 5. UNION: With WHERE Clause
-- ============================================
-- High earners from both departments
SELECT name, salary FROM sales_employees WHERE salary > 70000
UNION
SELECT name, salary FROM it_employees WHERE salary > 70000;

-- ============================================
-- 6. UNION: With ORDER BY
-- ============================================
-- Order the combined results
SELECT name FROM sales_employees
UNION
SELECT name FROM it_employees
ORDER BY name ASC;

-- Salary ranking of all unique employees
SELECT name, salary FROM sales_employees
UNION
SELECT name, salary FROM it_employees
ORDER BY salary DESC;

-- ============================================
-- 7. UNION: With Aliases
-- ============================================
-- Add descriptive columns
SELECT name AS employee_name, salary, 'Sales' AS department FROM sales_employees
UNION
SELECT name AS employee_name, salary, 'IT' AS department FROM it_employees
ORDER BY employee_name;

-- ============================================
-- 8. UNION: Rules and Constraints
-- ============================================
-- Rules:
-- 1. Same number of columns in both SELECT statements
-- 2. Corresponding columns must have compatible data types
-- 3. Column names from first SELECT are used in result
-- 4. ORDER BY applies to entire result set

-- Example of compatible data types:
SELECT emp_id, name FROM sales_employees
UNION
SELECT emp_id, CONCAT('Mr. ', name) FROM it_employees;

-- ============================================
-- 9. UNION ALL: Performance Advantage
-- ============================================
-- UNION ALL is faster (no duplicate removal overhead)
-- Use when you know there are no duplicates

-- This is more efficient if no duplicates expected
SELECT name FROM sales_employees
UNION ALL
SELECT name FROM it_employees;

-- ============================================
-- 10. PRACTICAL EXAMPLES
-- ============================================

-- Example 1: Combine customer lists from different sources
-- CREATE TABLE online_customers (id INT, name VARCHAR(50), email VARCHAR(100));
-- CREATE TABLE retail_customers (id INT, name VARCHAR(50), email VARCHAR(100));

-- SELECT name, email FROM online_customers
-- UNION
-- SELECT name, email FROM retail_customers;

-- Example 2: Find employees and managers (all people involved in hierarchy)
-- SELECT emp_id, first_name FROM employees
-- UNION
-- SELECT manager_id, manager_name FROM managers;

-- Example 3: Historical data analysis
SELECT 'Q1 2023' AS quarter, SUM(amount) AS revenue FROM sales_2023_q1
UNION
SELECT 'Q2 2023' AS quarter, SUM(amount) AS revenue FROM sales_2023_q2
UNION
SELECT 'Q3 2023' AS quarter, SUM(amount) AS revenue FROM sales_2023_q3;

-- ============================================
-- 11. UNION vs JOIN
-- ============================================
-- UNION: Combine rows from multiple queries (stacking)
-- JOIN: Combine columns from multiple tables (side-by-side)

-- UNION (vertical combination):
SELECT name FROM sales_employees
UNION
SELECT name FROM it_employees;

-- JOIN (horizontal combination):
-- SELECT s.name, i.name FROM sales_employees s
-- JOIN it_employees i ON s.emp_id = i.emp_id;
