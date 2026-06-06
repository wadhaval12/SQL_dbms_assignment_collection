-- ============================================
-- Chapter 2: Advanced SQL
-- 04. Data Constraints
-- 04. UNIQUE and CHECK Constraints
-- ============================================

USE company;

-- ============================================
-- 1. UNIQUE: Single Column
-- ============================================
CREATE TABLE IF NOT EXISTS employees (
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE,           -- No duplicate emails
    employee_code VARCHAR(20) UNIQUE     -- No duplicate codes
);

-- ============================================
-- 2. UNIQUE: Insert Valid Data
-- ============================================
INSERT INTO employees VALUES
(1, 'Alice', 'Smith', 'alice@company.com', 'EMP001'),
(2, 'Bob', 'Johnson', 'bob@company.com', 'EMP002');

-- Duplicate email fails
-- INSERT INTO employees VALUES
-- (3, 'Charlie', 'Brown', 'alice@company.com', 'EMP003');
-- ERROR: Duplicate entry 'alice@company.com' for key 'email'

-- ============================================
-- 3. UNIQUE: NULL Handling
-- ============================================
-- MySQL allows multiple NULLs in UNIQUE columns
INSERT INTO employees (emp_id, first_name, last_name, employee_code)
VALUES (3, 'Charlie', 'Brown', 'EMP003');  -- email is NULL

INSERT INTO employees (emp_id, first_name, last_name, employee_code)
VALUES (4, 'Diana', 'Davis', 'EMP004');    -- Another NULL email

-- Both succeed - multiple NULLs allowed

-- ============================================
-- 4. UNIQUE: Multiple Columns (Composite)
-- ============================================
CREATE TABLE IF NOT EXISTS user_profiles (
    user_id INT PRIMARY KEY,
    username VARCHAR(50),
    email VARCHAR(100),
    UNIQUE KEY unique_credentials (username, email)  -- Combination must be unique
);

-- ============================================
-- 5. UNIQUE: Named Constraint
-- ============================================
CREATE TABLE IF NOT EXISTS products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    sku VARCHAR(50),
    CONSTRAINT unique_sku UNIQUE (sku)   -- Named constraint
);

-- ============================================
-- 6. UNIQUE: vs PRIMARY KEY
-- ============================================
-- PRIMARY KEY: One only, cannot be NULL
-- UNIQUE: Multiple allowed, can have NULLs

CREATE TABLE IF NOT EXISTS accounts (
    account_id INT PRIMARY KEY,          -- One primary key
    email VARCHAR(100) UNIQUE,           -- One unique constraint
    username VARCHAR(50) UNIQUE,         -- Another unique constraint
    phone VARCHAR(20)                    -- Can have duplicates/NULLs
);

-- ============================================
-- 7. CHECK: Column Value Validation
-- ============================================
CREATE TABLE IF NOT EXISTS employees_check (
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    salary DECIMAL(10,2) CHECK (salary > 0),      -- Salary must be positive
    age INT CHECK (age >= 18),                     -- Age must be 18+
    status VARCHAR(20) CHECK (status IN ('Active', 'Inactive', 'On Leave'))
);

-- ============================================
-- 8. CHECK: Valid Inserts
-- ============================================
INSERT INTO employees_check VALUES
(1, 'Alice', 50000, 25, 'Active');

-- Negative salary fails
-- INSERT INTO employees_check VALUES
-- (2, 'Bob', -50000, 30, 'Active');
-- ERROR: Check constraint violated

-- Age < 18 fails
-- INSERT INTO employees_check VALUES
-- (3, 'Charlie', 45000, 16, 'Active');
-- ERROR: Check constraint violated

-- ============================================
-- 9. CHECK: Named Constraint
-- ============================================
CREATE TABLE IF NOT EXISTS orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    expected_delivery_date DATE,
    total_amount DECIMAL(10,2),
    CONSTRAINT check_amount CHECK (total_amount >= 0),
    CONSTRAINT check_dates CHECK (expected_delivery_date >= order_date)
);

-- ============================================
-- 10. CHECK: Multiple Conditions
-- ============================================
CREATE TABLE IF NOT EXISTS products_check (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10,2),
    stock INT,
    discount_percent INT,
    CONSTRAINT chk_price_stock CHECK (price > 0 AND stock >= 0),
    CONSTRAINT chk_discount CHECK (discount_percent >= 0 AND discount_percent <= 100)
);

-- ============================================
-- 11. ADD CONSTRAINT TO EXISTING TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS temp_employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    salary DECIMAL(10,2)
);

-- Add UNIQUE constraint
ALTER TABLE temp_employees
ADD UNIQUE (name);

-- Add CHECK constraint
ALTER TABLE temp_employees
ADD CONSTRAINT chk_salary CHECK (salary > 0);

-- ============================================
-- 12. DROP CONSTRAINT
-- ============================================
-- Drop unique constraint
ALTER TABLE temp_employees
DROP INDEX name;

-- Drop check constraint
ALTER TABLE temp_employees
DROP CHECK chk_salary;

-- ============================================
-- 13. PRACTICAL EXAMPLES
-- ============================================

-- Example 1: User Registration with Validation
CREATE TABLE IF NOT EXISTS user_validation (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    age INT CHECK (age >= 13),
    country VARCHAR(50) NOT NULL,
    status VARCHAR(20) DEFAULT 'Active' CHECK (status IN ('Active', 'Inactive', 'Suspended')),
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Example 2: Product Inventory with Checks
CREATE TABLE IF NOT EXISTS product_inventory (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL UNIQUE,
    category VARCHAR(50),
    unit_price DECIMAL(10,2) CHECK (unit_price > 0),
    stock_quantity INT CHECK (stock_quantity >= 0),
    reorder_level INT CHECK (reorder_level >= 0),
    discount_rate DECIMAL(5,2) CHECK (discount_rate >= 0 AND discount_rate <= 100)
);

-- Example 3: Banking with Constraints
CREATE TABLE IF NOT EXISTS bank_accounts (
    account_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    account_number VARCHAR(20) NOT NULL UNIQUE,
    account_type VARCHAR(20) CHECK (account_type IN ('Savings', 'Checking', 'Money Market')),
    balance DECIMAL(12,2) CHECK (balance >= 0),
    interest_rate DECIMAL(5,2) CHECK (interest_rate >= 0),
    is_active TINYINT DEFAULT 1 CHECK (is_active IN (0, 1)),
    created_date DATE NOT NULL
);

-- ============================================
-- 14. CHECKING CONSTRAINT VIOLATIONS
-- ============================================
-- View constraints on a table
SELECT CONSTRAINT_NAME, TABLE_NAME, CONSTRAINT_TYPE
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_NAME = 'employees';

-- ============================================
-- 15. ENABLE/DISABLE CONSTRAINTS
-- ============================================
-- Temporarily disable constraint checks
-- SET FOREIGN_KEY_CHECKS=0;  -- For foreign keys only
-- (data operations)
-- SET FOREIGN_KEY_CHECKS=1;

-- Note: CHECK constraints cannot be disabled in MySQL

-- ============================================
-- 16. BEST PRACTICES
-- ============================================
-- - Use UNIQUE for columns that must not repeat (email, username, SSN)
-- - Use CHECK for domain restrictions (age, price, status)
-- - Combine multiple constraints for data integrity
-- - Make constraints meaningful and enforceable
-- - Document constraints for data quality
-- - Test constraints before deploying
