-- ============================================
-- ASSIGNMENT 1: DDL COMMANDS
-- Data Definition Language (CREATE, ALTER, DROP)
-- ============================================
-- This assignment tests your ability to:
-- 1. Create tables with proper structure
-- 2. Modify existing table schemas
-- 3. Drop tables and constraints
-- 4. Understand data types and constraints

USE practice_db;

-- ============================================
-- PROBLEM 1: Create Employee Table
-- ============================================
-- Create a table called 'employees' with the following requirements:
-- - emp_id: Integer, Primary Key, Auto-increment
-- - first_name: String (max 50 chars), Required
-- - last_name: String (max 50 chars), Required
-- - email: String (max 100 chars), Must be unique
-- - hire_date: Date
-- - salary: Decimal (10,2), Should not be negative
-- - department: String (max 50 chars)

-- YOUR SOLUTION HERE:
-- CREATE TABLE employees (...)


-- ============================================
-- PROBLEM 2: Add Columns to Existing Table
-- ============================================
-- Add the following columns to the employees table:
-- - phone: VARCHAR(20), Optional
-- - manager_id: INT, Optional (will reference emp_id)
-- - last_review_date: DATE, Optional

-- YOUR SOLUTION HERE:
-- ALTER TABLE employees ADD COLUMN ...


-- ============================================
-- PROBLEM 3: Create Department Table
-- ============================================
-- Create a departments table:
-- - dept_id: Integer, Primary Key, Auto-increment
-- - dept_name: String (max 50 chars), Required, Unique
-- - manager_id: Integer (can be NULL initially)
-- - budget: Decimal (12,2), Must be >= 0

-- YOUR SOLUTION HERE:
-- CREATE TABLE departments (...)


-- ============================================
-- PROBLEM 4: Modify Column Data Type
-- ============================================
-- In the employees table, change:
-- - email: From VARCHAR(100) to VARCHAR(150)
-- - salary: From DECIMAL(10,2) to DECIMAL(12,2)

-- YOUR SOLUTION HERE:
-- ALTER TABLE employees MODIFY COLUMN ...


-- ============================================
-- PROBLEM 5: Add Foreign Key Constraint
-- ============================================
-- Add a FOREIGN KEY constraint to the employees table
-- - Column: dept_id
-- - References: departments(dept_id)
-- Name the constraint: fk_emp_dept

-- First add the column if not exists:
-- ALTER TABLE employees ADD COLUMN dept_id INT;

-- Then add the foreign key:
-- YOUR SOLUTION HERE:
-- ALTER TABLE employees ADD CONSTRAINT ...


-- ============================================
-- PROBLEM 6: Add Check Constraint
-- ============================================
-- Add a CHECK constraint to ensure salary is positive
-- Name it: chk_positive_salary

-- YOUR SOLUTION HERE:
-- ALTER TABLE employees ADD CONSTRAINT ...


-- ============================================
-- PROBLEM 7: Drop a Constraint
-- ============================================
-- Drop the NOT NULL constraint from the phone column
-- (Make phone column nullable)

-- YOUR SOLUTION HERE:
-- ALTER TABLE employees MODIFY COLUMN phone VARCHAR(20) NULL;


-- ============================================
-- PROBLEM 8: Create a Projects Table
-- ============================================
-- Design a complete projects table with:
-- - project_id: INT, Primary Key, Auto-increment
-- - project_name: VARCHAR(100), NOT NULL, UNIQUE
-- - dept_id: INT, Foreign Key to departments(dept_id)
-- - start_date: DATE, NOT NULL
-- - end_date: DATE
-- - budget: DECIMAL(12,2), CHECK > 0
-- - status: VARCHAR(20), CHECK IN ('Planning', 'Active', 'Completed', 'Cancelled')

-- YOUR SOLUTION HERE:
-- CREATE TABLE projects (...)


-- ============================================
-- PROBLEM 9: Rename a Column
-- ============================================
-- In the employees table, rename:
-- - hire_date TO employment_date

-- YOUR SOLUTION HERE:
-- ALTER TABLE employees RENAME COLUMN ...


-- ============================================
-- PROBLEM 10: View Table Structure
-- ============================================
-- Show the structure of the employees table

-- YOUR SOLUTION HERE:
-- DESCRIBE employees;


-- ============================================
-- EXPECTED OUTPUTS
-- ============================================
-- Problem 1: Table created successfully
-- Problem 2: 3 columns added
-- Problem 3: departments table created with constraints
-- Problem 4: Column data types modified
-- Problem 5: Foreign key constraint added
-- Problem 6: Check constraint added (salary > 0)
-- Problem 7: phone column now allows NULL
-- Problem 8: projects table created with all constraints
-- Problem 9: Column renamed successfully
-- Problem 10: Table structure displayed with all columns

-- ============================================
-- BONUS CHALLENGES
-- ============================================

-- BONUS 1: Create Employee Skills Table
-- Design a junction table for employees and their skills
-- - emp_id: INT, Foreign Key
-- - skill_id: INT, Foreign Key
-- - proficiency_level: INT, CHECK BETWEEN 1 AND 5
-- - PRIMARY KEY: (emp_id, skill_id)

-- BONUS 2: Add a Computed Column
-- Add a computed column to employees showing years of service
-- (Challenge: MySQL doesn't support generated columns in all versions)

-- BONUS 3: Create an Audit Table
-- Create a table to track changes to employees
-- Store: audit_id, emp_id, action (INSERT/UPDATE/DELETE), change_date, old_value, new_value

-- ============================================
-- LEARNING OUTCOMES
-- ============================================
-- After completing this assignment, you should be able to:
-- ✅ Create well-designed tables with proper structure
-- ✅ Apply appropriate data types for different values
-- ✅ Enforce constraints at the table level
-- ✅ Modify existing tables safely
-- ✅ Create relationships using foreign keys
-- ✅ Rename and drop columns appropriately
-- ✅ Use composite primary keys for junction tables
-- ✅ Understand the difference between constraints
