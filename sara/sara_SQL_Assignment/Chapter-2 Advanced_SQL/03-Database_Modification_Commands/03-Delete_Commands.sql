-- ============================================
-- Chapter 2: Advanced SQL
-- 03. Database Modification Commands (DML)
-- 03. Delete Commands
-- ============================================
-- DELETE removes rows from a table

USE company;

-- Create sample table
CREATE TABLE IF NOT EXISTS employees (
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    salary DECIMAL(10,2),
    department VARCHAR(50),
    hire_date DATE
);

INSERT IGNORE INTO employees VALUES
(1, 'Alice', 'Smith', 'alice@company.com', 90000, 'Management', '2021-01-15'),
(2, 'Bob', 'Johnson', 'bob@company.com', 75000, 'Sales', '2022-03-20'),
(3, 'Charlie', 'Brown', 'charlie@company.com', 70000, 'Sales', '2022-06-10'),
(4, 'Diana', 'Davis', 'diana@company.com', 65000, 'HR', '2023-02-01'),
(5, 'Eve', 'Wilson', 'eve@company.com', 62000, 'IT', '2023-05-12'),
(6, 'Frank', 'Miller', 'frank@company.com', 72000, 'IT', '2023-07-01');

-- ============================================
-- 1. DELETE: Single Row
-- ============================================
-- Delete specific employee
DELETE FROM employees
WHERE emp_id = 6;

-- ============================================
-- 2. DELETE: Multiple Rows by Condition
-- ============================================
-- Delete all employees from IT department
DELETE FROM employees
WHERE department = 'IT';

-- Delete employees with salary < 65000
DELETE FROM employees
WHERE salary < 65000;

-- ============================================
-- 3. DELETE: With AND Condition
-- ============================================
-- Delete employees in Sales with salary < 70000
DELETE FROM employees
WHERE department = 'Sales' AND salary < 70000;

-- ============================================
-- 4. DELETE: With OR Condition
-- ============================================
-- Delete employees from IT OR HR
DELETE FROM employees
WHERE department = 'IT' OR department = 'HR';

-- ============================================
-- 5. DELETE: With IN Clause
-- ============================================
-- Delete specific employees by ID
DELETE FROM employees
WHERE emp_id IN (1, 3, 5);

-- Delete employees from multiple departments
DELETE FROM employees
WHERE department IN ('Sales', 'Marketing');

-- ============================================
-- 6. DELETE: With LIKE
-- ============================================
-- Delete employees with name starting with 'A'
DELETE FROM employees
WHERE first_name LIKE 'A%';

-- Delete employees from companies with 'Inc' in email
DELETE FROM employees
WHERE email LIKE '%inc.com%';

-- ============================================
-- 7. DELETE: With Subquery
-- ============================================
-- Delete employees with below average salary
DELETE FROM employees
WHERE salary < (SELECT AVG(salary) FROM employees);

-- Delete employees not in a specific set
DELETE FROM employees
WHERE emp_id NOT IN (SELECT emp_id FROM high_performers);

-- ============================================
-- 8. DELETE: Using JOIN (MySQL Syntax)
-- ============================================
-- Delete employees from low-performing departments
CREATE TABLE IF NOT EXISTS departments (
    dept_name VARCHAR(50),
    performance_score INT
);

INSERT INTO departments VALUES
('Sales', 80),
('IT', 95),
('HR', 70);

DELETE e FROM employees e
JOIN departments d ON e.department = d.dept_name
WHERE d.performance_score < 75;

-- ============================================
-- 9. TRUNCATE: vs DELETE
-- ============================================
-- TRUNCATE: Removes ALL rows, faster, resets auto-increment
-- DELETE: Removes specific rows (or all), slower, keeps auto-increment

-- Delete all rows (slow)
DELETE FROM employees;

-- TRUNCATE all rows (fast)
TRUNCATE TABLE employees;

-- ============================================
-- 10. DELETE: Archive Before Delete
-- ============================================
-- Best practice: Archive data before deleting

-- Create archive table
CREATE TABLE IF NOT EXISTS employees_archive LIKE employees;

-- Move old employees to archive
INSERT INTO employees_archive
SELECT * FROM employees
WHERE YEAR(hire_date) < 2022;

-- Now safe to delete
DELETE FROM employees
WHERE YEAR(hire_date) < 2022;

-- ============================================
-- 11. DELETE: All Rows (Very Careful!)
-- ============================================
-- Delete ALL employees
-- DELETE FROM employees;  -- AVOID without WHERE!

-- Safe: Use TRUNCATE instead
-- TRUNCATE TABLE employees;

-- ============================================
-- 12. PRACTICAL EXAMPLES
-- ============================================

-- Example 1: Remove Test Data
DELETE FROM employees
WHERE email LIKE '%test%' OR email LIKE '%temp%';

-- Example 2: Remove Inactive Records
DELETE FROM employees
WHERE hire_date < DATE_SUB(CURDATE(), INTERVAL 3 YEAR);

-- Example 3: Cleanup NULL Records
DELETE FROM employees
WHERE email IS NULL AND phone IS NULL;

-- Example 4: Remove Duplicates (Keep Latest)
DELETE FROM employees
WHERE emp_id NOT IN (
    SELECT MAX(emp_id) FROM employees
    GROUP BY email
);

-- ============================================
-- 13. DELETE: Safety Practices
-- ============================================
-- Step 1: Preview what will be deleted
SELECT * FROM employees WHERE department = 'IT';

-- Step 2: Backup or archive
INSERT INTO employees_archive
SELECT * FROM employees WHERE department = 'IT';

-- Step 3: Delete
DELETE FROM employees WHERE department = 'IT';

-- Step 4: Verify
SELECT COUNT(*) FROM employees;

-- ============================================
-- 14. DELETE vs UPDATE
-- ============================================
-- DELETE: Remove rows completely
-- UPDATE: Keep rows but change values

-- Instead of deleting inactive employees, mark as inactive
UPDATE employees
SET status = 'Inactive'
WHERE YEAR(CURDATE()) - YEAR(hire_date) > 10;

-- ============================================
-- 15. UNDERSTANDING FOREIGN KEYS WITH DELETE
-- ============================================
-- If table has foreign key constraints, you might not be able to delete
-- Create example:
CREATE TABLE IF NOT EXISTS orders (
    order_id INT PRIMARY KEY,
    emp_id INT,
    amount DECIMAL(10,2),
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);

-- Try to delete employee with orders - may fail
-- DELETE FROM employees WHERE emp_id = 1;
-- ERROR: Cannot delete or update parent row (foreign key constraint)

-- Options:
-- 1. Delete related orders first
DELETE FROM orders WHERE emp_id = 1;
DELETE FROM employees WHERE emp_id = 1;

-- 2. Use CASCADE delete (defined at table creation)
-- 3. Disable constraint (use with caution)
-- SET FOREIGN_KEY_CHECKS=0;
-- DELETE FROM employees;
-- SET FOREIGN_KEY_CHECKS=1;

-- ============================================
-- 16. IMPORTANT REMINDERS
-- ============================================
-- - ALWAYS BACKUP before bulk deletes
-- - Use WHERE clause (NEVER delete without it unless using TRUNCATE)
-- - Test with SELECT first
-- - Consider archiving instead of deleting
-- - Be aware of foreign key constraints
-- - Use transactions for safety
-- - Remember: Deleted data is hard/impossible to recover
