-- ============================================
-- Chapter 1: Data Definition Language (DDL)
-- 02. Alter Table Commands
-- ============================================
-- ALTER TABLE is used to modify existing table structure:
-- - Add new columns
-- - Drop existing columns
-- - Modify column data types
-- - Rename columns
-- - Add/Drop constraints

USE company;

-- ============================================
-- EXAMPLE 1: Add a New Column
-- ============================================
-- Add a department column to employees table
ALTER TABLE employees
ADD COLUMN department VARCHAR(50);

-- Add multiple columns at once
ALTER TABLE employees
ADD COLUMN phone VARCHAR(20),
ADD COLUMN manager_id INT;

-- Add column at specific position
ALTER TABLE employees
ADD COLUMN birth_date DATE AFTER hire_date;

-- Add column at the beginning
ALTER TABLE employees
ADD COLUMN emp_status VARCHAR(20) FIRST;

-- ============================================
-- EXAMPLE 2: Modify Column Data Type
-- ============================================
-- Change phone from VARCHAR(20) to VARCHAR(15)
ALTER TABLE employees
MODIFY COLUMN phone VARCHAR(15);

-- Change salary to store more precision
ALTER TABLE employees
MODIFY COLUMN salary DECIMAL(12,2);

-- Make a column NOT NULL
ALTER TABLE employees
MODIFY COLUMN department VARCHAR(50) NOT NULL;

-- Add a default value to existing column
ALTER TABLE employees
MODIFY COLUMN emp_status VARCHAR(20) DEFAULT 'Active';

-- ============================================
-- EXAMPLE 3: Drop a Column
-- ============================================
-- Remove the manager_id column
ALTER TABLE employees
DROP COLUMN manager_id;

-- Drop multiple columns (one statement each)
ALTER TABLE employees
DROP COLUMN birth_date;

-- ============================================
-- EXAMPLE 4: Rename Column
-- ============================================
-- Change 'email' column to 'email_address'
ALTER TABLE employees
RENAME COLUMN email TO email_address;

-- Alternative MySQL syntax (older versions):
-- ALTER TABLE employees
-- CHANGE COLUMN email email_address VARCHAR(100) UNIQUE;

-- ============================================
-- EXAMPLE 5: Rename Table
-- ============================================
-- Rename 'employees' table to 'staff'
-- ALTER TABLE employees
-- RENAME TO staff;

-- Alternative MySQL syntax:
-- RENAME TABLE employees TO staff;

-- ============================================
-- EXAMPLE 6: Add Constraints
-- ============================================
-- Add PRIMARY KEY constraint
-- ALTER TABLE employees
-- ADD PRIMARY KEY (emp_id);

-- Add UNIQUE constraint
ALTER TABLE employees
ADD UNIQUE (email_address);

-- Add CHECK constraint
ALTER TABLE employees
ADD CONSTRAINT check_salary CHECK (salary > 0);

-- Add FOREIGN KEY constraint
ALTER TABLE employees
ADD CONSTRAINT fk_dept_id 
FOREIGN KEY (department) REFERENCES departments(dept_name);

-- ============================================
-- EXAMPLE 7: Drop Constraints
-- ============================================
-- Drop UNIQUE constraint
ALTER TABLE employees
DROP INDEX email_address;

-- Drop FOREIGN KEY constraint
ALTER TABLE employees
DROP FOREIGN KEY fk_dept_id;

-- Drop CHECK constraint
ALTER TABLE employees
DROP CHECK check_salary;

-- ============================================
-- EXAMPLE 8: Change Column Position
-- ============================================
-- Move department column after hire_date
ALTER TABLE employees
MODIFY COLUMN department VARCHAR(50) AFTER hire_date;

-- ============================================
-- Verify Changes
-- ============================================
DESCRIBE employees;
SHOW COLUMNS FROM employees;
