-- ============================================
-- Chapter 3: Intermediate SQL
-- 01. Advanced Join Expressions
-- 01a. Natural Join, Left, Right, Full Outer Joins
-- ============================================
-- JOINs combine data from multiple tables based on relationships

USE company;

-- Setup tables
CREATE TABLE IF NOT EXISTS employees (
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    dept_id INT
);

CREATE TABLE IF NOT EXISTS departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

INSERT INTO employees VALUES
(1, 'Alice', 'Smith', 1),
(2, 'Bob', 'Johnson', 2),
(3, 'Charlie', 'Brown', 1),
(4, 'Diana', 'Davis', NULL);

INSERT INTO departments VALUES
(1, 'Sales'),
(2, 'IT'),
(3, 'HR');

-- ============================================
-- 1. INNER JOIN
-- ============================================
-- Returns only matching rows from both tables
SELECT e.first_name, d.dept_name
FROM employees e
INNER JOIN departments d ON e.dept_id = d.dept_id;

-- ============================================
-- 2. LEFT OUTER JOIN (LEFT JOIN)
-- ============================================
-- Returns all rows from left table, matching rows from right
SELECT e.first_name, e.dept_id, d.dept_name
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id;

-- Diana has NULL dept_id, so dept_name is NULL

-- ============================================
-- 3. RIGHT OUTER JOIN (RIGHT JOIN)
-- ============================================
-- Returns all rows from right table, matching rows from left
SELECT e.first_name, d.dept_name
FROM employees e
RIGHT JOIN departments d ON e.dept_id = d.dept_id;

-- HR (dept_id=3) has no employees, so first_name is NULL

-- ============================================
-- 4. FULL OUTER JOIN (MySQL uses UNION)
-- ============================================
-- Returns all rows from both tables
SELECT e.first_name, d.dept_name
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id
UNION
SELECT e.first_name, d.dept_name
FROM employees e
RIGHT JOIN departments d ON e.dept_id = d.dept_id;

-- ============================================
-- 5. NATURAL JOIN
-- ============================================
-- Joins on columns with the same name
CREATE TABLE IF NOT EXISTS emp_natural (
    emp_id INT,
    dept_id INT,
    name VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS dept_natural (
    dept_id INT,
    dept_name VARCHAR(50)
);

INSERT INTO emp_natural VALUES
(1, 1, 'Alice'),
(2, 2, 'Bob'),
(3, 1, 'Charlie');

INSERT INTO dept_natural VALUES
(1, 'Sales'),
(2, 'IT');

-- Natural join (joins on dept_id automatically)
SELECT emp_natural.name, dept_natural.dept_name
FROM emp_natural
NATURAL JOIN dept_natural;

-- ============================================
-- 6. CROSS JOIN (Cartesian Product)
-- ============================================
-- All combinations of rows
SELECT e.first_name, d.dept_name
FROM employees e
CROSS JOIN departments d;

-- ============================================
-- 7. MULTIPLE JOINS
-- ============================================
CREATE TABLE IF NOT EXISTS assignments (
    assignment_id INT,
    emp_id INT,
    project_id INT
);

CREATE TABLE IF NOT EXISTS projects (
    project_id INT,
    project_name VARCHAR(100)
);

INSERT INTO assignments VALUES
(1, 1, 100),
(2, 2, 101),
(3, 1, 101);

INSERT INTO projects VALUES
(100, 'Website Redesign'),
(101, 'Database Migration');

-- Join three tables
SELECT 
    e.first_name,
    d.dept_name,
    p.project_name
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id
LEFT JOIN assignments a ON e.emp_id = a.emp_id
LEFT JOIN projects p ON a.project_id = p.project_id;

-- ============================================
-- 8. SELF JOIN
-- ============================================
ALTER TABLE employees ADD COLUMN manager_id INT;

UPDATE employees SET manager_id = NULL WHERE emp_id = 1;
UPDATE employees SET manager_id = 1 WHERE emp_id IN (2, 3);
UPDATE employees SET manager_id = 2 WHERE emp_id = 4;

-- Find employee and manager
SELECT 
    e.first_name AS employee,
    m.first_name AS manager
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.emp_id;

-- ============================================
-- 9. JOIN ON CONDITIONS
-- ============================================
-- JOIN with compound conditions
SELECT e.first_name, d.dept_name
FROM employees e
JOIN departments d 
    ON e.dept_id = d.dept_id
    AND e.first_name LIKE 'A%';

-- ============================================
-- 10. JOIN WITH WHERE
-- ============================================
-- Filter after joining
SELECT e.first_name, d.dept_name
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id
WHERE d.dept_name = 'Sales';

-- ============================================
-- 11. USING CLAUSE
-- ============================================
-- Shorter syntax when column names match
SELECT e.first_name, d.dept_name
FROM employees e
INNER JOIN departments d USING (dept_id);

-- ============================================
-- 12. PRACTICAL EXAMPLE
-- ============================================
-- Complete employee report with all details
SELECT 
    e.emp_id,
    e.first_name,
    e.last_name,
    d.dept_name,
    m.first_name AS manager_name,
    p.project_name
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id
LEFT JOIN employees m ON e.manager_id = m.emp_id
LEFT JOIN assignments a ON e.emp_id = a.emp_id
LEFT JOIN projects p ON a.project_id = p.project_id
ORDER BY e.emp_id;

-- ============================================
-- 13. PERFORMANCE TIPS
-- ============================================
-- - Use INNER JOIN when all matches needed (faster)
-- - Use specific column names in ON conditions
-- - Index foreign key columns
-- - Avoid SELECT * in joins
-- - Filter in WHERE after joining, not in ON clause
