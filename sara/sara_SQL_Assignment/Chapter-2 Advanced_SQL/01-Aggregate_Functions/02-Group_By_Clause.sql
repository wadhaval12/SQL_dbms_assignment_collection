-- ============================================
-- Chapter 2: Advanced SQL
-- 01. Aggregate Functions and Partitioning
-- 01b. Group By Clause
-- ============================================
-- GROUP BY divides rows into groups and applies aggregates to each group.

USE company;

-- ============================================
-- 1. BASIC GROUP BY: Single Column
-- ============================================
-- Count employees by department
SELECT department, COUNT(*) AS employee_count
FROM employees
GROUP BY department;

-- Sum salaries by department
SELECT department, SUM(salary) AS total_salary
FROM employees
GROUP BY department;

-- ============================================
-- 2. GROUP BY: Multiple Columns
-- ============================================
-- Group by department and year of hire
SELECT 
    department,
    YEAR(hire_date) AS hire_year,
    COUNT(*) AS count
FROM employees
GROUP BY department, YEAR(hire_date);

-- ============================================
-- 3. GROUP BY WITH MULTIPLE AGGREGATES
-- ============================================
-- Average and max salary by department
SELECT 
    department,
    COUNT(*) AS employee_count,
    AVG(salary) AS avg_salary,
    MAX(salary) AS highest_salary,
    MIN(salary) AS lowest_salary,
    SUM(salary) AS total_salary
FROM employees
GROUP BY department;

-- ============================================
-- 4. GROUP BY WITH WHERE CLAUSE
-- ============================================
-- Filter before grouping
SELECT 
    department,
    COUNT(*) AS employee_count,
    AVG(salary) AS avg_salary
FROM employees
WHERE salary > 65000
GROUP BY department;

-- Employees hired after 2022
SELECT 
    department,
    COUNT(*) AS recent_hires
FROM employees
WHERE YEAR(hire_date) >= 2023
GROUP BY department;

-- ============================================
-- 5. GROUP BY WITH ORDER BY
-- ============================================
-- Order results by aggregate
SELECT 
    department,
    COUNT(*) AS employee_count,
    AVG(salary) AS avg_salary
FROM employees
GROUP BY department
ORDER BY avg_salary DESC;

-- Top departments by payroll
SELECT 
    department,
    SUM(salary) AS total_payroll
FROM employees
GROUP BY department
ORDER BY total_payroll DESC;

-- ============================================
-- 6. GROUP BY WITH LIMIT
-- ============================================
-- Top 3 departments by employee count
SELECT 
    department,
    COUNT(*) AS employee_count
FROM employees
GROUP BY department
ORDER BY employee_count DESC
LIMIT 3;

-- ============================================
-- 7. GROUP BY WITH EXPRESSIONS
-- ============================================
-- Group by year of hire
SELECT 
    YEAR(hire_date) AS hire_year,
    COUNT(*) AS hires
FROM employees
GROUP BY YEAR(hire_date);

-- Group by salary range
SELECT 
    CASE 
        WHEN salary < 65000 THEN 'Entry Level'
        WHEN salary < 75000 THEN 'Mid Level'
        ELSE 'Senior'
    END AS salary_level,
    COUNT(*) AS count,
    AVG(salary) AS avg_salary
FROM employees
GROUP BY salary_level;

-- ============================================
-- 8. GROUP BY WITH DISTINCT
-- ============================================
-- Count distinct departments
SELECT COUNT(DISTINCT department) FROM employees;

-- However, DISTINCT in aggregates doesn't need GROUP BY
SELECT 
    department,
    COUNT(DISTINCT SUBSTRING(first_name, 1, 1)) AS unique_first_letters
FROM employees
GROUP BY department;

-- ============================================
-- 9. PRACTICAL EXAMPLES
-- ============================================

-- Example 1: Department Payroll Summary
SELECT 
    department AS 'Department',
    COUNT(*) AS 'Employees',
    ROUND(AVG(salary), 2) AS 'Avg Salary',
    SUM(salary) AS 'Total Payroll'
FROM employees
GROUP BY department
ORDER BY 'Total Payroll' DESC;

-- Example 2: Salary Distribution by Department
SELECT 
    department,
    MIN(salary) AS min_salary,
    ROUND(AVG(salary), 2) AS avg_salary,
    MAX(salary) AS max_salary,
    MAX(salary) - MIN(salary) AS salary_range
FROM employees
GROUP BY department;

-- Example 3: Hiring Trends
SELECT 
    YEAR(hire_date) AS hire_year,
    COUNT(*) AS hires,
    ROUND(AVG(salary), 2) AS avg_starting_salary
FROM employees
GROUP BY YEAR(hire_date)
ORDER BY hire_year;

-- Example 4: Pay Grade Analysis
SELECT 
    CASE 
        WHEN salary < 65000 THEN 'Level 1'
        WHEN salary < 75000 THEN 'Level 2'
        ELSE 'Level 3'
    END AS pay_grade,
    COUNT(*) AS employee_count,
    ROUND(AVG(salary), 2) AS avg_salary,
    SUM(salary) AS total_payroll
FROM employees
GROUP BY pay_grade;

-- ============================================
-- 10. RULES FOR GROUP BY
-- ============================================
-- - All non-aggregated columns in SELECT must be in GROUP BY
-- - Aggregated columns don't go in GROUP BY
-- - WHERE clause is applied BEFORE grouping
-- - ORDER BY can reference grouped columns or aliases

-- ============================================
-- 11. ERROR: Missing Columns in GROUP BY
-- ============================================
-- This would cause an error in strict SQL modes:
-- SELECT department, first_name, AVG(salary)
-- FROM employees
-- GROUP BY department;

-- Correct version:
-- SELECT department, AVG(salary)
-- FROM employees
-- GROUP BY department;
