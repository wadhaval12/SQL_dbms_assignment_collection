-- ============================================
-- Chapter 2: Advanced SQL
-- 03. Database Modification Commands (DML)
-- 02. Update Commands
-- ============================================
-- UPDATE modifies existing rows

USE company;

-- Create sample table if not exists
CREATE TABLE IF NOT EXISTS employees (
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    salary DECIMAL(10,2),
    department VARCHAR(50),
    hire_date DATE
);

-- Insert sample data
INSERT IGNORE INTO employees VALUES
(1, 'Alice', 'Smith', 'alice@company.com', 90000, 'Management', '2021-01-15'),
(2, 'Bob', 'Johnson', 'bob@company.com', 75000, 'Sales', '2022-03-20'),
(3, 'Charlie', 'Brown', 'charlie@company.com', 70000, 'Sales', '2022-06-10'),
(4, 'Diana', 'Davis', 'diana@company.com', 65000, 'HR', '2023-02-01'),
(5, 'Eve', 'Wilson', 'eve@company.com', 62000, 'IT', '2023-05-12');

-- ============================================
-- 1. UPDATE: Single Column
-- ============================================
-- Update salary of specific employee
UPDATE employees
SET salary = 80000
WHERE emp_id = 2;

-- Update department for one employee
UPDATE employees
SET department = 'Finance'
WHERE emp_id = 1;

-- ============================================
-- 2. UPDATE: Multiple Columns
-- ============================================
-- Update multiple columns at once
UPDATE employees
SET salary = 85000, department = 'Senior Management'
WHERE emp_id = 1;

-- ============================================
-- 3. UPDATE: With Expression
-- ============================================
-- Give all employees a 10% raise
UPDATE employees
SET salary = salary * 1.1;

-- Give 5% bonus to high earners
UPDATE employees
SET salary = salary * 1.05
WHERE salary > 70000;

-- ============================================
-- 4. UPDATE: With WHERE Clause
-- ============================================
-- Update all Sales employees
UPDATE employees
SET salary = salary * 1.08
WHERE department = 'Sales';

-- Update employees hired before 2022
UPDATE employees
SET department = 'Senior ' + department
WHERE YEAR(hire_date) < 2022;

-- ============================================
-- 5. UPDATE: Conditional (CASE)
-- ============================================
-- Different raises based on department
UPDATE employees
SET salary = CASE 
    WHEN department = 'Management' THEN salary * 1.05
    WHEN department = 'Sales' THEN salary * 1.10
    WHEN department = 'IT' THEN salary * 1.12
    ELSE salary * 1.03
END;

-- Promotion based on salary
UPDATE employees
SET department = CASE
    WHEN salary > 80000 THEN 'Senior ' + department
    ELSE department
END
WHERE salary > 80000;

-- ============================================
-- 6. UPDATE: Using JOIN
-- ============================================
-- Update based on condition from another table
CREATE TABLE IF NOT EXISTS performance_bonus (
    emp_id INT,
    bonus_percent DECIMAL(5,2)
);

INSERT INTO performance_bonus VALUES
(1, 15.00),
(2, 10.00),
(3, 8.00);

-- Update salaries with bonus
UPDATE employees e
JOIN performance_bonus pb ON e.emp_id = pb.emp_id
SET e.salary = e.salary + (e.salary * pb.bonus_percent / 100);

-- ============================================
-- 7. UPDATE: Multiple Rows by Condition
-- ============================================
-- Increase salary for all IT employees
UPDATE employees
SET salary = salary * 1.15
WHERE department = 'IT';

-- Move all HR employees to Finance
UPDATE employees
SET department = 'Finance'
WHERE department = 'HR';

-- ============================================
-- 8. UPDATE: All Rows (Use with Caution!)
-- ============================================
-- Update all rows (DANGEROUS without WHERE!)
-- UPDATE employees SET salary = 70000;  -- AVOID!

-- Safe alternative with condition
UPDATE employees
SET email = CONCAT(LOWER(first_name), '.', LOWER(last_name), '@company.com');

-- ============================================
-- 9. UPDATE: Using Functions
-- ============================================
-- Update email using CONCAT
UPDATE employees
SET email = CONCAT(LOWER(first_name), '@company.com')
WHERE email IS NULL;

-- Update email to uppercase
UPDATE employees
SET email = UPPER(email);

-- ============================================
-- 10. UPDATE: With Subquery
-- ============================================
-- Update employees to match highest salary in their department
UPDATE employees
SET salary = (
    SELECT MAX(salary) FROM (
        SELECT * FROM employees
    ) AS temp
    WHERE department = employees.department
);

-- ============================================
-- 11. UPDATE: Incrementing Values
-- ============================================
-- Add bonus to employees with >5 years service
UPDATE employees
SET salary = salary + 5000
WHERE YEAR(CURDATE()) - YEAR(hire_date) > 5;

-- ============================================
-- 12. PRACTICAL EXAMPLES
-- ============================================

-- Example 1: Annual Salary Review
UPDATE employees
SET salary = CASE
    WHEN YEAR(CURDATE()) - YEAR(hire_date) >= 5 THEN salary * 1.05
    WHEN YEAR(CURDATE()) - YEAR(hire_date) >= 3 THEN salary * 1.03
    ELSE salary * 1.02
END;

-- Example 2: Promotion with Raise
UPDATE employees
SET 
    department = 'Senior ' + department,
    salary = salary * 1.15
WHERE emp_id IN (1, 3, 5);

-- Example 3: Department Consolidation
UPDATE employees
SET department = 'Technology'
WHERE department IN ('IT', 'Software', 'Development');

-- Example 4: New Email Domain
UPDATE employees
SET email = CONCAT(
    LOWER(SUBSTRING(first_name, 1, 1)),
    LOWER(last_name),
    '@newcompany.com'
);

-- ============================================
-- 13. UPDATE: Safety Checks
-- ============================================
-- Always preview what will be updated first
SELECT * FROM employees WHERE department = 'IT';

-- Then run update
UPDATE employees
SET salary = salary * 1.10
WHERE department = 'IT';

-- ============================================
-- 14. IMPORTANT REMINDERS
-- ============================================
-- - ALWAYS use WHERE clause to target specific rows
-- - Test SELECT first before UPDATE
-- - Use LIMIT to restrict updates in development
-- - Consider BACKUP before large updates
-- - Use transactions for safety:
--   START TRANSACTION;
--   UPDATE ...;
--   ROLLBACK; -- or COMMIT;
