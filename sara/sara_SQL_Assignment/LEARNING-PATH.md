# 📖 MySQL Mastery - Learning Path Guide

This document outlines the recommended sequence for studying this repository to master MySQL according to your classroom curriculum.

---

## 🎓 Study Timeline: 11 Weeks to Mastery

### **WEEK 1-2: Foundation - DDL Commands**

**Objective**: Understand how to create and manage database structures

**Files to Study:**
- `Chapter-1-Introduction-to-SQL/01-DDL-Commands/01-Create-Table-Construct.sql`
- `Chapter-1-Introduction-to-SQL/01-DDL-Commands/02-Alter-Table-Commands.sql`
- `Chapter-1-Introduction-to-SQL/01-DDL-Commands/03-Drop-Table-Command.sql`

**Practice:**
- Complete `Practice-Assignments/Assignment-1-DDL-Commands.sql`

**Key Concepts to Master:**
- Creating tables with CREATE TABLE
- Data types (INT, VARCHAR, DATE, DECIMAL, etc.)
- Constraints at table creation
- Modifying tables with ALTER TABLE
- Dropping tables and constraints safely

**Expected Outcome:** You can design and create normalized database tables

---

### **WEEK 2-3: Basic Query Components - SELECT, WHERE, FROM**

**Objective**: Learn fundamental SQL querying

**Files to Study (IN ORDER):**
1. `Chapter-1-Introduction-to-SQL/02-Basic-Query-Components/01-SELECT-Clause.sql`
2. `Chapter-1-Introduction-to-SQL/02-Basic-Query-Components/02-WHERE-Clause.sql`
3. `Chapter-1-Introduction-to-SQL/02-Basic-Query-Components/03-FROM-Clause.sql`

**Practice:**
- Complete `Practice-Assignments/Assignment-2-Basic-Queries.sql`

**Key Concepts to Master:**
- SELECT with column projections
- Using aliases with AS
- Arithmetic expressions in SELECT
- WHERE clause with various predicates
- Logical operators (AND, OR, NOT)
- FROM clause and Cartesian products

**Expected Outcome:** You can retrieve and filter data precisely

---

### **WEEK 4: Additional Base Operations**

**Objective**: Enhance your querying capabilities

**Files to Study:**
- `Chapter-1-Introduction-to-SQL/03-Additional-Base-Operations/01-Rename-AS-Clause.sql`
- `Chapter-1-Introduction-to-SQL/03-Additional-Base-Operations/02-Self-Join-Queries.sql`
- `Chapter-1-Introduction-to-SQL/03-Additional-Base-Operations/03-String-Operations-Pattern-Matching.sql`
- `Chapter-1-Introduction-to-SQL/03-Additional-Base-Operations/04-Order-By-Clause.sql`

**Practice:**
- Experiment with renaming and aliasing
- Create self-join queries on sample data
- Practice LIKE pattern matching

**Key Concepts to Master:**
- Column aliasing for clarity
- Self joins for comparing table instances
- Pattern matching with LIKE (%, _)
- String functions
- ORDER BY with ASC/DESC

**Expected Outcome:** You can write sophisticated single-table queries

---

### **WEEK 5: Set Operations**

**Objective**: Combine multiple query results

**Files to Study:**
- `Chapter-1-Introduction-to-SQL/04-Set-Operations/01-Union-Union-All.sql`
- `Chapter-1-Introduction-to-SQL/04-Set-Operations/02-Intersect-Intersect-All.sql`
- `Chapter-1-Introduction-to-SQL/04-Set-Operations/03-Except-Except-All.sql`

**Practice:**
- Combine multiple SELECT statements
- Understand UNION vs UNION ALL
- Simulate INTERSECT and EXCEPT

**Key Concepts to Master:**
- UNION for combining result sets
- UNION ALL for including duplicates
- INTERSECT for finding common rows
- EXCEPT for finding differences
- Set operation performance considerations

**Expected Outcome:** You can combine data from multiple queries

---

### **WEEK 5-6: NULL Handling & CHAPTER 1 REVIEW**

**Objective**: Handle missing data correctly

**Files to Study:**
- `Chapter-1-Introduction-to-SQL/05-Null-Value-Handling/01-Null-Check-Predicates.sql`

**Practice:**
- Test NULL in various contexts
- Use COALESCE and IFNULL
- Review all Chapter 1 concepts

**Key Concepts to Master:**
- IS NULL and IS NOT NULL
- NULL in aggregates
- NULL in joins
- COALESCE function
- NULL sorting behavior

**Expected Outcome:** Chapter 1 mastery - you understand fundamental SQL

---

### **WEEK 7: Aggregate Functions**

**Objective**: Compute summary statistics

**Files to Study (IN ORDER):**
1. `Chapter-2-Advanced-SQL/01-Aggregate-Functions/01-Basic-Column-Aggregations.sql`
2. `Chapter-2-Advanced-SQL/01-Aggregate-Functions/02-Group-By-Clause.sql`
3. `Chapter-2-Advanced-SQL/01-Aggregate-Functions/03-Having-Clause.sql`

**Practice:**
- Complete `Practice-Assignments/Assignment-3-Aggregate-Functions.sql`

**Key Concepts to Master:**
- COUNT, SUM, AVG, MIN, MAX
- GROUP BY for partitioning
- HAVING for group filtering
- Difference between WHERE and HAVING
- Using aggregates in ORDER BY

**Expected Outcome:** You can create summary reports and statistics

---

### **WEEK 8: Data Modification (DML)**

**Objective**: Insert, update, and delete data

**Files to Study:**
- `Chapter-2-Advanced-SQL/03-Database-Modification-Commands/01-Insert-Commands.sql`
- `Chapter-2-Advanced-SQL/03-Database-Modification-Commands/02-Update-Commands.sql`
- `Chapter-2-Advanced-SQL/03-Database-Modification-Commands/03-Delete-Commands.sql`

**Practice:**
- Create test tables and insert various data
- Practice UPDATE with different conditions
- Safely test DELETE operations

**Key Concepts to Master:**
- INSERT single and multiple rows
- INSERT from SELECT
- UPDATE with WHERE conditions
- DELETE safely with WHERE
- Using TRUNCATE vs DELETE
- Transaction safety

**Expected Outcome:** You can manage data lifecycle safely

---

### **WEEK 9: Data Constraints**

**Objective**: Enforce data integrity

**Files to Study:**
- `Chapter-2-Advanced-SQL/04-Data-Constraints/01-Primary-Key.sql`
- `Chapter-2-Advanced-SQL/04-Data-Constraints/02-Foreign-Key.sql`
- `Chapter-2-Advanced-SQL/04-Data-Constraints/03-Not-Null-Constraint.sql`
- `Chapter-2-Advanced-SQL/04-Data-Constraints/04-Unique-And-Check-Constraints.sql`

**Practice:**
- Design tables with comprehensive constraints
- Test constraint violations
- Understand referential integrity

**Key Concepts to Master:**
- PRIMARY KEY uniqueness
- FOREIGN KEY relationships
- NOT NULL enforcement
- UNIQUE constraints
- CHECK constraints
- Constraint naming and management

**Expected Outcome:** You design robust database schemas

---

### **WEEK 10: Advanced JOINs**

**Objective**: Combine data from multiple tables

**Files to Study:**
- `Chapter-3-Intermediate-SQL/01-Advanced-Join-Expressions/01-Joins-Comprehensive.sql`

**Practice:**
- Create multi-table queries
- Practice different join types
- Complete assignment on JOINs (Coming soon)

**Key Concepts to Master:**
- INNER JOIN
- LEFT OUTER JOIN
- RIGHT OUTER JOIN
- FULL OUTER JOIN
- CROSS JOIN
- NATURAL JOIN
- Multiple joins in one query
- JOIN conditions vs WHERE

**Expected Outcome:** You can combine data from multiple tables effectively

---

### **WEEK 10-11: Views & Triggers**

**Objective**: Create database objects for automation and abstraction

**Files to Study:**
- `Chapter-3-Intermediate-SQL/02-View-Architectures/01-Create-View.sql`
- `Chapter-3-Intermediate-SQL/03-Triggers/01-Introduction-to-Triggers.sql`

**Practice:**
- Create views for common queries
- Design triggers for data validation
- Test trigger functionality

**Key Concepts to Master:**
- VIEW definition and usage
- Materialized vs computed views
- WITH CHECK OPTION
- BEFORE and AFTER triggers
- Trigger use cases
- Debugging triggers

**Expected Outcome:** You can create automated, maintainable database solutions

---

## 📊 Study Progress Checklist

### Chapter 1: Introduction to SQL
- [ ] DDL Commands (CREATE, ALTER, DROP)
- [ ] SELECT Clause (projections, expressions)
- [ ] WHERE Clause (conditions, operators)
- [ ] FROM Clause (tables, joins)
- [ ] Additional Operations (aliases, self joins, patterns, ordering)
- [ ] Set Operations (UNION, INTERSECT, EXCEPT)
- [ ] NULL Value Handling

### Chapter 2: Advanced SQL
- [ ] Aggregate Functions (COUNT, SUM, AVG, MIN, MAX)
- [ ] GROUP BY Clause
- [ ] HAVING Clause
- [ ] INSERT Commands
- [ ] UPDATE Commands
- [ ] DELETE Commands
- [ ] Primary Keys
- [ ] Foreign Keys
- [ ] NOT NULL Constraints
- [ ] UNIQUE and CHECK Constraints

### Chapter 3: Intermediate SQL
- [ ] Advanced JOINs (INNER, LEFT, RIGHT, FULL, CROSS)
- [ ] Views
- [ ] Triggers

---

## 🎯 Assignment Completion Order

1. **Assignment 1**: DDL Commands (Week 2)
2. **Assignment 2**: Basic Queries (Week 3-4)
3. **Assignment 3**: Aggregate Functions (Week 7)
4. **Assignment 4**: JOINs (Week 10)
5. **Assignment 5**: Subqueries (Coming soon)
6. **Assignment 6**: Views (Week 11)
7. **Assignment 7**: Triggers (Week 11)

---

## 💡 Study Tips

### Daily Routine (1 hour minimum)
- **15 min**: Review yesterday's material
- **20 min**: Study new concept from file
- **20 min**: Practice on sample data
- **5 min**: Note any questions

### Best Practices
- **Execute code**, don't just read
- **Modify examples** to understand behavior
- **Create sample data** for testing
- **Complete all assignments** before moving on
- **Revisit difficult topics** multiple times

### Resources During Study
- Use MySQL Workbench for GUI convenience
- Or use command line for pure SQL experience
- Keep query output visible while learning
- Document your understanding in notes

---

## 🏆 Success Metrics

After each week, you should be able to:

- **Week 1-2**: Design and create normalized tables
- **Week 2-3**: Write SELECT queries with WHERE filters
- **Week 4**: Use aliases, self joins, and pattern matching
- **Week 5**: Combine result sets with set operations
- **Week 6**: Handle NULL values appropriately
- **Week 7**: Create summary reports with aggregates
- **Week 8**: Insert, update, and delete data safely
- **Week 9**: Design tables with proper constraints
- **Week 10**: Combine data from multiple tables
- **Week 11**: Create views and automate with triggers

---

## 📝 Assignment Submission Tips

For your teacher:
1. Comment your code explaining your logic
2. Include expected outputs
3. Test edge cases (NULL, empty sets, etc.)
4. Format queries readably
5. Explain why you chose your approach

---

## 🚀 After Completing This Repository

- Practice with real datasets
- Design your own database
- Optimize slow queries
- Learn advanced topics (stored procedures, functions)
- Practice for technical interviews
- Contribute to open-source databases

---

**Remember**: SQL mastery comes from **practice and experimentation**. Don't just read—write queries, make mistakes, and learn from them!

Good luck! Your teacher will be impressed! 🎉
