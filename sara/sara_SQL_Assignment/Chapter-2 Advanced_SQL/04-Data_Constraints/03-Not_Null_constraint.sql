-- ============================================
-- Chapter 2: Advanced SQL\n-- 04. Data Constraints
-- 03. NOT NULL Constraint
-- ============================================
-- NOT NULL ensures a column always has a value

USE company;

-- ============================================
-- 1. NOT NULL: In CREATE TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS employees (
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,      -- Required
    last_name VARCHAR(50) NOT NULL,       -- Required
    email VARCHAR(100),                   -- Optional (NULL allowed)
    salary DECIMAL(10,2) NOT NULL,        -- Required
    department VARCHAR(50) NOT NULL       -- Required
);

-- ============================================
-- 2. INSERT: Values for NOT NULL Columns
-- ============================================
-- Must provide values for NOT NULL columns
INSERT INTO employees (emp_id, first_name, last_name, salary, department)
VALUES (1, 'Alice', 'Smith', 90000, 'Management');

-- Email is optional - can omit
INSERT INTO employees (emp_id, first_name, last_name, salary, department)
VALUES (2, 'Bob', 'Johnson', 75000, 'Sales');

-- Providing email is also fine
INSERT INTO employees (emp_id, first_name, last_name, email, salary, department)
VALUES (3, 'Charlie', 'Brown', 'charlie@company.com', 70000, 'IT');

-- ============================================
-- 3. VIOLATION: NULL in NOT NULL Column
-- ============================================
-- This will fail - first_name cannot be NULL
-- INSERT INTO employees (emp_id, first_name, last_name, salary, department)
-- VALUES (4, NULL, 'Davis', 65000, 'HR');
-- ERROR: Column 'first_name' cannot be null

-- ============================================
-- 4. UPDATE: Setting NOT NULL to NULL
-- ============================================
-- This will fail
-- UPDATE employees SET salary = NULL WHERE emp_id = 1;
-- ERROR: Column 'salary' cannot be null

-- Valid update
UPDATE employees SET salary = 95000 WHERE emp_id = 1;

-- ============================================
-- 5. DEFAULT: With NOT NULL
-- ============================================
CREATE TABLE IF NOT EXISTS products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL DEFAULT 'Uncategorized',
    price DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    in_stock TINYINT NOT NULL DEFAULT 1
);

-- Insert using defaults for some columns
INSERT INTO products (product_name)
VALUES ('Laptop');  -- category='Uncategorized', price=0.00, in_stock=1

-- Override defaults
INSERT INTO products (product_name, category, price, in_stock)
VALUES ('Phone', 'Electronics', 799.99, 1);

-- ============================================
-- 6. ADD NOT NULL TO EXISTING COLUMN
-- ============================================
CREATE TABLE IF NOT EXISTS temp_users (
    user_id INT,
    username VARCHAR(50),
    email VARCHAR(100)
);

-- Add NOT NULL constraint (column must be empty or have defaults)
ALTER TABLE temp_users
MODIFY COLUMN username VARCHAR(50) NOT NULL;

-- ============================================
-- 7. DROP NOT NULL CONSTRAINT
-- ============================================
ALTER TABLE temp_users
MODIFY COLUMN email VARCHAR(100) NULL;  -- Now allows NULL

-- ============================================
-- 8. CHECK NOT NULL with IS NULL / IS NOT NULL
-- ============================================
-- Find rows with NULL values
SELECT * FROM employees WHERE email IS NULL;

-- Find rows without NULL
SELECT * FROM employees WHERE email IS NOT NULL;

-- Useful in queries
SELECT first_name, email FROM employees
WHERE email IS NOT NULL;

-- ============================================
-- 9. COALESCE WITH NOT NULL FIELDS
-- ============================================
-- Handle NULL values in output
SELECT 
    first_name,
    COALESCE(email, 'No email provided') AS email_display
FROM employees;

-- But first_name and salary will never be NULL
SELECT 
    first_name,
    salary,
    COALESCE(email, 'N/A') AS email
FROM employees;

-- ============================================
-- 10. COUNT WITH NOT NULL
-- ============================================
-- Count rows (including those with NULL in optional columns)
SELECT COUNT(*) AS total_employees FROM employees;

-- Count non-NULL emails
SELECT COUNT(email) AS employees_with_email FROM employees;

-- Required fields will always be counted
SELECT COUNT(first_name) AS total_names FROM employees;

-- ============================================
-- 11. NOT NULL IN WHERE CLAUSE
-- ============================================
-- Filter by NOT NULL values
SELECT * FROM employees
WHERE email IS NOT NULL AND salary > 70000;

-- ============================================
-- 12. PRACTICAL EXAMPLES
-- ============================================

-- Example 1: User Registration Table
CREATE TABLE IF NOT EXISTS user_accounts (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20),                    -- Optional
    registration_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    last_login TIMESTAMP                  -- Optional, NULL until first login
);

-- Example 2: Order System
CREATE TABLE IF NOT EXISTS orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    delivery_date DATE,                   -- Optional, NULL until delivered
    total_amount DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'Pending',
    notes TEXT                            -- Optional
);

-- Example 3: Inventory Management
CREATE TABLE IF NOT EXISTS inventory (
    item_id INT PRIMARY KEY AUTO_INCREMENT,
    item_name VARCHAR(100) NOT NULL,
    quantity_on_hand INT NOT NULL DEFAULT 0,
    quantity_reserved INT NOT NULL DEFAULT 0,
    last_restock_date DATE,               -- Optional
    warehouse_location VARCHAR(50) NOT NULL
);

-- ============================================
-- 13. WHEN TO USE NOT NULL
-- ============================================
-- Use NOT NULL when:
-- - Field is essential (name, ID, etc.)
-- - Field is part of a relationship (foreign key)
-- - Field is used in calculations or logic

-- Allow NULL when:
-- - Field is truly optional (middle name, phone)
-- - Value might not be known initially
-- - Field can be filled in later

-- ============================================
-- 14. DATA QUALITY
-- ============================================
-- NOT NULL helps enforce data quality
-- Prevents incomplete or invalid records
-- Makes queries more predictable
-- Reduces need for NULL checks in code

-- Report on data completeness
SELECT 
    COUNT(*) AS total,
    COUNT(email) AS with_email,
    COUNT(*) - COUNT(email) AS missing_email
FROM employees;

-- ============================================
-- 15. IMPACT ON JOINS
-- ============================================
-- NOT NULL in foreign keys ensures referential integrity
CREATE TABLE IF NOT EXISTS employee_roles (
    emp_id INT NOT NULL,                  -- Cannot be NULL
    role_id INT NOT NULL,                 -- Cannot be NULL
    assigned_date DATE,
    PRIMARY KEY (emp_id, role_id),
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);
