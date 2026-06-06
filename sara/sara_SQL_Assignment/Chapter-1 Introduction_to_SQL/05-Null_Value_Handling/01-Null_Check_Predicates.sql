-- ============================================
-- Chapter 1: Null Value Handling
-- 01. Null-Check Predicate Queries
-- ============================================
-- NULL is a special value representing \"unknown\" or \"missing\" data.
-- Use IS NULL and IS NOT NULL to check for NULL values.

USE company;

-- Setup
CREATE TABLE IF NOT EXISTS employees (
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(20),
    salary DECIMAL(10,2),
    manager_id INT,
    department VARCHAR(50)
);

INSERT INTO employees VALUES
(1, 'Alice', 'Smith', 'alice@company.com', '555-0001', 90000, NULL, 'Management'),
(2, 'Bob', 'Johnson', 'bob@company.com', NULL, 75000, 1, 'Sales'),
(3, 'Charlie', 'Brown', NULL, '555-0003', 70000, 1, 'Sales'),
(4, 'Diana', 'Davis', 'diana@company.com', '555-0004', 65000, 2, 'HR'),
(5, 'Eve', 'Wilson', NULL, NULL, 62000, 2, 'IT');

-- ============================================
-- 1. IS NULL: Find Records with NULL Values
-- ============================================
-- Find employees with NULL email
SELECT * FROM employees WHERE email IS NULL;

-- Find employees with NULL phone
SELECT first_name, last_name, phone FROM employees WHERE phone IS NULL;

-- Find employees with no manager (NULL manager_id)
SELECT first_name, last_name FROM employees WHERE manager_id IS NULL;

-- ============================================
-- 2. IS NOT NULL: Find Records without NULL
-- ============================================
-- Find employees with valid email
SELECT first_name, email FROM employees WHERE email IS NOT NULL;

-- Find employees with phone numbers
SELECT first_name, phone FROM employees WHERE phone IS NOT NULL;

-- Find employees with a manager
SELECT first_name, manager_id FROM employees WHERE manager_id IS NOT NULL;

-- ============================================
-- 3. MULTIPLE NULL CONDITIONS
-- ============================================
-- Find employees with both email AND phone
SELECT first_name FROM employees
WHERE email IS NOT NULL AND phone IS NOT NULL;

-- Find employees with either NULL email OR NULL phone
SELECT first_name FROM employees
WHERE email IS NULL OR phone IS NULL;

-- Find employees with no email and no phone
SELECT first_name FROM employees
WHERE email IS NULL AND phone IS NULL;

-- ============================================
-- 4. NOT NULL IN WHERE CLAUSE
-- ============================================
-- Exclude NULL values from results
SELECT first_name, department FROM employees
WHERE department IS NOT NULL
ORDER BY department;

-- Find employees with salary and department info
SELECT first_name, salary, department FROM employees
WHERE salary IS NOT NULL AND department IS NOT NULL;

-- ============================================
-- 5. NULL vs EMPTY STRING
-- ============================================
-- Note: NULL is different from empty string ''

-- Check for actual NULL
SELECT * FROM employees WHERE email IS NULL;      -- NULL values

-- Check for empty string (if exists)
-- SELECT * FROM employees WHERE email = '';       -- Empty strings

-- ============================================
-- 6. COALESCE: Handle NULL Values
-- ============================================
-- Replace NULL with alternative value
SELECT 
    first_name,
    COALESCE(email, 'No email') AS email,
    COALESCE(phone, 'No phone') AS phone
FROM employees;

-- Use first non-NULL value from multiple columns
SELECT 
    first_name,
    COALESCE(phone, email, 'No contact') AS contact_info
FROM employees;

-- ============================================
-- 7. IFNULL: Alternative to COALESCE
-- ============================================
-- IFNULL works with exactly 2 arguments
SELECT 
    first_name,
    IFNULL(email, 'N/A') AS email
FROM employees;

-- ============================================
-- 8. IF FUNCTION: Conditional NULL Handling
-- ============================================
-- Use IF to handle NULL differently
SELECT 
    first_name,
    IF(email IS NULL, 'Missing', email) AS email_status,
    IF(phone IS NULL, 'Not Provided', phone) AS phone_status
FROM employees;

-- ============================================
-- 9. NULL IN AGGREGATES
-- ============================================
-- COUNT ignores NULL values (except COUNT(*))
SELECT 
    COUNT(*) AS total_employees,
    COUNT(email) AS employees_with_email,
    COUNT(phone) AS employees_with_phone
FROM employees;

-- Find average salary (NULL values ignored)
SELECT AVG(salary) AS average_salary FROM employees;

-- ============================================
-- 10. NULL SORTING
-- ============================================
-- In MySQL, NULL sorts first in ASC, last in DESC

-- Sort by email (NULLs appear first)
SELECT first_name, email FROM employees ORDER BY email ASC;

-- Sort by email descending (NULLs appear last)
SELECT first_name, email FROM employees ORDER BY email DESC;

-- Sort with NULLs last (ASC)
SELECT first_name, email FROM employees
ORDER BY email IS NULL, email ASC;

-- ============================================
-- 11. NULL IN JOINS
-- ============================================
-- Be careful with NULL in join conditions

CREATE TABLE IF NOT EXISTS departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

INSERT INTO departments VALUES
(1, 'Management'),
(2, 'Sales'),
(3, 'HR'),
(4, 'IT');

-- Find employees with department info
SELECT e.first_name, d.dept_name
FROM employees e
LEFT JOIN departments d ON e.department = d.dept_name
WHERE e.department IS NOT NULL;

-- ============================================
-- 12. NULL IN SUBQUERIES
-- ============================================
-- Find employees without a manager
SELECT first_name FROM employees
WHERE manager_id IS NULL;

-- Find employees who are NOT managers (don't appear in manager_id)
SELECT first_name FROM employees
WHERE emp_id NOT IN (SELECT manager_id FROM employees WHERE manager_id IS NOT NULL);

-- ============================================
-- 13. PRACTICAL EXAMPLES
-- ============================================

-- Example 1: Data Quality Report
SELECT 
    'Email' AS field,
    COUNT(*) AS total_records,
    COUNT(email) AS records_with_value,
    COUNT(*) - COUNT(email) AS null_count
FROM employees
UNION ALL
SELECT 
    'Phone' AS field,
    COUNT(*) AS total_records,
    COUNT(phone) AS records_with_value,
    COUNT(*) - COUNT(phone) AS null_count
FROM employees;

-- Example 2: Complete Contact Info Report
SELECT 
    first_name,
    COALESCE(email, 'No Email') AS email,
    COALESCE(phone, 'No Phone') AS phone,
    IF(email IS NOT NULL OR phone IS NOT NULL, 'Has Contact', 'No Contact Info') AS contact_status
FROM employees;

-- Example 3: Hierarchical Display
SELECT 
    first_name,
    COALESCE(manager_id::text, 'Top Level') AS reports_to
FROM employees;

-- ============================================
-- 14. IMPORTANT NOTES ON NULL
-- ============================================
-- - NULL is not equal to NULL (NULL = NULL returns UNKNOWN)
-- - NULL values are typically excluded from aggregate functions
-- - Use IS NULL and IS NOT NULL for NULL checks
-- - Never use = NULL or != NULL
-- - DISTINCT treats NULL as a value (NULL = NULL for DISTINCT)
-- - NULL behavior differs slightly across databases
