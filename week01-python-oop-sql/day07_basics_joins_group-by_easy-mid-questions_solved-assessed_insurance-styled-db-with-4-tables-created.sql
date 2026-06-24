-- Basics, joins, group by, having, joins, order by
-- Created two databases: 
-- 1. [employees_59_days] For practice and did assessment on this database (50 questions total with easy and mid level), answered and later evaluated using claude.
-- 2. [insurance_59_days] created schema with constraints for project.

SHOW DATABASES;

CREATE DATABASE employees_59_days;

USE employees_59_days;

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

INSERT INTO Departments VALUES
(1, 'Engineering'),
(2, 'HR'),
(3, 'Finance'),
(4, 'Marketing');

CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    salary DECIMAL(10,2),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

INSERT INTO Employees VALUES
(101, 'Alice', 90000, 1),
(102, 'Bob', 80000, 1),
(103, 'Charlie', 60000, 2),
(104, 'David', 75000, 3),
(105, 'Eva', 70000, 1),
(106, 'Frank', 65000, 4),
(107, 'Grace', 85000, 3);

CREATE TABLE Projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(100),
    budget DECIMAL(12,2)
);

INSERT INTO Projects VALUES
(201, 'CRM System', 500000),
(202, 'Mobile App', 300000),
(203, 'Payroll Upgrade', 150000),
(204, 'Marketing Campaign', 200000);

CREATE TABLE EmployeeProjects (
    employee_id INT,
    project_id INT,
    PRIMARY KEY (employee_id, project_id),
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id),
    FOREIGN KEY (project_id)  REFERENCES Projects(project_id)
);

INSERT INTO EmployeeProjects VALUES
(101, 201),
(101, 202),
(102, 201),
(103, 203),
(104, 203),
(105, 202),
(106, 204);

SELECT * FROM departments;
SELECT * FROM employees;
SELECT * FROM projects;
SELECT * FROM employeeprojects;

SELECT * FROM employees WHERE salary > 75000;
SELECT department_id, employee_name FROM employees GROUP BY department_id HAVING max(salary);

-----------------------------------------------------------------------------------------------------------

-- ============================================================
--   SQL INTERVIEW PREPARATION  |  50 Practice Questions
--   Schema: Departments, Employees, Projects, EmployeeProjects
--   EASY: Q1–Q35  |  MID: Q36–Q50
-- ============================================================


-- ══════════════════════════════════════════
--   EASY QUESTIONS (Q1–Q35)
-- ══════════════════════════════════════════


-- Q1. Retrieve all columns from the Employees table. [EASY]

SELECT *
FROM employees;

-- ✅ RATING: 10/10
-- EVALUATION: Perfect. Clean and correct.
-- TIP: In interviews, mention that SELECT * is fine for exploration but in production
--      you should list explicit columns to avoid fetching unnecessary data.


-- Q2. Fetch only the employee_name and salary columns from the Employees table. [EASY]

SELECT employee_name, salary
FROM employees;

-- ✅ RATING: 10/10
-- EVALUATION: Correct and clean.
-- TIP: Good habit — always prefer explicit column selection over SELECT *.


-- Q3. List all employees whose salary is greater than 75000. [EASY]

SELECT *
FROM employees
WHERE salary > 75000;

-- ✅ RATING: 10/10
-- EVALUATION: Correct. Strict greater-than is exactly what was asked.
-- TIP: Know the difference between > (strict) and >= (inclusive). Interviewers
--      love testing this boundary.


-- Q4. Count the total number of employees in the Employees table. [EASY]

SELECT COUNT(*)
FROM employees;

-- ✅ RATING: 10/10
-- EVALUATION: Correct.
-- TIP: COUNT(*) counts all rows including NULLs. COUNT(column) skips NULLs.
--      Knowing this distinction is a common interview trap.


-- Q5. Find the maximum salary among all employees. [EASY]

SELECT max(salary)
FROM employees;

-- ✅ RATING: 9/10
-- EVALUATION: Correct result. Minor style note: use uppercase MAX() for consistency
--             with SQL convention.
-- TIP: Add an alias — SELECT MAX(salary) AS max_salary — for cleaner output,
--      especially when this becomes a subquery.


-- Q6. Find the minimum salary among all employees. [EASY]

SELECT min(salary)
FROM employees;

-- ✅ RATING: 9/10
-- EVALUATION: Correct. Same note as Q5 — prefer uppercase MIN() and add alias.
-- TIP: SELECT MIN(salary) AS min_salary FROM employees;


-- Q7. Calculate the average salary of all employees. [EASY]

SELECT avg(salary)
FROM employees;

-- ✅ RATING: 9/10
-- EVALUATION: Correct. Uppercase AVG() and alias preferred.
-- TIP: SELECT ROUND(AVG(salary), 2) AS avg_salary — ROUND() is great to combine
--      with AVG() to avoid ugly floating-point output in interviews.


-- Q8. Retrieve all departments ordered alphabetically by department_name. [EASY]

SELECT *
FROM departments
ORDER BY department_name;

-- ✅ RATING: 10/10
-- EVALUATION: Correct. ASC is the default so no need to write it explicitly,
--             though writing ORDER BY department_name ASC is also acceptable.
-- TIP: Always clarify ASC/DESC in interviews to show intentionality.


-- Q9. Fetch all employees sorted by salary in descending order. [EASY]

SELECT *
FROM employees
ORDER BY salary DESC;

-- ✅ RATING: 10/10
-- EVALUATION: Correct.
-- TIP: You can chain ORDER BY: ORDER BY salary DESC, employee_name ASC
--      for tie-breaking — good to mention in interviews.


-- Q10. Find all distinct department_id values present in the Employees table. [EASY]

SELECT DISTINCT(department_id)
FROM employees;

-- ✅ RATING: 9/10
-- EVALUATION: Correct result. Note: DISTINCT is not a function — the parentheses
--             around department_id are redundant (though harmless).
--             Write: SELECT DISTINCT department_id FROM employees;
-- TIP: DISTINCT applies to the full row, not just one column. So
--      SELECT DISTINCT dept_id, salary gives distinct combinations, not just dept_ids.


-- Q11. Display employee_name and salary for employees earning between 65000 and 85000 (inclusive). [EASY]

SELECT employee_name, salary
FROM employees
WHERE salary BETWEEN 65000 AND 85000;

-- ✅ RATING: 10/10
-- EVALUATION: Correct. BETWEEN is inclusive on both ends, which is what was asked.
-- TIP: BETWEEN works on dates and strings too — a frequent interview extension question.


-- Q12. Fetch the top 3 highest-paid employees. [EASY]

SELECT *
FROM employees;
-- CHECK

-- ❌ RATING: 0/10
-- EVALUATION: Not attempted. You left a placeholder comment but forgot to come back.
-- CORRECT ANSWER:
--   SELECT * FROM employees ORDER BY salary DESC LIMIT 3;
-- TIP: ORDER BY + LIMIT is the standard MySQL approach. In SQL Server it's TOP 3,
--      in Oracle it's FETCH FIRST 3 ROWS ONLY. Know these variants for interviews.


-- Q13. List all employees whose name starts with the letter 'A'. [EASY]

SELECT *
FROM employees
WHERE employee_name LIKE 'A%';

-- ✅ RATING: 10/10
-- EVALUATION: Correct. % matches zero or more characters.
-- TIP: Know all LIKE wildcards: % (any sequence), _ (exactly one character).
--      Example: LIKE '_a%' finds names where second letter is 'a'.


-- Q14. Count the total number of projects in the Projects table. [EASY]

SELECT COUNT(*)
FROM projects;

-- ✅ RATING: 10/10
-- EVALUATION: Correct.
-- TIP: Same COUNT(*) vs COUNT(col) note from Q4 applies here.


-- Q15. Find the total budget across all projects. [EASY]

SELECT SUM(budget)
FROM projects;

-- ✅ RATING: 9/10
-- EVALUATION: Correct. Add alias for cleaner output.
-- TIP: SELECT SUM(budget) AS total_budget FROM projects;


-- Q16. Retrieve all projects with a budget greater than 200000. [EASY]

SELECT *
FROM projects
WHERE budget > 200000;

-- ✅ RATING: 10/10
-- EVALUATION: Correct. Strict greater-than correctly excludes the 200000 budget row.
-- TIP: If the question said "at least 200000" you'd use >= . Always read boundary
--      wording carefully in interviews.


-- Q17. Find all employees who belong to department_id = 1 (Engineering). [EASY]

SELECT *
FROM employees
WHERE department_id = 1;

-- ✅ RATING: 10/10
-- EVALUATION: Correct.
-- TIP: In a real interview, you might JOIN to show department_name instead of just
--      filtering by id — shows initiative.


-- Q18. Fetch the employee with the highest salary. [EASY]

SELECT salary
FROM employees
GROUP BY salary
HAVING max(salary)
ORDER BY salary DESC
LIMIT 1;

-- ⚠️  RATING: 3/10
-- EVALUATION: This produces a result but the logic is conceptually wrong.
--             GROUP BY salary + HAVING MAX(salary) does not mean what you think —
--             HAVING MAX(salary) evaluates to TRUE for every group (any non-zero
--             value is truthy), so you're just grouping all salaries and picking
--             the top one by ORDER BY. Also, you're only SELECTing salary, not the
--             employee details. This would not pass an interview review.
-- CORRECT ANSWER:
--   SELECT * FROM employees ORDER BY salary DESC LIMIT 1;
-- TIP: For "highest salary employee" — ORDER BY DESC + LIMIT 1 is the cleanest.
--      For "employee(s) tied at the top" use a subquery:
--      SELECT * FROM employees WHERE salary = (SELECT MAX(salary) FROM employees);


-- Q19. Find all employees whose salary is NOT equal to 80000. [EASY]

SELECT *
FROM employees
WHERE salary != 80000;

-- ✅ RATING: 10/10
-- EVALUATION: Correct. != and <> are both valid in MySQL.
-- TIP: <> is ANSI standard and more portable across databases. Prefer <> in
--      cross-DB interviews, but != is perfectly fine in MySQL.


-- Q20. Display all columns of the Projects table sorted by budget in ascending order. [EASY]

SELECT *
FROM projects
ORDER BY budget;

-- ✅ RATING: 10/10
-- EVALUATION: Correct. ASC is default, so this is fine.
-- TIP: Explicitly writing ORDER BY budget ASC shows intentionality in interviews.


-- Q21. Fetch all records from EmployeeProjects for employee_id = 101. [EASY]

SELECT *
FROM employeeprojects
WHERE employee_id = 101;

-- ✅ RATING: 10/10
-- EVALUATION: Correct.
-- TIP: Good candidate to extend with a JOIN to show project_name instead of
--      just project_id — useful to mention in interviews.


-- Q22. Count how many employees are in each department (using GROUP BY). [EASY]

SELECT department_id, COUNT(employee_id)
FROM employees
GROUP BY department_id;

-- ✅ RATING: 9/10
-- EVALUATION: Correct logic. Add alias for the COUNT column.
-- TIP: SELECT department_id, COUNT(employee_id) AS employee_count
--      Unaliased aggregates are hard to reference downstream (e.g., in HAVING or CTEs).


-- Q23. Calculate the total salary paid per department. [EASY]

SELECT department_id, SUM(salary)
FROM employees
GROUP BY department_id;

-- ✅ RATING: 9/10
-- EVALUATION: Correct. Add alias: SUM(salary) AS total_salary.
-- TIP: Consider JOINing Departments to show department_name alongside — interviewers
--      appreciate that extra step.


-- Q24. Find departments that have more than 1 employee. [EASY]

SELECT department_id, COUNT(department_id) AS count_of_emp
FROM employees
GROUP BY department_id
HAVING count_of_emp > 1;

-- ✅ RATING: 10/10
-- EVALUATION: Correct and well-aliased. Using the alias in HAVING works in MySQL
--             (MySQL allows this, though ANSI SQL requires repeating the expression).
-- TIP: In strict ANSI SQL: HAVING COUNT(department_id) > 1. Know both for portability.


-- Q25. List all project names and their budgets where the budget is between 150000 and 400000. [EASY]

SELECT *
FROM projects
WHERE budget BETWEEN 150000 AND 400000;

-- ✅ RATING: 9/10
-- EVALUATION: Correct result. Question asked for "project names and their budgets"
--             specifically, so SELECT project_name, budget is more precise than SELECT *.
-- TIP: Match your SELECT columns to what the question explicitly asks for —
--      interviewers notice this attention to detail.


-- Q26. Using an alias, display employee_name as 'Name' and salary as 'Monthly CTC'. [EASY]

SELECT *, employee_name AS Name, salary AS 'Monthly CTC'
FROM employees;

-- ⚠️  RATING: 5/10
-- EVALUATION: This works but SELECT * alongside aliased columns means employee_name
--             and salary appear TWICE in the output — once from *, once aliased.
--             That's redundant and messy.
-- CORRECT ANSWER:
--   SELECT employee_name AS Name, salary AS 'Monthly CTC' FROM employees;
-- TIP: Never mix SELECT * with specific aliased columns unless you have a clear reason.
--      Aliases with spaces need quotes: 'Monthly CTC' or `Monthly CTC`.


-- Q27. Find how many projects each employee is assigned to, using the EmployeeProjects table. [EASY]

SELECT employee_id, COUNT(project_id)
FROM employeeprojects
GROUP BY employee_id;

-- ✅ RATING: 9/10
-- EVALUATION: Correct. Add alias: COUNT(project_id) AS project_count.
-- TIP: Extend this by JOINing Employees to show employee_name alongside — good
--      interview habit to think about readability.


-- Q28. Fetch all employees whose employee_id is in the list (101, 103, 105). [EASY]

SELECT *
FROM employees
WHERE employee_id IN (101, 103, 105);

-- ✅ RATING: 10/10
-- EVALUATION: Correct. IN is cleaner than chaining multiple OR conditions.
-- TIP: IN can also take a subquery: WHERE employee_id IN (SELECT employee_id FROM ...).
--      This is a bridge to Q30 and Q48 — interviewers often escalate this way.


-- Q29. Find the sum of salaries for employees in department_id = 3 (Finance). [EASY]

SELECT employee_id, SUM(salary)
FROM employees
WHERE department_id = 3
GROUP BY employee_id;

-- ⚠️  RATING: 5/10
-- EVALUATION: Logically off. Each employee has only one salary row, so grouping by
--             employee_id gives you individual salaries, not a department total.
--             The question asks for a single total for the department.
-- CORRECT ANSWER:
--   SELECT SUM(salary) AS total_salary FROM employees WHERE department_id = 3;
-- TIP: When the question says "sum of salaries FOR a department", filter first with WHERE,
--      then aggregate — no GROUP BY needed. GROUP BY is for "per group" breakdowns.


-- Q30. Find employees who are NOT assigned to any project (using NOT IN or NOT EXISTS). [EASY]

SELECT * 
FROM employees 
WHERE employee_id NOT IN (
    SELECT employee_id
    FROM employeeprojects
    );

SELECT *
FROM employees AS e
LEFT JOIN employeeprojects AS ep
ON e.employee_id = ep.employee_id
WHERE ep.project_id IS NULL;

-- ✅ RATING: 10/10
-- EVALUATION: Excellent — you wrote BOTH valid approaches (NOT IN subquery and
--             LEFT JOIN + IS NULL). This is exactly what strong candidates do.
-- TIP: Be aware that NOT IN has a NULL trap: if the subquery returns even one NULL,
--      the entire NOT IN returns no rows. NOT EXISTS is NULL-safe. Mentioning this
--      in an interview is a green flag.


-- Q31. Retrieve all employees along with their department names using an INNER JOIN. [EASY]

SELECT employee_id, employee_name
FROM employees AS e
JOIN departments AS d
ON e.department_id = d.department_id;

-- ⚠️  RATING: 6/10
-- EVALUATION: JOIN logic is correct but you forgot to include department_name in
--             the SELECT — which is the whole point of the JOIN.
-- CORRECT ANSWER:
--   SELECT e.employee_id, e.employee_name, d.department_name
--   FROM employees AS e
--   JOIN departments AS d ON e.department_id = d.department_id;
-- TIP: Always table-prefix ambiguous columns (e.department_id vs d.department_id)
--      when joining. Good habit even when not strictly required.


-- Q32. List all departments along with the number of employees in each, including departments with zero employees. (LEFT JOIN) [EASY]

SELECT *
FROM employees AS e
LEFT JOIN departments as d
ON e.department_id = d.department_id;

-- ❌ RATING: 2/10
-- EVALUATION: Two issues:
--   1. Direction is wrong — to include departments WITH ZERO employees, Departments
--      must be on the LEFT, Employees on the RIGHT. You have it reversed.
--   2. No COUNT or GROUP BY — the question asks for a count per department,
--      not a raw join dump.
-- CORRECT ANSWER:
--   SELECT d.department_id, d.department_name, COUNT(e.employee_id) AS employee_count
--   FROM departments AS d
--   LEFT JOIN employees AS e ON d.department_id = e.department_id
--   GROUP BY d.department_id, d.department_name;
-- TIP: The table on the LEFT of LEFT JOIN is the "preserving" table — all its rows
--      appear even with no match. Always ask: "which side must show all rows?"


-- Q33. Get the names of employees and the projects they are assigned to using appropriate JOINs. [EASY]

SELECT employee_name, project_name
FROM employees AS e
JOIN employeeprojects AS ep
ON e.employee_id = ep.employee_id
JOIN projects AS p
ON p.project_id = ep.project_id;

-- ✅ RATING: 10/10
-- EVALUATION: Correct multi-table JOIN through the bridge table. Clean and precise.
-- TIP: EmployeeProjects is a classic junction/bridge table for M:N relationships.
--      This 3-table JOIN pattern is very commonly tested. You nailed it.


-- Q34. Find all employees and their department names, including employees who may not belong to any department. [EASY]

SELECT *
FROM departments as d
LEFT JOIN employees AS e
ON e.department_id = d.department_id
WHERE d.department_id IS NULL;

-- ❌ RATING: 2/10
-- EVALUATION: Two issues:
--   1. The question says "employees who may not belong to any department" — so
--      Employees must be on the LEFT to preserve all employees. You have Departments
--      on the left, which preserves all departments instead.
--   2. WHERE d.department_id IS NULL filters to only unmatched rows — this is the
--      anti-join pattern, not the full employee list with their departments.
-- CORRECT ANSWER:
--   SELECT e.employee_name, d.department_name
--   FROM employees AS e
--   LEFT JOIN departments AS d ON e.department_id = d.department_id;
-- TIP: Re-read the question: "all employees + their dept name" = Employees LEFT JOIN
--      Departments. The IS NULL filter is for anti-join use cases only (find employees
--      with NO dept). Don't mix the two patterns.


-- Q35. Display each employee's name, department name, and salary, sorted by department name then salary descending. [EASY]

SELECT e.employee_name, d.department_name, e.salary
FROM employees AS e
JOIN departments AS d
ON e.department_id = d.department_id
ORDER BY e.salary DESC;

-- ⚠️  RATING: 7/10
-- EVALUATION: JOIN and column selection are correct, but the ORDER BY is incomplete.
--             Question asks for ORDER BY department_name first, THEN salary DESC.
--             You only sorted by salary DESC.
-- CORRECT ANSWER:
--   SELECT e.employee_name, d.department_name, e.salary
--   FROM employees AS e
--   JOIN departments AS d ON e.department_id = d.department_id
--   ORDER BY d.department_name ASC, e.salary DESC;
-- TIP: Multi-column ORDER BY is very commonly tested. The order of columns in
--      ORDER BY matters — first sort key takes priority.


-- ══════════════════════════════════════════
--   MID-LEVEL QUESTIONS (Q36–Q50)
-- ══════════════════════════════════════════


-- Q36. Using a subquery, find all employees who earn more than the average salary. [MID]

-- ⬜ NOT ATTEMPTED — RATING: 0/10
-- CORRECT ANSWER:
--   SELECT * FROM employees
--   WHERE salary > (SELECT AVG(salary) FROM employees);
-- TIP: This is the most classic subquery pattern in SQL interviews. The inner query
--      runs first, returns a single value, and the outer WHERE filters against it.
--      Practice this until it's muscle memory.


-- Q37. Rank employees by salary within each department using a window function (RANK() or DENSE_RANK()). [MID]

-- ⬜ NOT ATTEMPTED — RATING: 0/10
-- CORRECT ANSWER:
--   SELECT employee_name, department_id, salary,
--          RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS salary_rank
--   FROM employees;
-- TIP: Know RANK() vs DENSE_RANK() vs ROW_NUMBER():
--      RANK()       → gaps after ties (1,1,3)
--      DENSE_RANK() → no gaps       (1,1,2)
--      ROW_NUMBER() → no ties, sequential (1,2,3)
--      Interviewers frequently ask you to explain the difference.


-- Q38. Find the second-highest salary in the Employees table without using LIMIT/TOP. [MID]

-- ⬜ NOT ATTEMPTED — RATING: 0/10
-- CORRECT ANSWER (subquery approach):
--   SELECT MAX(salary) AS second_highest
--   FROM employees
--   WHERE salary < (SELECT MAX(salary) FROM employees);
--
-- ALTERNATIVE (window function):
--   SELECT DISTINCT salary FROM (
--       SELECT salary, DENSE_RANK() OVER (ORDER BY salary DESC) AS rnk
--       FROM employees
--   ) ranked
--   WHERE rnk = 2;
-- TIP: The "Nth highest salary" family of questions is one of the most asked SQL
--      interview questions globally. Learn both approaches cold.


-- Q39. Using a CTE (WITH clause), list departments where the average salary exceeds 75000. [MID]

-- ⬜ NOT ATTEMPTED — RATING: 0/10
-- CORRECT ANSWER:
--   WITH dept_avg AS (
--       SELECT department_id, AVG(salary) AS avg_salary
--       FROM employees
--       GROUP BY department_id
--   )
--   SELECT d.department_name, da.avg_salary
--   FROM dept_avg AS da
--   JOIN departments AS d ON da.department_id = d.department_id
--   WHERE da.avg_salary > 75000;
-- TIP: CTEs improve readability over nested subqueries and are reusable within the
--      same query. They are heavily tested in mid-to-senior SQL interviews.
--      Think of a CTE as a named temporary result set.


-- Q40. Find employees who are working on more than one project. [MID]

SELECT project_id, COUNT(project_id)
FROM employeeprojects AS ep1
JOIN employeeprojects AS ep2
ON ep1.employee_id = ep2.employee_id
GROUP BY project_id;

-- ❌ RATING: 1/10
-- EVALUATION: Approach is wrong. Self-joining EmployeeProjects here is not the right
--             method — you're joining the table to itself and grouping by project_id,
--             which gives project counts, not employees on multiple projects.
-- CORRECT ANSWER:
--   SELECT employee_id, COUNT(project_id) AS project_count
--   FROM employeeprojects
--   GROUP BY employee_id
--   HAVING COUNT(project_id) > 1;
-- TIP: "Employees doing more than one X" = GROUP BY employee + HAVING COUNT > 1.
--      No self-join needed. Self-join is for finding pairs (like Q43).


-- Q41. Get the department name along with its highest-paid employee's name and salary. [MID]

-- ⬜ NOT ATTEMPTED — RATING: 0/10
-- CORRECT ANSWER (window function approach):
--   SELECT department_name, employee_name, salary
--   FROM (
--       SELECT e.employee_name, e.salary, d.department_name,
--              RANK() OVER (PARTITION BY e.department_id ORDER BY e.salary DESC) AS rnk
--       FROM employees AS e
--       JOIN departments AS d ON e.department_id = d.department_id
--   ) ranked
--   WHERE rnk = 1;
-- TIP: "Top N per group" is one of the most tested patterns in analytics interviews.
--      Master PARTITION BY + ORDER BY inside window functions.


-- Q42. Calculate a running total of salary ordered by employee_id using SUM() as a window function. [MID]

-- ⬜ NOT ATTEMPTED — RATING: 0/10
-- CORRECT ANSWER:
--   SELECT employee_id, employee_name, salary,
--          SUM(salary) OVER (ORDER BY employee_id) AS running_total
--   FROM employees;
-- TIP: Running totals use SUM() OVER (ORDER BY ...) — no PARTITION BY means it runs
--      across the entire result set. With PARTITION BY department_id, it resets per dept.
--      This is a very common DE/analytics interview question.


-- Q43. Find all pairs of employees from the same department using a self-join. [MID]

SELECT * 
FROM employees e1
JOIN employees e2
ON e1.employee_id = e2.employee_id
WHERE e1.department_id = e2.department_id;

-- ⚠️  RATING: 3/10
-- EVALUATION: Self-join structure is right but the ON condition is wrong.
--             ON e1.employee_id = e2.employee_id just joins each row to itself —
--             that's not a pair, that's a self-match. Pairs need DIFFERENT employee_ids
--             from the SAME department. Also, to avoid duplicate pairs (A,B) and (B,A),
--             use < instead of !=.
-- CORRECT ANSWER:
--   SELECT e1.employee_name AS employee_1, e2.employee_name AS employee_2,
--          e1.department_id
--   FROM employees e1
--   JOIN employees e2
--   ON e1.department_id = e2.department_id
--   AND e1.employee_id < e2.employee_id;
-- TIP: Self-join key: join on the SHARED attribute (department_id), separate on
--      the unique key (employee_id). Use < to avoid duplicate pairs — a classic
--      interview trick.


-- Q44. List projects that have NO employees assigned to them. [MID]

SELECT *
FROM projects AS p
LEFT JOIN employeeprojects AS ep
ON p.project_id = ep.project_id
WHERE ep.employee_id IS NULL;

-- ✅ RATING: 10/10
-- EVALUATION: Correct and clean. LEFT JOIN + IS NULL anti-join pattern, perfectly applied.
-- TIP: This is the same pattern as Q30 but from the projects side. You can also
--      write this with NOT EXISTS or NOT IN — knowing all three approaches is a
--      strong interview signal.


-- Q45. Find the employee(s) with the highest salary in each department using a correlated subquery or window function. [MID]

-- ⬜ NOT ATTEMPTED — RATING: 0/10
-- CORRECT ANSWER (window function):
--   SELECT employee_name, department_id, salary
--   FROM (
--       SELECT employee_name, department_id, salary,
--              RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS rnk
--       FROM employees
--   ) ranked
--   WHERE rnk = 1;
--
-- ALTERNATIVE (correlated subquery):
--   SELECT * FROM employees e1
--   WHERE salary = (
--       SELECT MAX(salary) FROM employees e2
--       WHERE e1.department_id = e2.department_id
--   );
-- TIP: The correlated subquery re-runs for every row of the outer query — powerful
--      but slower on large datasets. Window functions are preferred in modern SQL.


-- Q46. Using CASE WHEN, classify employees as 'High Earner', 'Mid Earner', or 'Low Earner'. [MID]

SELECT 
CASE
    WHEN salary > 80000 THEN employee_classifier = 'High Earner'
    WHEN salary BETWEEN 60000 AND 80000 THEN employee_classifier = 'Mid Earner'
    WHEN salary < 60000 THEN employee_classifier = 'Low Earner'
FROM employees;

-- ❌ RATING: 1/10
-- EVALUATION: Syntax is wrong. CASE WHEN returns a value — you can't do
--             "column = value" inside THEN. The THEN clause specifies what to return,
--             not an assignment. Also missing END keyword which closes CASE.
--             This query will throw a syntax error.
-- CORRECT ANSWER:
--   SELECT employee_name, salary,
--          CASE
--              WHEN salary > 80000 THEN 'High Earner'
--              WHEN salary BETWEEN 60000 AND 80000 THEN 'Mid Earner'
--              ELSE 'Low Earner'
--          END AS employee_classifier
--   FROM employees;
-- TIP: CASE WHEN structure: CASE WHEN <condition> THEN <value> ... ELSE <value> END.
--      Always close with END. Use ELSE for catch-all instead of the last WHEN —
--      it handles values outside your defined ranges safely.


-- Q47. Pivot the number of employees per department into a single row (CASE WHEN + SUM). [MID]

-- ⬜ NOT ATTEMPTED — RATING: 0/10
-- CORRECT ANSWER:
--   SELECT
--       SUM(CASE WHEN department_id = 1 THEN 1 ELSE 0 END) AS Engineering,
--       SUM(CASE WHEN department_id = 2 THEN 1 ELSE 0 END) AS HR,
--       SUM(CASE WHEN department_id = 3 THEN 1 ELSE 0 END) AS Finance,
--       SUM(CASE WHEN department_id = 4 THEN 1 ELSE 0 END) AS Marketing
--   FROM employees;
-- TIP: Manual pivot = SUM(CASE WHEN ...). MySQL lacks a native PIVOT keyword (unlike
--      SQL Server). This pattern is very common in reporting/analytics interviews.


-- Q48. Using EXISTS, find employees who are assigned to at least one project. [MID]

-- ⬜ NOT ATTEMPTED — RATING: 0/10
-- CORRECT ANSWER:
--   SELECT * FROM employees AS e
--   WHERE EXISTS (
--       SELECT 1 FROM employeeprojects AS ep
--       WHERE ep.employee_id = e.employee_id
--   );
-- TIP: EXISTS is NULL-safe (unlike IN) and often more efficient — it short-circuits
--      as soon as one matching row is found. SELECT 1 inside EXISTS is convention;
--      the actual value doesn't matter, only whether a row exists.


-- Q49. Find the department(s) with the highest total salary expenditure. [MID]

-- ⬜ NOT ATTEMPTED — RATING: 0/10
-- CORRECT ANSWER:
--   SELECT department_id, SUM(salary) AS total_salary
--   FROM employees
--   GROUP BY department_id
--   HAVING SUM(salary) = (
--       SELECT MAX(total_sal) FROM (
--           SELECT SUM(salary) AS total_sal
--           FROM employees
--           GROUP BY department_id
--       ) AS dept_totals
--   );
-- TIP: "Department with the HIGHEST total" requires a nested subquery or CTE to first
--      compute totals, then find the max of those totals. You can't use HAVING MAX()
--      directly after GROUP BY for this — it doesn't compare groups against each other.


-- Q50. Using multiple CTEs — avg salaries + headcount per dept — display both side by side. [MID]

-- ⬜ NOT ATTEMPTED — RATING: 0/10
-- CORRECT ANSWER:
--   WITH avg_salaries AS (
--       SELECT department_id, ROUND(AVG(salary), 2) AS avg_salary
--       FROM employees
--       GROUP BY department_id
--   ),
--   headcount AS (
--       SELECT department_id, COUNT(employee_id) AS emp_count
--       FROM employees
--       GROUP BY department_id
--   )
--   SELECT d.department_name, a.avg_salary, h.emp_count
--   FROM departments AS d
--   JOIN avg_salaries AS a ON d.department_id = a.department_id
--   JOIN headcount AS h ON d.department_id = h.department_id;
-- TIP: Multiple CTEs are comma-separated after WITH. Each CTE can reference prior ones.
--      This is a fundamental pattern for modular, readable SQL — very common in
--      data engineering and analytics engineering (dbt) workflows.


-----------------------------------------------------------------------------------------------------------------

SHOW DATABASES;

CREATE DATABASE insurance_59_days;

USE insurance_59_days;
-- (policies, claims, customers, agents tables)


-- Dimension Table : agents
CREATE TABLE agents(
	agent_id INT PRIMARY KEY AUTO_INCREMENT,
    agent_name VARCHAR(50) NOT NULL,
    zone VARCHAR(20),
    mode VARCHAR(50) 			-- 'online', 'banassurance', 'direct'
);

-- Dimension Table : customers
CREATE TABLE customers(
	customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(50) NOT NULL,
    date_of_birth DATE,
    is_married BOOL,
    city VARCHAR(30),
    state VARCHAR(30)
);


SELECT * FROM agents;
SELECT * FROM customers;
SELECT * FROM policies;
SELECT * FROM claims;
-- DROP TABLE customers; 
-- Fact Table : policies
CREATE TABLE policies (
	policy_id INT PRIMARY KEY AUTO_INCREMENT,
    agent_id INT,
    customer_id INT,
    start_date DATE NOT NULL,
    end_date DATE,
    status VARCHAR(10), 	-- 'Active', 'Lapsed', 'Terminated', 'Surrendered' 
    FOREIGN KEY (agent_id) REFERENCES agents(agent_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
    
);

-- Dimension Table : claims
CREATE TABLE claims(
	claim_id INT PRIMARY KEY AUTO_INCREMENT,
    policy_id INT NOT NULL,
    policy_type VARCHAR(40),
    claim_date DATE NOT NULL,
    claim_amount FLOAT NOT NULL,
    FOREIGN KEY (policy_id) REFERENCES policies(policy_id)
);

SELECT * FROM agents;
SELECT * FROM customers;
SELECT * FROM policies;
SELECT * FROM claims;