-- ============================================
-- Chapter 2: Advanced SQL
-- 01. Aggregate Functions and Partitioning
-- 01c. Having Clause Queries
-- ============================================
-- HAVING clause filters groups (WHERE filters rows)

USE company;

-- ============================================
-- 1. BASIC HAVING: Filter Groups
-- ============================================
-- Departments with more than 2 employees
SELECT 
    department,
    COUNT(*) AS employee_count
FROM employees
GROUP BY department
HAVING COUNT(*) > 2;

-- Departments with average salary > 70000
SELECT 
    department,
    AVG(salary) AS avg_salary
FROM employees
GROUP BY department
HAVING AVG(salary) > 70000;

-- ============================================
-- 2. WHERE vs HAVING
-- ============================================
-- WHERE: Filters individual rows (BEFORE grouping)
-- HAVING: Filters groups (AFTER grouping)

-- WHERE - exclude low earners, then group
SELECT 
    department,
    COUNT(*) AS count
FROM employees
WHERE salary > 65000
GROUP BY department;

-- HAVING - group all, then exclude small groups
SELECT 
    department,
    COUNT(*) AS count
FROM employees
GROUP BY department
HAVING COUNT(*) > 1;

-- Combined: WHERE and HAVING
SELECT 
    department,
    COUNT(*) AS count
FROM employees
WHERE salary > 65000
GROUP BY department
HAVING COUNT(*) >= 2;

-- ============================================
-- 3. HAVING WITH MULTIPLE CONDITIONS
-- ============================================
-- Departments with more than 2 employees AND avg salary > 70000
SELECT 
    department,
    COUNT(*) AS emp_count,
    AVG(salary) AS avg_salary
FROM employees
GROUP BY department
HAVING COUNT(*) > 2 AND AVG(salary) > 70000;

-- ============================================
-- 4. HAVING WITH AGGREGATE FUNCTIONS
-- ============================================
-- Groups with maximum salary above 80000
SELECT 
    department,
    MAX(salary) AS highest_salary
FROM employees
GROUP BY department
HAVING MAX(salary) > 80000;

-- Groups with salary range > 20000
SELECT 
    department,
    MIN(salary) AS lowest,
    MAX(salary) AS highest,
    MAX(salary) - MIN(salary) AS range
FROM employees
GROUP BY department
HAVING MAX(salary) - MIN(salary) > 20000;

-- ============================================
-- 5. HAVING WITH ORDER BY
-- ============================================
-- Departments with > 1 employee, ordered by count
SELECT 
    department,
    COUNT(*) AS employee_count,
    AVG(salary) AS avg_salary
FROM employees
GROUP BY department
HAVING COUNT(*) > 1
ORDER BY employee_count DESC;

-- Departments with high payroll
SELECT 
    department,
    SUM(salary) AS total_payroll
FROM employees
GROUP BY department
HAVING SUM(salary) > 150000
ORDER BY total_payroll DESC;

-- ============================================
-- 6. PRACTICAL EXAMPLES
-- ============================================

-- Example 1: Departments Below Target Payroll
SELECT 
    department,
    COUNT(*) AS employees,
    SUM(salary) AS total_payroll
FROM employees
GROUP BY department
HAVING SUM(salary) < 200000
ORDER BY total_payroll;

-- Example 2: High Variance Departments
SELECT 
    department,
    COUNT(*) AS count,
    ROUND(AVG(salary), 2) AS avg_salary,
    STDDEV_POP(salary) AS salary_stddev
FROM employees
GROUP BY department
HAVING STDDEV_POP(salary) > 5000;

-- Example 3: Understaffed Departments
SELECT 
    department,
    COUNT(*) AS current_staff
FROM employees
GROUP BY department
HAVING COUNT(*) < 3
ORDER BY current_staff;

-- Example 4: High-Cost Departments
SELECT 
    department,
    COUNT(*) AS employees,
    SUM(salary) AS total_cost,
    ROUND(AVG(salary), 2) AS avg_cost
FROM employees
GROUP BY department
HAVING SUM(salary) > 250000
ORDER BY total_cost DESC;

-- ============================================
-- 7. COMPLEX HAVING CLAUSE
-- ============================================
-- Multiple conditions with OR
SELECT 
    department,
    COUNT(*) AS count,
    AVG(salary) AS avg_sal
FROM employees
GROUP BY department
HAVING COUNT(*) > 3 OR AVG(salary) > 80000;

-- NOT IN conjunction with aggregates
SELECT 
    department,
    SUM(salary) AS total
FROM employees
GROUP BY department
HAVING SUM(salary) NOT BETWEEN 100000 AND 200000;

-- ============================================
-- 8. HAVING vs WHERE: Performance
-- ============================================
-- WHERE is more efficient - filters before grouping

-- Slower: Group all, then filter (if possible use WHERE)
SELECT 
    department,
    COUNT(*) AS count
FROM employees
GROUP BY department
HAVING AVG(salary) > 70000;

-- Faster: Filter first, then group
SELECT 
    department,
    COUNT(*) AS count
FROM employees
WHERE salary > 70000
GROUP BY department;

-- ============================================
-- 9. EXECUTION ORDER REMINDER
-- ============================================
-- 1. FROM
-- 2. WHERE (row filter)
-- 3. GROUP BY
-- 4. HAVING (group filter)
-- 5. SELECT
-- 6. ORDER BY
-- 7. LIMIT

-- Therefore:
-- - Can't use HAVING without GROUP BY
-- - Can't reference SELECT aliases in HAVING
-- - WHERE conditions appear before GROUP BY in logic
