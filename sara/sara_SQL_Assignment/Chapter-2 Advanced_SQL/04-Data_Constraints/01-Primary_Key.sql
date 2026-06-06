-- ============================================
-- Chapter 2: Advanced SQL
-- 04. Data Constraints
-- 01. Primary Key Constraint
-- ============================================
-- PRIMARY KEY uniquely identifies each row and prevents NULL values

USE company;

-- ============================================
-- 1. PRIMARY KEY: Single Column (Create Table)
-- ============================================
CREATE TABLE IF NOT EXISTS employees (
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);

-- Alternative syntax
CREATE TABLE IF NOT EXISTS departments (
    dept_id INT PRIMARY KEY AUTO_INCREMENT,
    dept_name VARCHAR(50)
);

-- ============================================
-- 2. PRIMARY KEY: Multiple Columns (Composite)
-- ============================================
-- Create table with composite primary key
CREATE TABLE IF NOT EXISTS employee_skills (
    emp_id INT,
    skill_id INT,
    proficiency_level INT,
    PRIMARY KEY (emp_id, skill_id)
);

-- ============================================
-- 3. PRIMARY KEY: Named Constraint
-- ============================================
CREATE TABLE IF NOT EXISTS projects (
    project_id INT,
    project_name VARCHAR(100),
    CONSTRAINT pk_projects PRIMARY KEY (project_id)
);

-- ============================================
-- 4. PRIMARY KEY: AUTO_INCREMENT
-- ============================================
-- Auto-generate primary key values
CREATE TABLE IF NOT EXISTS customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(50),
    email VARCHAR(100)
);

-- Insert without specifying customer_id
INSERT INTO customers (customer_name, email)
VALUES ('Alice', 'alice@example.com');  -- customer_id auto-generated

INSERT INTO customers (customer_name, email)
VALUES ('Bob', 'bob@example.com');      -- customer_id auto-incremented

-- ============================================
-- 5. PRIMARY KEY: Adding to Existing Table
-- ============================================
CREATE TABLE IF NOT EXISTS temp_table (
    id INT,
    name VARCHAR(50)
);

-- Add primary key to existing table
ALTER TABLE temp_table
ADD PRIMARY KEY (id);

-- ============================================
-- 6. PRIMARY KEY: Composite with AUTO_INCREMENT
-- ============================================
-- First column auto-increments
CREATE TABLE IF NOT EXISTS orders (
    order_id INT AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    PRIMARY KEY (order_id)
);

-- ============================================
-- 7. PRIMARY KEY: Prevent Duplicates
-- ============================================
-- Try to insert duplicate primary key
INSERT INTO employees (emp_id, first_name, last_name)
VALUES (1, 'Alice', 'Smith');

-- This will fail (duplicate emp_id)
-- INSERT INTO employees (emp_id, first_name, last_name)
-- VALUES (1, 'Bob', 'Johnson');
-- ERROR: Duplicate entry '1' for key 'PRIMARY'

-- ============================================
-- 8. PRIMARY KEY: Prevent NULL
-- ============================================
-- Primary key doesn't allow NULL
-- INSERT INTO employees (emp_id, first_name, last_name)
-- VALUES (NULL, 'Charlie', 'Brown');
-- ERROR: Column 'emp_id' cannot be null

-- ============================================
-- 9. VIEW PRIMARY KEY INFORMATION
-- ============================================
-- See table structure and primary key
DESCRIBE employees;
-- Or:
SHOW COLUMNS FROM employees;

-- Show all keys
SHOW KEYS FROM employees;

-- ============================================
-- 10. PRIMARY KEY: Dropping
-- ============================================
-- Drop primary key from table
ALTER TABLE temp_table
DROP PRIMARY KEY;

-- ============================================
-- 11. PRACTICAL EXAMPLES
-- ============================================

-- Example 1: User Table with Primary Key
CREATE TABLE IF NOT EXISTS users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Example 2: Composite Primary Key (Student Enrollment)
CREATE TABLE IF NOT EXISTS enrollments (
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    enrollment_date DATE,
    PRIMARY KEY (student_id, course_id)
);

-- Example 3: Invoice Details with Composite Key
CREATE TABLE IF NOT EXISTS invoice_items (
    invoice_id INT NOT NULL,
    line_item_num INT NOT NULL,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),
    PRIMARY KEY (invoice_id, line_item_num)
);

-- ============================================
-- 12. AUTO_INCREMENT: Starting Value
-- ============================================
-- Start AUTO_INCREMENT from specific value
CREATE TABLE IF NOT EXISTS products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100)
) AUTO_INCREMENT=100;  -- Start from 100

-- ============================================
-- 13. AUTO_INCREMENT: Getting Last Insert ID
-- ============================================
-- In applications, retrieve last inserted ID
INSERT INTO customers (customer_name, email)
VALUES ('Charlie', 'charlie@example.com');

-- Get the ID of last inserted row
SELECT LAST_INSERT_ID();

-- ============================================
-- 14. PRIMARY KEY vs UNIQUE
-- ============================================
-- PRIMARY KEY: One only, cannot be NULL, indexes automatically
-- UNIQUE: Multiple allowed, can be NULL, indexes for speed

-- Create table showing difference
CREATE TABLE IF NOT EXISTS accounts (
    account_id INT PRIMARY KEY,           -- Primary key
    email VARCHAR(100) UNIQUE,            -- Unique but not primary
    username VARCHAR(50) UNIQUE           -- Another unique field
);

-- ============================================
-- 15. COMPOSITE KEY USAGE
-- ============================================
-- Composite keys are useful for junction tables
CREATE TABLE IF NOT EXISTS student_courses (
    student_id INT,
    course_id INT,
    grade CHAR(1),
    PRIMARY KEY (student_id, course_id)
);

-- Can insert same student with different courses
INSERT INTO student_courses VALUES (1, 101, 'A');
INSERT INTO student_courses VALUES (1, 102, 'B');  -- Same student, different course
INSERT INTO student_courses VALUES (2, 101, 'A');  -- Different student, same course

-- But cannot insert same combination twice
-- INSERT INTO student_courses VALUES (1, 101, 'C');  -- ERROR: Duplicate
