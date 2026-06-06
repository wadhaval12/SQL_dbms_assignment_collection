-- ============================================
-- Chapter 1: Additional Base Operations
-- 02. Self Join Queries
-- ============================================
-- A SELF JOIN is when a table is joined with itself.
-- This is useful for comparing rows within the same table (e.g., finding reporting relationships).

USE company;

-- Setup: Create employees table with manager information
CREATE TABLE IF NOT EXISTS employees_with_mgr (
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    salary DECIMAL(10,2),
    manager_id INT,
    FOREIGN KEY (manager_id) REFERENCES employees_with_mgr(emp_id)
);

INSERT INTO employees_with_mgr VALUES
(1, 'Alice', 'Smith', 90000, NULL),           -- CEO, no manager
(2, 'Bob', 'Johnson', 75000, 1),              -- Reports to Alice
(3, 'Charlie', 'Brown', 70000, 1),            -- Reports to Alice
(4, 'Diana', 'Davis', 65000, 2),              -- Reports to Bob
(5, 'Eve', 'Wilson', 62000, 2),               -- Reports to Bob
(6, 'Frank', 'Miller', 68000, 3);             -- Reports to Charlie

-- ============================================
-- 1. BASIC SELF JOIN: Employee and Manager
-- ============================================
-- Find each employee and their manager's name
SELECT 
    e.first_name AS 'Employee Name',
    e.salary AS 'Employee Salary',
    m.first_name AS 'Manager Name',
    m.salary AS 'Manager Salary'
FROM employees_with_mgr e
JOIN employees_with_mgr m ON e.manager_id = m.emp_id;

-- ============================================
-- 2. SELF JOIN WITH LEFT JOIN (Include Employees with No Manager)
-- ============================================
-- Include employees who have no manager (top-level)
SELECT 
    e.first_name AS 'Employee',
    COALESCE(m.first_name, 'None (CEO)') AS 'Manager'
FROM employees_with_mgr e
LEFT JOIN employees_with_mgr m ON e.manager_id = m.emp_id;

-- ============================================
-- 3. SELF JOIN: Comparing Two Instances
-- ============================================
-- Find pairs of employees in the same department with similar salaries
-- First, add department to employees table
ALTER TABLE employees_with_mgr
ADD COLUMN department VARCHAR(50) DEFAULT 'General';

-- Update departments for examples
UPDATE employees_with_mgr SET department = 'Sales' WHERE emp_id IN (1, 2, 3);
UPDATE employees_with_mgr SET department = 'IT' WHERE emp_id IN (4, 5, 6);

-- Find employees earning similar salaries in the same department
SELECT 
    e1.first_name AS 'Employee 1',
    e1.salary AS 'Salary 1',
    e2.first_name AS 'Employee 2',
    e2.salary AS 'Salary 2',
    e1.department AS 'Department'
FROM employees_with_mgr e1
JOIN employees_with_mgr e2 
    ON e1.department = e2.department 
    AND e1.emp_id < e2.emp_id
    AND ABS(e1.salary - e2.salary) < 5000;

-- ============================================
-- 4. SELF JOIN: Finding Duplicates
-- ============================================
-- Example: Find employees with the same last name (potential relatives)
SELECT 
    e1.first_name AS 'First Name 1',
    e1.last_name,
    e2.first_name AS 'First Name 2'
FROM employees_with_mgr e1
JOIN employees_with_mgr e2 
    ON e1.last_name = e2.last_name
    AND e1.emp_id < e2.emp_id;

-- ============================================
-- 5. MULTIPLE LEVELS: Employee -> Manager -> Manager's Manager
-- ============================================
-- Three-level hierarchy
SELECT 
    e.first_name AS 'Employee',
    m1.first_name AS 'Direct Manager',
    m2.first_name AS 'Manager\'s Manager'
FROM employees_with_mgr e
LEFT JOIN employees_with_mgr m1 ON e.manager_id = m1.emp_id
LEFT JOIN employees_with_mgr m2 ON m1.manager_id = m2.emp_id;

-- ============================================
-- 6. SELF JOIN WITH AGGREGATION
-- ============================================
-- Average salary by department, comparing with manager's average
-- (Showing the concept of complex self joins)

-- ============================================
-- 7. SELF JOIN: Finding Parent-Child Records
-- ============================================
-- Example with categories and subcategories
CREATE TABLE IF NOT EXISTS categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(50),
    parent_category_id INT,
    FOREIGN KEY (parent_category_id) REFERENCES categories(category_id)
);

INSERT INTO categories VALUES
(1, 'Electronics', NULL),
(2, 'Computers', 1),
(3, 'Laptops', 2),
(4, 'Desktops', 2),
(5, 'Phones', 1),
(6, 'Smartphones', 5);

-- Find subcategories with their parent category
SELECT 
    c.category_name AS 'Subcategory',
    p.category_name AS 'Parent Category'
FROM categories c
LEFT JOIN categories p ON c.parent_category_id = p.category_id;

-- ============================================
-- 8. SELF JOIN: Organizational Chart
-- ============================================
-- Create a simple organizational hierarchy display
SELECT 
    CONCAT(REPEAT('  ', 0), e.first_name) AS 'Organizational Hierarchy'
FROM employees_with_mgr e
WHERE e.manager_id IS NULL

UNION ALL

SELECT 
    CONCAT(REPEAT('  ', 1), e.first_name)
FROM employees_with_mgr e
WHERE e.manager_id IS NOT NULL;

-- ============================================
-- 9. SELF JOIN: Finding Related Records
-- ============================================
-- Example: Students in same year
CREATE TABLE IF NOT EXISTS students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    year_of_study INT
);

INSERT INTO students VALUES
(1, 'Alice', 2),
(2, 'Bob', 2),
(3, 'Charlie', 3),
(4, 'Diana', 2),
(5, 'Eve', 3);

-- Find classmates (students in same year)
SELECT 
    s1.student_name AS 'Student 1',
    s2.student_name AS 'Student 2 (Classmate)',
    s1.year_of_study AS 'Year'
FROM students s1
JOIN students s2 
    ON s1.year_of_study = s2.year_of_study
    AND s1.student_id < s2.student_id;

-- ============================================
-- 10. IMPORTANT NOTES FOR SELF JOINS
-- ============================================
-- - Always use table aliases (e1, e2) to distinguish the two instances
-- - Use meaningful alias names (e.g., e and m for employee and manager)
-- - Add conditions to avoid duplicate comparisons (e.g., e1.emp_id < e2.emp_id)
-- - Use LEFT JOIN when some records might not have matching pairs
-- - Self joins can be less efficient with large tables - consider indexing
