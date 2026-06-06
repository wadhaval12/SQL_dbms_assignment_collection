-- ============================================
-- Chapter 1: Basic Query Components
-- 02. The Where Clause
-- ============================================
-- The WHERE clause filters rows based on conditions.
-- Only rows that satisfy the condition are returned.

USE company;

-- ============================================
-- 1. COMPARISON PREDICATES
-- ============================================
-- Equal to
SELECT * FROM employees WHERE department = 'Sales';

-- Not equal to
SELECT * FROM employees WHERE department != 'IT';
-- Alternative: WHERE department <> 'IT';

-- Greater than
SELECT * FROM employees WHERE salary > 70000;

-- Less than
SELECT * FROM employees WHERE salary < 70000;

-- Greater than or equal
SELECT * FROM employees WHERE salary >= 70000;

-- Less than or equal
SELECT * FROM employees WHERE salary <= 70000;

-- ============================================
-- 2. LOGICAL CONNECTIVES: AND
-- ============================================
-- All conditions must be true (AND)
SELECT * FROM employees
WHERE salary > 70000 AND department = 'Sales';

SELECT * FROM employees
WHERE salary > 60000 AND salary < 80000;

SELECT * FROM employees
WHERE department = 'IT' AND salary >= 70000;

-- ============================================
-- 3. LOGICAL CONNECTIVES: OR
-- ============================================
-- At least one condition must be true (OR)
SELECT * FROM employees
WHERE department = 'Sales' OR department = 'IT';

SELECT * FROM employees
WHERE salary < 60000 OR salary > 80000;

SELECT * FROM employees
WHERE first_name = 'John' OR first_name = 'Jane';

-- ============================================
-- 4. LOGICAL CONNECTIVES: NOT
-- ============================================
-- Negate a condition (NOT)
SELECT * FROM employees
WHERE NOT department = 'HR';

SELECT * FROM employees
WHERE NOT (salary < 70000);   -- salary >= 70000

SELECT * FROM employees
WHERE NOT (department = 'IT' AND salary > 75000);

-- ============================================
-- 5. COMBINING AND, OR, NOT (with Parentheses)
-- ============================================
-- (A AND B) OR C
SELECT * FROM employees
WHERE (department = 'Sales' AND salary > 70000) 
   OR (department = 'IT' AND salary > 75000);

-- A AND (B OR C)
SELECT * FROM employees
WHERE salary > 70000 AND (department = 'IT' OR department = 'HR');

-- NOT (A AND B)
SELECT * FROM employees
WHERE NOT (department = 'Sales' AND salary < 70000);

-- ============================================
-- 6. BETWEEN: Range Filter
-- ============================================
-- Inclusive range (salary between 60000 and 80000)
SELECT * FROM employees
WHERE salary BETWEEN 60000 AND 80000;

-- Outside range (using NOT BETWEEN)
SELECT * FROM employees
WHERE salary NOT BETWEEN 60000 AND 80000;

-- Date range
SELECT * FROM employees
WHERE hire_date BETWEEN '2022-01-01' AND '2023-06-30';

-- ============================================
-- 7. IN: Set Membership
-- ============================================
-- Match any value in the list
SELECT * FROM employees
WHERE department IN ('Sales', 'IT', 'HR');

-- Not in any value
SELECT * FROM employees
WHERE department NOT IN ('Sales', 'IT');

-- IN with numbers
SELECT * FROM employees
WHERE emp_id IN (1, 3, 5);

-- ============================================
-- 8. LIKE: Pattern Matching
-- ============================================
-- '%' wildcard: zero or more characters
-- '_' wildcard: exactly one character

-- Starts with 'J'
SELECT * FROM employees
WHERE first_name LIKE 'J%';

-- Ends with 'n'
SELECT * FROM employees
WHERE last_name LIKE '%n';

-- Contains 'oh'
SELECT * FROM employees
WHERE first_name LIKE '%oh%';

-- Single character wildcard (e.g., B_b matches 'Bob')
SELECT * FROM employees
WHERE first_name LIKE 'B_b';

-- Case insensitive (LIKE is case-insensitive in MySQL by default)
SELECT * FROM employees
WHERE first_name LIKE 'john';  -- Matches 'John'

-- ============================================
-- 9. IS NULL AND IS NOT NULL
-- ============================================
-- Check for NULL values
SELECT * FROM employees
WHERE email IS NULL;

-- Check for non-NULL values
SELECT * FROM employees
WHERE email IS NOT NULL;

-- Combining with other conditions
SELECT * FROM employees
WHERE department IS NOT NULL AND salary > 70000;

-- ============================================
-- 10. COMPLEX WHERE CLAUSE EXAMPLES
-- ============================================
-- Find all employees in Sales or IT with salary > 65000
SELECT * FROM employees
WHERE (department = 'Sales' OR department = 'IT')
  AND salary > 65000;

-- Find employees hired after 2023-01-01 in non-HR departments
SELECT * FROM employees
WHERE hire_date > '2023-01-01'
  AND department != 'HR';

-- Find employees not in IT or Sales earning between 60k-80k
SELECT * FROM employees
WHERE department NOT IN ('IT', 'Sales')
  AND salary BETWEEN 60000 AND 80000;

-- Find employees whose first name starts with 'J' and salary > 75000
SELECT * FROM employees
WHERE first_name LIKE 'J%'
  AND salary > 75000;

-- ============================================
-- 11. OPERATOR PRECEDENCE
-- ============================================
-- MySQL evaluates: NOT > AND > OR
-- To avoid confusion, use parentheses explicitly

-- Ambiguous (should use parentheses):
-- SELECT * FROM employees WHERE department = 'Sales' OR department = 'IT' AND salary > 70000;

-- Clear version (with parentheses):
SELECT * FROM employees
WHERE department = 'Sales' 
   OR (department = 'IT' AND salary > 70000);
