-- ============================================
-- Chapter 1: Additional Base Operations
-- 03. String Operations and Pattern Matching
-- ============================================
-- LIKE operator with wildcards % and _ for pattern matching
-- Additional string functions for manipulation

USE company;

-- ============================================
-- 1. LIKE OPERATOR: Basic Pattern Matching
-- ============================================
-- '%' wildcard: Zero or more characters
-- '_' wildcard: Exactly one character
-- Case-insensitive by default in MySQL

SELECT * FROM employees WHERE first_name LIKE 'J%';

-- ============================================
-- 2. PATTERN MATCHING: Starts With
-- ============================================
-- Find all employees whose first name starts with 'J'
SELECT first_name FROM employees WHERE first_name LIKE 'J%';

-- Find all employees whose last name starts with 'D'
SELECT first_name, last_name FROM employees WHERE last_name LIKE 'D%';

-- Find all emails starting with 'john'
SELECT email FROM employees WHERE email LIKE 'john%';

-- ============================================
-- 3. PATTERN MATCHING: Ends With
-- ============================================
-- Find all employees whose last name ends with 'son'
SELECT first_name, last_name FROM employees WHERE last_name LIKE '%son';

-- Find all emails ending with '.com'
SELECT email FROM employees WHERE email LIKE '%.com';

-- Find all departments ending with 's'
SELECT DISTINCT department FROM employees WHERE department LIKE '%s';

-- ============================================
-- 4. PATTERN MATCHING: Contains (Middle)
-- ============================================
-- Find all employees whose first name contains 'oh'
SELECT first_name FROM employees WHERE first_name LIKE '%oh%';

-- Find all emails containing 'email'
SELECT email FROM employees WHERE email LIKE '%email%';

-- ============================================
-- 5. SINGLE CHARACTER WILDCARD: _
-- ============================================
-- Exactly one character in the position
-- '_' represents exactly one character (any character)

-- Find names of length 4: B_b matches 'Bob'
SELECT first_name FROM employees WHERE first_name LIKE 'B_b';

-- Find names starting with 'J' and having 4 characters: J_h_ would match 'John'
SELECT first_name FROM employees WHERE first_name LIKE 'J___';

-- Find emails with format: xxx@email.com (where xxx is 3-4 chars)
SELECT email FROM employees WHERE email LIKE '____%@email.com';

-- ============================================
-- 6. COMBINING WILDCARDS
-- ============================================
-- Name with 'a' as second character
SELECT first_name FROM employees WHERE first_name LIKE '_a%';

-- Email with 'j' somewhere and '.com' at end
SELECT email FROM employees WHERE email LIKE '%j%@%.com';

-- ============================================
-- 7. NOT LIKE: Negative Pattern Matching
-- ============================================
-- Employees whose first name does NOT start with 'J'
SELECT first_name FROM employees WHERE first_name NOT LIKE 'J%';

-- Employees not in IT department
SELECT first_name, department FROM employees WHERE department NOT LIKE '%IT%';

-- ============================================
-- 8. CASE-SENSITIVE PATTERN MATCHING
-- ============================================
-- By default LIKE is case-insensitive
SELECT first_name FROM employees WHERE first_name LIKE 'john';  -- Matches 'John'

-- For case-sensitive matching, use BINARY
SELECT first_name FROM employees WHERE first_name LIKE BINARY 'john';  -- Matches only 'john'

-- ============================================
-- 9. ESCAPING SPECIAL CHARACTERS
-- ============================================
-- If pattern contains % or _, escape with backslash

-- Find product names containing '%' character
-- SELECT product_name FROM products WHERE product_name LIKE '%\%%' ESCAPE '\';

-- Find names with underscore
-- SELECT name FROM users WHERE name LIKE '%\__%' ESCAPE '\';

-- ============================================
-- 10. STRING FUNCTIONS
-- ============================================

-- LENGTH: Get string length
SELECT first_name, LENGTH(first_name) AS name_length FROM employees;

-- UPPER: Convert to uppercase
SELECT UPPER(first_name) AS uppercase_name FROM employees;

-- LOWER: Convert to lowercase
SELECT LOWER(first_name) AS lowercase_name FROM employees;

-- SUBSTRING: Extract portion of string
SELECT first_name, SUBSTRING(first_name, 1, 3) AS first_three FROM employees;

-- CONCAT: Combine strings
SELECT CONCAT(first_name, ' ', last_name) AS full_name FROM employees;

-- CONCAT_WS: Concatenate with separator
SELECT CONCAT_WS(' - ', first_name, last_name, email) FROM employees;

-- TRIM: Remove leading/trailing spaces
SELECT TRIM('  John  ') AS trimmed_name;

-- REPLACE: Replace part of string
SELECT first_name, REPLACE(first_name, 'o', '0') AS replaced FROM employees;

-- REVERSE: Reverse string
SELECT REVERSE(first_name) AS reversed FROM employees;

-- ============================================
-- 11. COMBINING PATTERN MATCHING WITH FUNCTIONS
-- ============================================

-- Find employees with first name starting with J (case-insensitive)
SELECT * FROM employees WHERE LOWER(first_name) LIKE 'j%';

-- Find employees whose email contains first name
SELECT * FROM employees 
WHERE email LIKE CONCAT('%', LOWER(first_name), '%');

-- Find long first names (more than 5 characters) starting with 'A'
SELECT first_name FROM employees 
WHERE first_name LIKE 'A%' AND LENGTH(first_name) > 5;

-- ============================================
-- 12. PRACTICAL EXAMPLES
-- ============================================

-- Example 1: Search for employees by partial name
SELECT * FROM employees
WHERE first_name LIKE '%ar%' OR last_name LIKE '%ar%';

-- Example 2: Find invalid emails (missing domain)
SELECT email FROM employees
WHERE email NOT LIKE '%@%.%';

-- Example 3: Find employees from specific cities (based on email domain)
SELECT first_name, email
FROM employees
WHERE email LIKE '%@gmail.com' OR email LIKE '%@yahoo.com';

-- Example 4: Department search
SELECT DISTINCT department FROM employees
WHERE department LIKE 'S%' OR department LIKE '%T%';

-- Example 5: Complex search - multi-criteria
SELECT first_name, email, salary
FROM employees
WHERE (first_name LIKE 'J%' OR last_name LIKE '%son')
  AND salary > 65000;

-- ============================================
-- 13. PERFORMANCE CONSIDERATIONS
-- ============================================
-- - LIKE with leading wildcard (e.g., '%name') is slower - avoid if possible
-- - LIKE with starting wildcard (e.g., 'name%') is faster - uses indexes
-- - Use LIKE only when pattern matching is needed
-- - For exact matches, use '=' instead of LIKE
-- - Index considerations: Create indexes on columns frequently searched with LIKE
