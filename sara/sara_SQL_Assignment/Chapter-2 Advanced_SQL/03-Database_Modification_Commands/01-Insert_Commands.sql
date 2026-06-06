-- ============================================
-- Chapter 2: Advanced SQL
-- 03. Database Modification Commands (DML)
-- 01. Insert Commands
-- ============================================
-- INSERT adds new rows to a table

USE company;

-- Create sample table
CREATE TABLE IF NOT EXISTS employees (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    salary DECIMAL(10,2) DEFAULT 50000,
    department VARCHAR(50),
    hire_date DATE
);

-- ============================================
-- 1. INSERT: Single Row with All Columns
-- ============================================
INSERT INTO employees 
VALUES (1, 'Alice', 'Smith', 'alice@company.com', 90000, 'Management', '2021-01-15');

-- ============================================
-- 2. INSERT: Single Row with Specific Columns
-- ============================================
INSERT INTO employees (first_name, last_name, email, salary, department, hire_date)
VALUES ('Bob', 'Johnson', 'bob@company.com', 75000, 'Sales', '2022-03-20');

-- Using default values (salary will be 50000)
INSERT INTO employees (first_name, last_name, email, department)
VALUES ('Charlie', 'Brown', 'charlie@company.com', 'IT');

-- ============================================
-- 3. INSERT: Multiple Rows
-- ============================================
INSERT INTO employees (first_name, last_name, email, salary, department, hire_date) VALUES
('Diana', 'Davis', 'diana@company.com', 65000, 'HR', '2023-02-01'),
('Eve', 'Wilson', 'eve@company.com', 62000, 'IT', '2023-05-12'),
('Frank', 'Miller', 'frank@company.com', 72000, 'Sales', '2023-07-01');

-- ============================================
-- 4. INSERT WITH AUTO_INCREMENT
-- ============================================
-- Let the database auto-generate emp_id
INSERT INTO employees (first_name, last_name, email, salary, department, hire_date)
VALUES ('Grace', 'Taylor', 'grace@company.com', 68000, 'HR', '2023-08-15');

-- ============================================
-- 5. INSERT: NULL VALUES
-- ============================================
-- Some employees might not have email initially
INSERT INTO employees (first_name, last_name, salary, department)
VALUES ('Henry', 'Anderson', 71000, 'IT');

-- ============================================
-- 6. INSERT: Using SELECT (Copy Data)
-- ============================================
-- Copy employees from one table to another
CREATE TABLE IF NOT EXISTS employees_backup AS
SELECT * FROM employees WHERE 1=0;  -- Create structure only

-- Copy all employees
INSERT INTO employees_backup
SELECT * FROM employees;

-- Copy specific employees
INSERT INTO employees_backup
SELECT * FROM employees WHERE department = 'Sales';

-- ============================================
-- 7. INSERT: SELECT with WHERE
-- ============================================
-- Create a high earners table
CREATE TABLE IF NOT EXISTS high_earners (
    emp_id INT,
    name VARCHAR(100),
    salary DECIMAL(10,2)
);

INSERT INTO high_earners
SELECT emp_id, CONCAT(first_name, ' ', last_name), salary
FROM employees
WHERE salary > 70000;

-- ============================================
-- 8. INSERT: SELECT with JOIN
-- ============================================
-- Create employee-department table
CREATE TABLE IF NOT EXISTS emp_dept (
    emp_id INT,
    emp_name VARCHAR(100),
    dept_name VARCHAR(50)
);

INSERT INTO emp_dept
SELECT e.emp_id, CONCAT(e.first_name, ' ', e.last_name), e.department
FROM employees e;

-- ============================================
-- 9. INSERT: Conditional INSERT (IGNORE)
-- ============================================
-- Skip inserts that would violate UNIQUE constraint
INSERT IGNORE INTO employees (first_name, last_name, email, salary, department)
VALUES ('Bob', 'Johnson', 'bob@company.com', 80000, 'Finance');
-- This won't insert because email already exists

-- ============================================
-- 10. INSERT: Using DEFAULT VALUES
-- ============================================
-- Insert row with all defaults
INSERT INTO employees (first_name, last_name)
VALUES ('Iris', 'White');  -- Others use defaults

-- ============================================
-- 11. INSERT: Bulk Insert from File (Syntax)
-- ============================================
-- LOAD DATA LOCAL INFILE '/path/to/file.csv'
-- INTO TABLE employees
-- FIELDS TERMINATED BY ','
-- LINES TERMINATED BY '\n'
-- (first_name, last_name, email, salary, department, hire_date);

-- ============================================
-- 12. PRACTICAL EXAMPLES
-- ============================================

-- Example 1: Add new employees from application
INSERT INTO employees (first_name, last_name, email, salary, department, hire_date)
VALUES 
('Jack', 'Thompson', 'jack@company.com', 75000, 'Sales', CURDATE()),
('Karen', 'Martinez', 'karen@company.com', 70000, 'IT', CURDATE());

-- Example 2: Archive old records
CREATE TABLE IF NOT EXISTS archived_employees LIKE employees;

INSERT INTO archived_employees
SELECT * FROM employees
WHERE YEAR(hire_date) < 2023;

-- Example 3: Populate from another source
INSERT INTO employees (first_name, last_name, salary, department)
SELECT DISTINCT 
    name,
    'New Hire' AS last_name,
    0 AS salary,
    'Unassigned' AS department
FROM temp_applicants;

-- ============================================
-- 13. INSERT: Error Handling
-- ============================================
-- Without IGNORE, duplicate would cause error
-- INSERT INTO employees (first_name, last_name, email)
-- VALUES ('Bob', 'Johnson', 'bob@company.com');
-- ERROR: Duplicate entry

-- Use IGNORE to skip errors
INSERT IGNORE INTO employees (first_name, last_name, email)
VALUES 
('Bob', 'Johnson', 'bob@company.com'),  -- Skipped (duplicate)
('Laura', 'King', 'laura@company.com');  -- Inserted

-- ============================================
-- 14. INSERT: ON DUPLICATE KEY UPDATE
-- ============================================
-- Update if exists, insert if not
INSERT INTO employees (emp_id, first_name, last_name, email, salary)
VALUES (1, 'Alice', 'Smith', 'alice.smith@company.com', 95000)
ON DUPLICATE KEY UPDATE 
    email = 'alice.smith@company.com',
    salary = 95000;

-- ============================================
-- 15. VIEW RESULTS
-- ============================================
SELECT * FROM employees;
SELECT COUNT(*) AS total_employees FROM employees;
