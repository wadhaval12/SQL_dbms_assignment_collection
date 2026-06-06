-- ============================================
-- Chapter 1: Data Definition Language (DDL)
-- 03. Drop Table Command
-- ============================================
-- DROP TABLE removes an entire table from the database.
-- WARNING: This is irreversible - all data is lost!

USE company;

-- ============================================
-- DROP TABLE: Basic Syntax
-- ============================================
-- DROP TABLE table_name;

-- ============================================
-- SAFE DROP TABLE with IF EXISTS
-- ============================================
-- This prevents errors if the table doesn't exist
DROP TABLE IF EXISTS temp_table;

-- Drop multiple tables
DROP TABLE IF EXISTS table1, table2, table3;

-- ============================================
-- EXAMPLE: Drop with Dependencies
-- ============================================
-- If there are FOREIGN KEY constraints, you may need to:
-- 1. Drop dependent tables first
-- 2. Or disable foreign key checks (not recommended)

-- Option 1: Drop in correct order (child tables first, then parent)
DROP TABLE IF EXISTS orders;          -- Child table
DROP TABLE IF EXISTS order_items;    -- Child table
DROP TABLE IF EXISTS customers;      -- Parent table

-- Option 2: Temporarily disable foreign key checks (use with caution)
-- SET FOREIGN_KEY_CHECKS=0;
-- DROP TABLE customers;
-- SET FOREIGN_KEY_CHECKS=1;

-- ============================================
-- TRUNCATE vs DROP
-- ============================================
-- TRUNCATE: Deletes all rows but keeps table structure
--   - Faster than DELETE
--   - Resets AUTO_INCREMENT counter
--   - Less undo logs (more efficient)
-- DROP: Removes entire table including structure
--   - Must recreate table to use again
--   - Slower recovery from accidental delete

-- TRUNCATE example:
TRUNCATE TABLE employees;   -- Clears all data, keeps structure

-- Drop example:
-- DROP TABLE employees;    -- Removes table completely

-- ============================================
-- REAL-WORLD SCENARIOS
-- ============================================
-- Scenario 1: Cleanup during development
-- IF developing locally and want fresh start:
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS orders;

-- Scenario 2: Archive old data then drop
-- Best practice: Backup data before dropping
CREATE TABLE employees_backup AS
SELECT * FROM employees;
-- After verification, then drop:
-- DROP TABLE employees;

-- ============================================
-- IMPORTANT REMINDERS
-- ============================================
-- 1. ALWAYS backup data before dropping
-- 2. Use IF EXISTS to prevent errors in scripts
-- 3. Consider TRUNCATE if you only want to clear data
-- 4. Drop tables in correct order (children before parents)
-- 5. Turn off foreign key checks only when necessary
-- 6. This action CANNOT be undone - be careful!
