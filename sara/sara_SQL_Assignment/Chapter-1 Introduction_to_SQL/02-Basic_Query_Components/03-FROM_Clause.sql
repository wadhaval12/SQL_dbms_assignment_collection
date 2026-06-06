-- ============================================
-- Chapter 1: Basic Query Components
-- 03. The From Clause
-- ============================================
-- The FROM clause specifies which table(s) to query.
-- It also handles Cartesian Product (cross joins) when multiple tables are listed.

USE company;

-- ============================================
-- 1. SINGLE TABLE QUERY (Most Common)
-- ============================================
SELECT * FROM employees;

SELECT first_name, salary FROM employees;

SELECT emp_id, first_name, salary FROM employees
WHERE salary > 70000;

-- ============================================
-- 2. CARTESIAN PRODUCT: FROM Multiple Tables
-- ============================================
-- When you list multiple tables in FROM without JOIN conditions,
-- every row from table1 is combined with every row from table2.
-- Result: (rows_in_table1) * (rows_in_table2)

-- Setup: Create a second table for examples
CREATE TABLE IF NOT EXISTS departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50),
    location VARCHAR(50)
);

INSERT INTO departments (dept_id, dept_name, location) VALUES
(1, 'Sales', 'New York'),
(2, 'IT', 'San Francisco'),
(3, 'HR', 'Boston');

-- Cartesian Product: Combine every employee with every department
-- This produces many rows (6 employees * 3 departments = 18 rows)
SELECT e.emp_id, e.first_name, d.dept_id, d.dept_name
FROM employees e, departments d;

-- ============================================
-- 3. TABLE ALIASES (Shortening Table Names)
-- ============================================
-- Using aliases makes queries shorter and clearer
SELECT e.emp_id, e.first_name, e.salary
FROM employees AS e;

-- Alias without AS keyword (also valid)
SELECT e.emp_id, e.first_name, e.salary
FROM employees e;

-- Useful with long table names
SELECT emp.emp_id, emp.first_name, dept.dept_name
FROM employees emp, departments dept;

-- ============================================
-- 4. COLUMN ALIASES IN FROM CLAUSE
-- ============================================
SELECT 
    e.emp_id AS 'Employee ID',
    e.first_name AS 'Name',
    e.salary AS 'Salary'
FROM employees e;

-- ============================================
-- 5. MULTIPLE TABLES WITH CONDITIONS
-- ============================================
-- Using FROM with multiple tables but only relevant rows
SELECT e.first_name, e.salary, d.dept_name
FROM employees e, departments d
WHERE e.department = d.dept_name;

-- ============================================
-- 6. FILTERING WITH FROM
-- ============================================
-- Combine multiple tables and filter results
SELECT e.first_name, e.salary, d.location
FROM employees e, departments d
WHERE e.department = d.dept_name
  AND e.salary > 70000;

-- ============================================
-- 7. DERIVED TABLES (Subquery in FROM Clause)
-- ============================================
-- Use a SELECT result as a temporary table
SELECT emp_id, full_name, salary
FROM (
    SELECT emp_id, CONCAT(first_name, ' ', last_name) AS full_name, salary
    FROM employees
) AS emp_derived
WHERE salary > 70000;

-- ============================================
-- 8. FROM WITH ORDER BY (Introduced Here)
-- ============================================
-- Get employees from IT department, ordered by salary
SELECT e.first_name, e.salary, e.department
FROM employees e
WHERE e.department = 'IT'
ORDER BY e.salary DESC;

-- ============================================
-- 9. UNDERSTANDING EXECUTION ORDER
-- ============================================
-- SQL Query Execution Order:
-- 1. FROM: Identify tables
-- 2. WHERE: Filter rows
-- 3. SELECT: Choose columns
-- 4. ORDER BY: Sort results
-- 5. LIMIT: Restrict number of rows

-- Example showing this order:
SELECT first_name, salary
FROM employees
WHERE salary > 65000
ORDER BY salary DESC
LIMIT 3;

-- This query:
-- 1. Looks at employees table
-- 2. Filters to salary > 65000
-- 3. Selects first_name and salary
-- 4. Sorts by salary in descending order
-- 5. Returns top 3 rows

-- ============================================
-- 10. PRACTICAL EXAMPLES
-- ============================================

-- Example 1: Simple query from one table
SELECT emp_id, first_name, email
FROM employees;

-- Example 2: Query with filtering
SELECT first_name, salary, department
FROM employees
WHERE department = 'Sales';

-- Example 3: Multiple tables with relationship
SELECT 
    e.first_name,
    e.salary,
    d.dept_name,
    d.location
FROM employees e, departments d
WHERE e.department = d.dept_name;

-- Example 4: Using derived table
SELECT 
    avg_salary_by_dept
FROM (
    SELECT AVG(salary) AS avg_salary_by_dept
    FROM employees
) AS salary_stats;

-- ============================================
-- 11. IMPORTANT NOTES
-- ============================================
-- - FROM clause always comes after SELECT syntax but is evaluated first
-- - Table aliases make queries more readable
-- - Multiple tables without conditions create Cartesian Products (usually not desired)
-- - Use proper JOIN syntax instead of Cartesian Product (covered in Chapter 3)
-- - Derived tables must have aliases
-- - Column names should be unambiguous when using multiple tables
