-- ============================================
-- ASSIGNMENT 3: AGGREGATE FUNCTIONS & GROUP BY
-- COUNT, SUM, AVG, MIN, MAX, GROUP BY, HAVING
-- ============================================
-- This assignment tests your ability to:
-- 1. Use aggregate functions
-- 2. Group data with GROUP BY
-- 3. Filter groups with HAVING
-- 4. Combine aggregates with WHERE

USE practice_db;

-- Setup: Create and populate test data
CREATE TABLE IF NOT EXISTS employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    salary DECIMAL(10,2),
    department VARCHAR(50),
    years_employed INT
);

INSERT IGNORE INTO employees VALUES
(1, 'Alice', 90000, 'Sales', 5),
(2, 'Bob', 75000, 'IT', 3),
(3, 'Charlie', 70000, 'Sales', 2),
(4, 'Diana', 65000, 'HR', 1),
(5, 'Eve', 62000, 'IT', 1),
(6, 'Frank', 72000, 'Sales', 4),
(7, 'Grace', 68000, 'Finance', 2),
(8, 'Henry', 80000, 'IT', 6);

-- ============================================
-- PROBLEM 1: COUNT All Rows
-- ============================================
-- Count the total number of employees

-- YOUR SOLUTION HERE:
-- SELECT COUNT(*) AS ...

-- Expected: 8

\n\n-- ============================================
-- PROBLEM 2: COUNT Non-NULL Values
-- ============================================
-- Count employees (same as COUNT(*) since all have emp_id)

-- YOUR SOLUTION HERE:
-- SELECT COUNT(emp_id) AS ...

-- Expected: 8

\n\n-- ============================================
-- PROBLEM 3: SUM and AVG
-- ============================================
-- Calculate total and average salary of all employees

-- YOUR SOLUTION HERE:
-- SELECT SUM(...), AVG(...)

-- Expected: Total ~582000, Average ~72750

\n\n-- ============================================
-- PROBLEM 4: MIN and MAX
-- ============================================
-- Find the lowest and highest salaries

-- YOUR SOLUTION HERE:
-- SELECT MIN(...), MAX(...)

-- Expected: Min 62000, Max 90000

\n\n-- ============================================
-- PROBLEM 5: All Aggregates Together
-- ============================================
-- Display count, sum, average, min, max for salary

-- YOUR SOLUTION HERE:
-- SELECT COUNT(*), SUM(...), AVG(...), MIN(...), MAX(...)

-- Expected: Count 8, Sum ~582000, Avg ~72750, Min 62000, Max 90000

\n\n-- ============================================
-- PROBLEM 6: GROUP BY Single Column
-- ============================================
-- Count employees by department

-- YOUR SOLUTION HERE:
-- SELECT department, COUNT(*) FROM employees GROUP BY ...

-- Expected: Finance 1, HR 1, IT 3, Sales 3

\n\n-- ============================================
-- PROBLEM 7: GROUP BY with AVG
-- ============================================
-- Show average salary by department

-- YOUR SOLUTION HERE:
-- SELECT department, AVG(salary) FROM employees GROUP BY ...

-- Expected: IT avg=75666.67, Sales avg=77333.33, etc.

\n\n-- ============================================
-- PROBLEM 8: GROUP BY with Multiple Aggregates
-- ============================================
-- Show count, sum, and average salary by department

-- YOUR SOLUTION HERE:
-- SELECT department, COUNT(*), SUM(...), AVG(...) ...

-- Expected: Multiple columns with stats per department

\n\n-- ============================================
-- PROBLEM 9: GROUP BY with ORDER BY
-- ============================================
-- Show departments sorted by average salary (highest first)

-- YOUR SOLUTION HERE:
-- SELECT department, AVG(salary) FROM employees GROUP BY ... ORDER BY ...

-- Expected: IT first (~75666), Finance, Sales, HR last

\n\n-- ============================================
-- PROBLEM 10: HAVING Clause
-- ============================================
-- Show only departments with more than 2 employees

-- YOUR SOLUTION HERE:
-- SELECT department, COUNT(*) FROM employees GROUP BY ... HAVING ...

-- Expected: IT (3 employees), Sales (3 employees)

\n\n-- ============================================
-- PROBLEM 11: HAVING with Aggregate Function
-- ============================================
-- Show departments with average salary > 70000

-- YOUR SOLUTION HERE:
-- SELECT department, AVG(salary) FROM employees GROUP BY ... HAVING ...

-- Expected: IT (~75666), Sales (~77333)

\n\n-- ============================================
-- PROBLEM 12: WHERE and HAVING Combined
-- ============================================
-- Show departments with >2 employees and average salary > 65000
-- Filter employees with salary > 65000 first

-- YOUR SOLUTION HERE:
-- SELECT department, COUNT(*), AVG(salary) FROM employees WHERE ... GROUP BY ... HAVING ...

-- Expected: IT (3), Sales (3)

\n\n-- ============================================
-- PROBLEM 13: Complex Grouping
-- ============================================
-- Show salary stats by department AND years employed
-- Include count, average, min, max

-- YOUR SOLUTION HERE:
-- SELECT department, years_employed, COUNT(*), AVG(salary), MIN(salary), MAX(salary) ...

-- Expected: Multiple rows for each department-years combination

\n\n-- ============================================
-- PROBLEM 14: DISTINCT with COUNT
-- ============================================
-- Count distinct departments

-- YOUR SOLUTION HERE:
-- SELECT COUNT(DISTINCT department) FROM employees

-- Expected: 4

\n\n-- ============================================
-- PROBLEM 15: Aggregate with Expressions
-- ============================================
-- Calculate total annual payroll (sum of annual salaries)
-- Show count of employees in each department

-- YOUR SOLUTION HERE:
-- SELECT department, COUNT(*), SUM(salary * 12) FROM employees GROUP BY ...

-- Expected: Payroll values * 12

\n\n-- ============================================
-- EXPECTED OUTPUTS SUMMARY
-- ============================================
-- Problem 1: 8 (total employees)
-- Problem 2: 8 (non-null emp_ids)
-- Problem 3: Total ~582000, Avg ~72750
-- Problem 4: Min 62000, Max 90000
-- Problem 5: All stats in one row
-- Problem 6: Finance 1, HR 1, IT 3, Sales 3
-- Problem 7: Department-wise average salaries
-- Problem 8: Count, Sum, Avg per department
-- Problem 9: Sorted by average salary descending
-- Problem 10: IT 3, Sales 3 (>2 employees only)
-- Problem 11: IT, Sales (avg > 70000)
-- Problem 12: IT, Sales (>2 and avg > 65000)
-- Problem 13: Multiple rows with all combinations
-- Problem 14: 4 distinct departments
-- Problem 15: Annual payroll by department

\n\n-- ============================================
-- BONUS CHALLENGES
-- ============================================

-- BONUS 1: Salary Range
-- Show salary range (max - min) by department

-- BONUS 2: Percentages
-- Calculate percentage of total payroll for each department

-- BONUS 3: Ranking Departments
-- Rank departments by total payroll (highest to lowest)

-- BONUS 4: Employee Count Analysis
-- Find departments with exactly 2 employees

-- BONUS 5: Advanced Filtering
-- Show departments where total salary > 200000 and count >= 2

\n\n-- ============================================
-- LEARNING OUTCOMES
-- ============================================
-- After completing this assignment, you should be able to:
-- ✅ Use COUNT, SUM, AVG, MIN, MAX functions
-- ✅ Group data with GROUP BY
-- ✅ Filter groups with HAVING
-- ✅ Combine WHERE and HAVING appropriately
-- ✅ Use multiple aggregates in one query
-- ✅ Order grouped results
-- ✅ Apply aggregates with expressions
-- ✅ Handle DISTINCT in aggregates
-- ✅ Understand difference between WHERE and HAVING
-- ✅ Create summary reports from raw data
"