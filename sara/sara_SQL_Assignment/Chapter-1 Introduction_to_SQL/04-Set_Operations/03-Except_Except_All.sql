-- ============================================
-- Chapter 1: Set Operations
-- 03. Except / Except All Queries
-- ============================================
-- EXCEPT returns rows from first query that DON'T appear in second query.
-- MySQL uses MINUS instead of EXCEPT, but neither is always available.
-- Workaround: Use LEFT JOIN with IS NULL condition.

USE company;

-- ============================================
-- 1. SIMULATING EXCEPT Using LEFT JOIN
-- ============================================
-- Find employees in Sales but NOT in IT

CREATE TABLE IF NOT EXISTS sales_team (
    emp_id INT,
    name VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS it_team (
    emp_id INT,
    name VARCHAR(50)
);

INSERT INTO sales_team VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie'),
(4, 'Diana');

INSERT INTO it_team VALUES
(2, 'Bob'),
(4, 'Diana'),
(5, 'Eve');

-- EXCEPT simulation: Sales employees NOT in IT
SELECT DISTINCT s.name
FROM sales_team s
LEFT JOIN it_team i ON s.name = i.name
WHERE i.name IS NULL;

-- ============================================
-- 2. SIMULATING EXCEPT Using NOT EXISTS
-- ============================================
-- Find names in sales_team that don't exist in it_team
SELECT DISTINCT s.name
FROM sales_team s
WHERE NOT EXISTS (
    SELECT 1 FROM it_team i WHERE i.name = s.name
);

-- ============================================
-- 3. SIMULATING EXCEPT Using NOT IN
-- ============================================
-- Find sales employees not in IT
SELECT DISTINCT name
FROM sales_team
WHERE name NOT IN (SELECT name FROM it_team);

-- ============================================
-- 4. EXCEPT: Multiple Columns
-- ============================================
-- Create tables with multiple columns
CREATE TABLE IF NOT EXISTS product_catalog (
    product_id INT,
    product_name VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE IF NOT EXISTS discontinued_products (
    product_id INT,
    product_name VARCHAR(50),
    price DECIMAL(10,2)
);

INSERT INTO product_catalog VALUES
(1, 'Laptop', 1000.00),
(2, 'Phone', 800.00),
(3, 'Tablet', 500.00),
(4, 'Monitor', 300.00);

INSERT INTO discontinued_products VALUES
(2, 'Phone', 800.00),
(4, 'Monitor', 300.00);

-- Find active products (in catalog but not discontinued)
SELECT product_id, product_name, price FROM product_catalog
EXCEPT
SELECT product_id, product_name, price FROM discontinued_products;

-- MySQL simulation using LEFT JOIN:
SELECT DISTINCT p.product_id, p.product_name, p.price
FROM product_catalog p
LEFT JOIN discontinued_products d 
    ON p.product_id = d.product_id
    AND p.product_name = d.product_name
    AND p.price = d.price
WHERE d.product_id IS NULL;

-- ============================================
-- 5. EXCEPT: Simple Difference
-- ============================================
-- Find employees only in Sales (not in IT)
SELECT emp_id FROM sales_team
EXCEPT
SELECT emp_id FROM it_team;

-- MySQL simulation:
SELECT DISTINCT s.emp_id
FROM sales_team s
LEFT JOIN it_team i ON s.emp_id = i.emp_id
WHERE i.emp_id IS NULL;

-- ============================================
-- 6. PRACTICAL EXAMPLES
-- ============================================

-- Example 1: Find customers who didn't make purchases
-- CREATE TABLE all_customers (customer_id INT, name VARCHAR(50));
-- CREATE TABLE customers_with_orders (customer_id INT);
-- SELECT customer_id FROM all_customers
-- EXCEPT
-- SELECT customer_id FROM customers_with_orders;

-- Example 2: Products available but not ordered
CREATE TABLE IF NOT EXISTS all_products (
    product_id INT,
    product_name VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS ordered_products (
    product_id INT,
    product_name VARCHAR(50)
);

INSERT INTO all_products VALUES
(1, 'Apple'),
(2, 'Banana'),
(3, 'Cherry'),
(4, 'Date');

INSERT INTO ordered_products VALUES
(1, 'Apple'),
(3, 'Cherry');

-- Products available but not ordered
SELECT p.product_id, p.product_name
FROM all_products p
LEFT JOIN ordered_products o ON p.product_id = o.product_id
WHERE o.product_id IS NULL;

-- Example 3: Students registered but not attending
CREATE TABLE IF NOT EXISTS registered_students (
    student_id INT,
    name VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS attending_students (
    student_id INT,
    name VARCHAR(50)
);

INSERT INTO registered_students VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie'),
(4, 'Diana');

INSERT INTO attending_students VALUES
(1, 'Alice'),
(3, 'Charlie'),
(4, 'Diana');

-- Students registered but not attending
SELECT DISTINCT r.name
FROM registered_students r
WHERE r.name NOT IN (SELECT name FROM attending_students);

-- ============================================
-- 7. EXCEPT ALL: With Duplicates
-- ============================================
-- MySQL simulation of EXCEPT ALL

CREATE TABLE IF NOT EXISTS set_a (
    value VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS set_b (
    value VARCHAR(50)
);

INSERT INTO set_a VALUES ('Apple'), ('Apple'), ('Banana'), ('Cherry');
INSERT INTO set_b VALUES ('Apple'), ('Banana');

-- EXCEPT (removes duplicates)
SELECT DISTINCT value FROM set_a
WHERE value NOT IN (SELECT value FROM set_b);

-- EXCEPT ALL (keeps duplicates from set_a)
SELECT a.value
FROM set_a a
LEFT JOIN set_b b ON a.value = b.value
WHERE b.value IS NULL;

-- ============================================
-- 8. COMBINATION: EXCEPT with UNION
-- ============================================
-- Employees in Sales or IT but not both
SELECT name FROM sales_team
EXCEPT
SELECT name FROM it_team
UNION
SELECT name FROM it_team
EXCEPT
SELECT name FROM sales_team;

-- MySQL simulation:
SELECT s.name FROM sales_team s
WHERE s.name NOT IN (SELECT i.name FROM it_team i)
UNION
SELECT i.name FROM it_team i
WHERE i.name NOT IN (SELECT s.name FROM sales_team s);

-- ============================================
-- 9. EXCEPT vs WHERE NOT IN
-- ============================================
-- These produce similar results:

-- Using EXCEPT concept:
SELECT DISTINCT name FROM sales_team
WHERE name NOT IN (SELECT name FROM it_team);

-- Using NOT EXISTS:
SELECT DISTINCT s.name FROM sales_team s
WHERE NOT EXISTS (SELECT 1 FROM it_team i WHERE i.name = s.name);

-- Using LEFT JOIN:
SELECT DISTINCT s.name FROM sales_team s
LEFT JOIN it_team i ON s.name = i.name
WHERE i.name IS NULL;
