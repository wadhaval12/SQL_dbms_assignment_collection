-- ============================================
-- Chapter 2: Advanced SQL
-- 04. Data Constraints
-- 02. Foreign Key Constraint
-- ============================================
-- FOREIGN KEY links a table to another table's primary key

USE company;

-- ============================================
-- 1. FOREIGN KEY: Basic Syntax
-- ============================================
-- Create parent table first
CREATE TABLE IF NOT EXISTS departments (
    dept_id INT PRIMARY KEY AUTO_INCREMENT,
    dept_name VARCHAR(50) NOT NULL
);

-- Create child table with foreign key
CREATE TABLE IF NOT EXISTS employees (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

-- ============================================
-- 2. FOREIGN KEY: Named Constraint
-- ============================================
CREATE TABLE IF NOT EXISTS projects (
    project_id INT PRIMARY KEY AUTO_INCREMENT,
    project_name VARCHAR(100),
    manager_id INT,
    CONSTRAINT fk_manager FOREIGN KEY (manager_id) REFERENCES employees(emp_id)
);

-- ============================================
-- 3. INSERT WITH FOREIGN KEY
-- ============================================
-- Must insert parent record first
INSERT INTO departments (dept_name) VALUES ('Sales');
INSERT INTO departments (dept_name) VALUES ('IT');
INSERT INTO departments (dept_name) VALUES ('HR');

-- Now insert employees with valid dept_id
INSERT INTO employees (first_name, last_name, dept_id)
VALUES ('Alice', 'Smith', 1);   -- dept_id 1 exists

INSERT INTO employees (first_name, last_name, dept_id)
VALUES ('Bob', 'Johnson', 2);   -- dept_id 2 exists

-- This will fail - dept_id doesn't exist
-- INSERT INTO employees (first_name, last_name, dept_id)
-- VALUES ('Charlie', 'Brown', 99);
-- ERROR: Cannot add or update a child row (foreign key constraint)

-- ============================================
-- 4. FOREIGN KEY: One-to-Many Relationship
-- ============================================
-- One department has many employees
INSERT INTO employees (first_name, last_name, dept_id)
VALUES 
('Diana', 'Davis', 1),   -- Same dept as Alice
('Eve', 'Wilson', 2),    -- Same dept as Bob
('Frank', 'Miller', 1);  -- Another employee in Sales

-- ============================================
-- 5. FOREIGN KEY: Referential Integrity
-- ============================================
-- Cannot delete department with employees
DELETE FROM departments WHERE dept_id = 1;
-- ERROR: Cannot delete parent row (has child records)

-- Must delete or update employees first
DELETE FROM employees WHERE dept_id = 1;
DELETE FROM departments WHERE dept_id = 1;

-- ============================================
-- 6. FOREIGN KEY: Cascading Actions
-- ============================================
-- ON DELETE CASCADE: Delete child records when parent deleted
CREATE TABLE IF NOT EXISTS orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- Create customers table first
CREATE TABLE IF NOT EXISTS customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(50)
);

-- ============================================
-- 7. FOREIGN KEY: ON DELETE SET NULL
-- ============================================
-- When parent deleted, set foreign key to NULL
CREATE TABLE IF NOT EXISTS assignments (
    assignment_id INT PRIMARY KEY AUTO_INCREMENT,
    task VARCHAR(100),
    assigned_to INT,
    FOREIGN KEY (assigned_to) REFERENCES employees(emp_id)
    ON DELETE SET NULL
);

-- ============================================
-- 8. FOREIGN KEY: ON DELETE RESTRICT (Default)
-- ============================================
-- Prevents deletion if child records exist
CREATE TABLE IF NOT EXISTS invoices (
    invoice_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
    ON DELETE RESTRICT
);

-- ============================================
-- 9. MULTIPLE FOREIGN KEYS
-- ============================================
CREATE TABLE IF NOT EXISTS order_items (
    order_id INT,
    product_id INT,
    quantity INT,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Create products table
CREATE TABLE IF NOT EXISTS products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100)
);

-- ============================================
-- 10. FOREIGN KEY: Self-Referencing
-- ============================================
-- Employee reports to another employee (manager)
ALTER TABLE employees
ADD COLUMN manager_id INT;

ALTER TABLE employees
ADD FOREIGN KEY (manager_id) REFERENCES employees(emp_id)
ON DELETE SET NULL;

-- ============================================
-- 11. VIEW FOREIGN KEY INFORMATION
-- ============================================
-- See all foreign keys in a table
SELECT CONSTRAINT_NAME, TABLE_NAME, COLUMN_NAME, REFERENCED_TABLE_NAME, REFERENCED_COLUMN_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_NAME = 'employees';

-- ============================================
-- 12. ADD FOREIGN KEY TO EXISTING TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS temp_orders (
    order_id INT PRIMARY KEY,
    cust_id INT
);

-- Add foreign key
ALTER TABLE temp_orders
ADD FOREIGN KEY (cust_id) REFERENCES customers(customer_id);

-- ============================================
-- 13. DROP FOREIGN KEY
-- ============================================
ALTER TABLE temp_orders
DROP FOREIGN KEY temp_orders_ibfk_1;  -- Use actual constraint name

-- ============================================
-- 14. PRACTICAL EXAMPLES
-- ============================================

-- Example 1: Blog Database Schema
CREATE TABLE IF NOT EXISTS users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS posts (
    post_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100),
    content TEXT,
    author_id INT NOT NULL,
    FOREIGN KEY (author_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS comments (
    comment_id INT PRIMARY KEY AUTO_INCREMENT,
    post_id INT NOT NULL,
    author_id INT NOT NULL,
    content TEXT,
    FOREIGN KEY (post_id) REFERENCES posts(post_id) ON DELETE CASCADE,
    FOREIGN KEY (author_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Example 2: E-commerce Database
CREATE TABLE IF NOT EXISTS categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS products_ecom (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100),
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

CREATE TABLE IF NOT EXISTS inventory (
    product_id INT PRIMARY KEY,
    stock_quantity INT,
    FOREIGN KEY (product_id) REFERENCES products_ecom(product_id) ON DELETE CASCADE
);

-- ============================================
-- 15. ENABLING/DISABLING FOREIGN KEY CHECKS
-- ============================================
-- Temporarily disable to insert without constraints (Use with caution!)
-- SET FOREIGN_KEY_CHECKS=0;
-- (insert data)
-- SET FOREIGN_KEY_CHECKS=1;

-- ============================================
-- 16. FOREIGN KEY CONSIDERATIONS
-- ============================================
-- - Always create parent table before child table
-- - Child table column must match parent in type and size
-- - Consider cascading deletes vs restrictions
-- - Foreign keys improve data integrity
-- - May have slight performance impact on large databases
