-- ============================================
-- Chapter 1: Data Definition Language (DDL)
-- 01. Create Table Construct
-- ============================================
-- CREATE TABLE is used to define the schema for a table, specifying:
-- - Column names and data types
-- - Constraints (Primary Key, Unique, Not Null, Check, Default)
-- - Indexes and relationships

-- Step 1: Create a database to work with
CREATE DATABASE IF NOT EXISTS company;
USE company;

-- ============================================
-- BASIC CREATE TABLE SYNTAX
-- ============================================
CREATE TABLE employees (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    hire_date DATE,
    salary DECIMAL(10,2) DEFAULT 50000
);

-- ============================================
-- EXAMPLE: Products Table
-- ============================================
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- EXAMPLE: Customers Table with Constraints
-- ============================================
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20),
    address VARCHAR(255),
    city VARCHAR(50),
    country VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- EXAMPLE: Orders Table with Foreign Key
-- ============================================
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10,2),
    status VARCHAR(20) DEFAULT 'Pending',
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- ============================================
-- DATA TYPES USED IN CREATE TABLE
-- ============================================
-- NUMERIC:
--   INT: 4-byte integer (-2,147,483,648 to 2,147,483,647)
--   TINYINT: 1-byte integer (0-255 or -128-127)
--   BIGINT: 8-byte integer
--   DECIMAL(M,D): Fixed-point, M=total digits, D=decimal places
--   FLOAT, DOUBLE: Approximate floating-point

-- STRING:
--   VARCHAR(N): Variable-length string (up to 65,535 chars)
--   CHAR(N): Fixed-length string (up to 255 chars)
--   TEXT: Large text (up to 65,535 chars)
--   LONGTEXT: Very large text (up to 4GB)
--   ENUM: One value from predefined list

-- DATE/TIME:
--   DATE: Format YYYY-MM-DD
--   TIME: Format HH:MM:SS
--   DATETIME: Format YYYY-MM-DD HH:MM:SS
--   TIMESTAMP: DATETIME with automatic update
--   YEAR: 4-digit year

-- ============================================
-- VERIFY TABLE STRUCTURE
-- ============================================
DESCRIBE employees;
-- Or use: SHOW COLUMNS FROM employees;

-- See all created tables
SHOW TABLES;
