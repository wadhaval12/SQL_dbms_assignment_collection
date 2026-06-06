-- ============================================
-- Chapter 1: Set Operations
-- 02. Intersect / Intersect All Queries
-- ============================================
-- INTERSECT returns only rows that appear in both queries.
-- MySQL doesn't have INTERSECT, but we can simulate using JOIN or subqueries.

USE company;

-- ============================================
-- 1. SIMULATING INTERSECT Using INNER JOIN
-- ============================================
-- Find employees who appear in both sales and IT departments

CREATE TABLE IF NOT EXISTS employees_sales (
    emp_id INT,
    name VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS employees_it (
    emp_id INT,
    name VARCHAR(50)
);

INSERT INTO employees_sales VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie'),
(4, 'Diana');

INSERT INTO employees_it VALUES
(2, 'Bob'),
(4, 'Diana'),
(5, 'Eve'),
(6, 'Frank');

-- INTERSECT simulation: Find employees in BOTH tables
SELECT DISTINCT s.name
FROM employees_sales s
INNER JOIN employees_it i ON s.name = i.name;

-- ============================================
-- 2. SIMULATING INTERSECT Using EXISTS
-- ============================================
-- Find employees in sales table who also exist in IT table
SELECT DISTINCT s.name
FROM employees_sales s
WHERE EXISTS (
    SELECT 1 FROM employees_it i WHERE i.name = s.name
);

-- ============================================
-- 3. INTERSECT: Multiple Columns
-- ============================================
-- Create tables with multiple columns
CREATE TABLE IF NOT EXISTS product_catalog_2023 (
    product_id INT,
    product_name VARCHAR(50),
    category VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS inventory_2023 (
    product_id INT,
    product_name VARCHAR(50),
    category VARCHAR(50)
);

INSERT INTO product_catalog_2023 VALUES
(1, 'Laptop', 'Electronics'),
(2, 'Phone', 'Electronics'),
(3, 'Desk', 'Furniture');

INSERT INTO inventory_2023 VALUES
(2, 'Phone', 'Electronics'),
(3, 'Desk', 'Furniture'),
(4, 'Chair', 'Furniture');

-- Find products in both catalog and inventory
SELECT product_id, product_name, category FROM product_catalog_2023
INTERSECT
SELECT product_id, product_name, category FROM inventory_2023;

-- MySQL simulation (since INTERSECT not available):
SELECT DISTINCT p.product_id, p.product_name, p.category
FROM product_catalog_2023 p
INNER JOIN inventory_2023 i 
    ON p.product_id = i.product_id
    AND p.product_name = i.product_name
    AND p.category = i.category;

-- ============================================
-- 4. INTERSECT: Common Values
-- ============================================
-- Find IDs that exist in both tables
SELECT emp_id FROM employees_sales
INTERSECT
SELECT emp_id FROM employees_it;

-- MySQL simulation:
SELECT DISTINCT s.emp_id
FROM employees_sales s
WHERE EXISTS (
    SELECT 1 FROM employees_it i WHERE i.emp_id = s.emp_id
);

-- ============================================
-- 5. PRACTICAL EXAMPLES
-- ============================================

-- Example 1: Find active customers who made purchases
-- CREATE TABLE customers (customer_id INT, name VARCHAR(50));
-- CREATE TABLE purchases (customer_id INT, amount DECIMAL(10,2));
-- SELECT customer_id FROM customers
-- INTERSECT
-- SELECT DISTINCT customer_id FROM purchases;

-- Example 2: Find products in stock and on order
-- CREATE TABLE stock (product_id INT, quantity INT);
-- CREATE TABLE orders (product_id INT, quantity INT);
-- SELECT product_id FROM stock
-- INTERSECT
-- SELECT product_id FROM orders;

-- Example 3: Students enrolled in both courses
CREATE TABLE IF NOT EXISTS students_course_a (
    student_id INT,
    student_name VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS students_course_b (
    student_id INT,
    student_name VARCHAR(50)
);

INSERT INTO students_course_a VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie');

INSERT INTO students_course_b VALUES
(2, 'Bob'),
(3, 'Charlie'),
(4, 'Diana');

-- Find students in BOTH courses
SELECT DISTINCT s1.student_name
FROM students_course_a s1
INNER JOIN students_course_b s2 ON s1.student_name = s2.student_name;

-- ============================================
-- 6. INTERSECT vs INNER JOIN
-- ============================================
-- INTERSECT: Returns only matching rows from first query
-- INNER JOIN: Returns all matching combinations

-- INTERSECT (returns unique matches)
SELECT DISTINCT name FROM employees_sales
WHERE name IN (SELECT name FROM employees_it);

-- INNER JOIN (could return duplicates)
SELECT s.name
FROM employees_sales s
INNER JOIN employees_it i ON s.name = i.name;

-- ============================================
-- 7. INTERSECT ALL: With Duplicates
-- ============================================
-- MySQL simulation of INTERSECT ALL
-- Return matching rows, even if duplicates exist

CREATE TABLE IF NOT EXISTS test_a (
    value VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS test_b (
    value VARCHAR(50)
);

INSERT INTO test_a VALUES ('Apple'), ('Apple'), ('Banana'), ('Cherry');
INSERT INTO test_b VALUES ('Apple'), ('Banana'), ('Banana'), ('Date');

-- INTERSECT (removes duplicates)
SELECT DISTINCT value FROM test_a
WHERE value IN (SELECT value FROM test_b);

-- INTERSECT ALL (keeps duplicates) - using join
SELECT a.value
FROM test_a a
INNER JOIN test_b b ON a.value = b.value;
