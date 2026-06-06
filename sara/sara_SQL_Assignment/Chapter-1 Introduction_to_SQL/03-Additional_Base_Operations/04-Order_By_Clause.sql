-- ============================================
-- Chapter 1: Additional Base Operations
-- 04. Ordering the Display of Tuples (ORDER BY)
-- ============================================
-- ORDER BY clause sorts query results in ascending (ASC) or descending (DESC) order.

USE company;

-- ============================================
-- 1. BASIC ORDER BY: Single Column ASC (Default)
-- ============================================
-- Sort employees by first name (ascending - default)
SELECT first_name, salary FROM employees ORDER BY first_name;

-- Explicit ASC (same result)
SELECT first_name, salary FROM employees ORDER BY first_name ASC;

-- ============================================
-- 2. ORDER BY: Descending Order (DESC)
-- ============================================
-- Sort employees by salary (highest to lowest)
SELECT first_name, salary FROM employees ORDER BY salary DESC;

-- Sort by last name descending
SELECT first_name, last_name FROM employees ORDER BY last_name DESC;

-- ============================================
-- 3. ORDER BY: Multiple Columns
-- ============================================
-- Sort by department (ASC), then by salary (DESC) within each department
SELECT first_name, department, salary FROM employees
ORDER BY department ASC, salary DESC;

-- Sort by salary (DESC), then by first name (ASC)
SELECT first_name, salary FROM employees
ORDER BY salary DESC, first_name ASC;

-- ============================================
-- 4. ORDER BY: Using Column Position
-- ============================================
-- Sort by second column in SELECT list (salary)
SELECT first_name, salary, department FROM employees ORDER BY 2 DESC;

-- Sort by first column, then third column
SELECT first_name, salary, department FROM employees ORDER BY 1 ASC, 3 ASC;

-- ============================================
-- 5. ORDER BY: Using Column Alias
-- ============================================
-- Sort by calculated column (annual salary)
SELECT 
    first_name,
    salary,
    salary * 12 AS annual_salary
FROM employees
ORDER BY annual_salary DESC;

-- Sort by aliased columns
SELECT 
    first_name AS name,
    salary AS monthly_pay,
    salary * 12 AS annual_salary
FROM employees
ORDER BY annual_salary DESC;

-- ============================================
-- 6. ORDER BY: String/Text Columns
-- ============================================
-- Alphabetical sort (A-Z)
SELECT first_name FROM employees ORDER BY first_name ASC;

-- Reverse alphabetical (Z-A)
SELECT first_name FROM employees ORDER BY first_name DESC;

-- Sort by length of name
SELECT first_name, LENGTH(first_name) AS name_length FROM employees
ORDER BY LENGTH(first_name) DESC;

-- ============================================
-- 7. ORDER BY: Date Columns
-- ============================================
-- Newest hires first
SELECT first_name, hire_date FROM employees ORDER BY hire_date DESC;

-- Oldest hires first
SELECT first_name, hire_date FROM employees ORDER BY hire_date ASC;

-- Order by years of service (newest employees first)
SELECT first_name, hire_date,
       YEAR(CURDATE()) - YEAR(hire_date) AS years_of_service
FROM employees
ORDER BY hire_date DESC;

-- ============================================
-- 8. ORDER BY: Numeric Columns
-- ============================================
-- Highest salary first
SELECT first_name, salary FROM employees ORDER BY salary DESC;

-- Lowest salary first
SELECT first_name, salary FROM employees ORDER BY salary ASC;

-- ============================================
-- 9. ORDER BY: NULL VALUES
-- ============================================
-- In MySQL, NULL values are sorted first in ASC, last in DESC
SELECT first_name, email FROM employees ORDER BY email ASC;
-- NULLs appear first

SELECT first_name, email FROM employees ORDER BY email DESC;
-- NULLs appear last

-- ============================================
-- 10. ORDER BY: WITH WHERE CLAUSE
-- ============================================
-- Filter first, then sort
SELECT first_name, salary, department FROM employees
WHERE salary > 65000
ORDER BY salary DESC;

-- Get IT department employees, sorted by name
SELECT first_name, last_name, salary FROM employees
WHERE department = 'IT'
ORDER BY first_name ASC;

-- ============================================
-- 11. ORDER BY: LIMIT for Top/Bottom Results
-- ============================================
-- Top 5 highest paid employees
SELECT first_name, salary FROM employees
ORDER BY salary DESC
LIMIT 5;

-- Top 3 employees by hire date (newest)
SELECT first_name, hire_date FROM employees
ORDER BY hire_date DESC
LIMIT 3;

-- Lowest 3 paid employees
SELECT first_name, salary FROM employees
ORDER BY salary ASC
LIMIT 3;

-- ============================================
-- 12. ORDER BY: OFFSET for Pagination
-- ============================================
-- Skip first 2 rows, get next 3 rows
SELECT first_name, salary FROM employees
ORDER BY salary DESC
LIMIT 3 OFFSET 2;

-- Alternative syntax: LIMIT offset, count
SELECT first_name, salary FROM employees
ORDER BY salary DESC
LIMIT 2, 3;   -- Skip 2, get 3

-- ============================================
-- 13. ORDER BY: CASE for Custom Sorting
-- ============================================
-- Sort by custom priority (Sales first, then IT, then HR)
SELECT first_name, department FROM employees
ORDER BY CASE 
    WHEN department = 'Sales' THEN 1
    WHEN department = 'IT' THEN 2
    WHEN department = 'HR' THEN 3
    ELSE 4
END;

-- ============================================
-- 14. ORDER BY: Mathematical Expressions
-- ============================================
-- Sort by absolute difference from average salary
SELECT first_name, salary FROM employees
ORDER BY ABS(salary - (SELECT AVG(salary) FROM employees)) ASC;

-- Sort by calculated bonus amount
SELECT first_name, salary,
       salary * 0.1 AS bonus_10_percent
FROM employees
ORDER BY salary * 0.1 DESC;

-- ============================================
-- 15. PRACTICAL EXAMPLES
-- ============================================

-- Example 1: Employee Salary Report
SELECT 
    first_name,
    department,
    salary,
    salary * 12 AS annual_salary
FROM employees
ORDER BY department ASC, salary DESC;

-- Example 2: Hiring Timeline
SELECT 
    first_name,
    hire_date,
    YEAR(CURDATE()) - YEAR(hire_date) AS years_employed
FROM employees
ORDER BY hire_date ASC;

-- Example 3: Performance Ranking
SELECT 
    first_name,
    salary,
    ROW_NUMBER() OVER (ORDER BY salary DESC) AS salary_rank
FROM employees;

-- Example 4: Multi-level Sort
SELECT 
    first_name,
    department,
    salary,
    email
FROM employees
WHERE salary > 60000
ORDER BY department ASC, salary DESC, first_name ASC;

-- ============================================
-- 16. ORDER BY: Execution and Performance
-- ============================================
-- SQL execution order:
-- 1. FROM clause
-- 2. WHERE clause
-- 3. SELECT clause
-- 4. ORDER BY clause  <-- Applied last
-- 5. LIMIT clause

-- Therefore:
-- - Can't use WHERE on aliased columns
-- - Can use ORDER BY on aliased columns
-- - ORDER BY happens AFTER SELECT

-- ============================================
-- 17. BEST PRACTICES
-- ============================================
-- - Always specify ASC or DESC explicitly for clarity
-- - Use column names rather than positions (more maintainable)
-- - Limit large ORDER BY operations for performance
-- - Create indexes on frequently ordered columns
-- - Use ORDER BY with LIMIT for \"Top N\" queries
-- - Consider NULL behavior when sorting
