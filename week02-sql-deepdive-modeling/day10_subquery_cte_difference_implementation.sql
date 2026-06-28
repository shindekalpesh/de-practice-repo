-- Subquery vs CTE
-- Common Table Expressions (CTEs) and subqueries are both temporary result sets used to build complex queries, but CTEs emphasize top-down readability and reusability, 
-- while subqueries provide compact, inline logic for single-use filters.
-- There's negligible performance difference between CTE and Subquery.
-- With CTEs, the complex logic code is made easier for readability and reusability.

USE insurance_59_days;		-- from day07

SHOW TABLES;

SELECT * 
FROM policies;

SHOW CREATE TABLE policies;

INSERT INTO agents VALUES
(101, 'Rahul Sharma', 'North', 'Online'),
(102, 'Priya Nair', 'South', 'Direct'),
(103, 'Amit Patel', 'West', 'Bancassurance'),
(104, 'Sneha Singh', 'East', 'Online'),
(105, 'Vikas Gupta', 'North', 'Direct'),
(106, 'Neha Joshi', 'West', 'Online');

INSERT INTO customers VALUES
(201,'Aarav Mehta','1995-04-18',FALSE,'Mumbai','Maharashtra'),
(202,'Diya Shah','1992-08-21',TRUE,'Pune','Maharashtra'),
(203,'Rohan Verma','1988-01-15',TRUE,'Delhi','Delhi'),
(204,'Ananya Roy','1997-10-11',FALSE,'Kolkata','West Bengal'),
(205,'Karan Malhotra','1990-03-02',TRUE,'Chandigarh','Punjab'),
(206,'Ishita Rao','1998-07-07',FALSE,'Hyderabad','Telangana'),
(207,'Aditya Jain','1985-11-29',TRUE,'Jaipur','Rajasthan'),
(208,'Meera Kulkarni','1993-12-12',TRUE,'Nagpur','Maharashtra'),
(209,'Sahil Khan','1996-05-25',FALSE,'Lucknow','Uttar Pradesh'),
(210,'Pooja Desai','1989-09-14',TRUE,'Ahmedabad','Gujarat'),
(211,'Yash Patil','1994-02-20',FALSE,'Nashik','Maharashtra'),
(212,'Kavya Menon','1991-06-17',TRUE,'Kochi','Kerala'),
(213,'Arjun Kapoor','1987-04-28',TRUE,'Delhi','Delhi'),
(214,'Nidhi Sharma','1999-01-05',FALSE,'Indore','Madhya Pradesh'),
(215,'Vivek Das','1993-11-22',TRUE,'Bhubaneswar','Odisha');

INSERT INTO policies VALUES
(301,101,201,'2024-01-10','2034-01-10','Active'),
(302,102,202,'2023-05-15','2033-05-15','Active'),
(303,103,203,'2022-03-18','2032-03-18','Lapsed'),
(304,104,204,'2024-04-01','2034-04-01','Active'),
(305,105,205,'2021-09-12','2031-09-12','Terminated'),
(306,106,206,'2024-06-20','2034-06-20','Active'),
(307,101,207,'2023-11-05','2033-11-05','Active'),
(308,102,208,'2022-08-14','2032-08-14','Surrendered'),
(309,103,209,'2024-02-17','2034-02-17','Active'),
(310,104,210,'2023-07-30','2033-07-30','Lapsed'),
(311,105,211,'2024-05-08','2034-05-08','Active'),
(312,106,212,'2021-01-01','2031-01-01','Terminated'),
(313,101,213,'2022-12-19','2032-12-19','Active'),
(314,102,214,'2024-03-03','2034-03-03','Active'),
(315,103,215,'2023-09-09','2033-09-09','Active'),
(316,104,201,'2022-06-11','2032-06-11','Surrendered'),
(317,105,202,'2024-01-25','2034-01-25','Active'),
(318,106,203,'2023-10-16','2033-10-16','Active'),
(319,101,204,'2021-04-04','2031-04-04','Lapsed'),
(320,102,205,'2024-07-12','2034-07-12','Active');

INSERT INTO claims VALUES
(401,301,'Health','2024-03-15',25000),
(402,302,'Life','2024-05-20',500000),
(403,303,'Vehicle','2023-12-11',45000),
(404,304,'Health','2024-08-18',18000),
(405,305,'Life','2022-10-10',750000),
(406,307,'Travel','2024-02-12',12000),
(407,308,'Vehicle','2023-11-05',90000),
(408,309,'Health','2024-09-01',35000),
(409,310,'Life','2024-01-30',600000),
(410,312,'Health','2022-07-07',27000),
(411,313,'Travel','2023-03-15',15000),
(412,315,'Vehicle','2024-04-10',65000),
(413,317,'Life','2025-01-05',400000),
(414,318,'Health','2024-12-20',22000),
(415,320,'Travel','2025-02-14',17000);


DELETE FROM claims;
COMMIT;
SET SQL_SAFE_UPDATES = 0;
----------------------------------------------------------------------------
SELECT * FROM agents;
SELECT * FROM customers;
SELECT * FROM policies;
SELECT * FROM claims;
----------------------------------------------------------------------------

-- q1. Find the customer(s) who purchased the earliest policy.

-- Option-1:
SELECT customer_id, start_date
FROM policies
ORDER BY start_date ASC;

-- Option-2:
SELECT * FROM policies WHERE start_date IN (SELECT MIN(start_date)
FROM policies);

-- q2. Find the customer(s) who purchased the most recent policy.
-- Option-1:
SELECT customer_id, start_date
FROM policies
ORDER BY start_date DESC
LIMIT 1;

-- Option-2:
SELECT * FROM policies WHERE start_date IN (
SELECT MAX(start_date)
FROM policies);
-- q3. Find the claim having the highest claim amount.
-- Option-1:
SELECT *
FROM claims
ORDER BY claim_amount DESC
LIMIT 1;

-- Option-2:
SELECT * FROM claims WHERE (
SELECT MAX(claim_amount)
FROM claims);
-- q4. Find the claim having the lowest claim amount.
-- Option-1:
SELECT *
FROM claims
ORDER BY claim_amount ASC
LIMIT 1;

-- Option-2:
SELECT * FROM claims 
WHERE claim_amount IN (SELECT MIN(claim_amount)
FROM claims);

-- q5. Find the policy whose end date is the latest.

-- Option-1:
SELECT *
FROM policies
ORDER BY end_date ASC
LIMIT 1;

-- Option-2:
SELECT MIN(end_date) as min_end_date
FROM policies;
-- q6. Find the customer(s) whose date of birth is the earliest (oldest
-- customer).
-- Option-1:
SELECT customer_id, customer_name, date_of_birth
FROM customers
ORDER BY date_of_birth ASC
LIMIT 1;

-- Option-2:
SELECT customer_id, customer_name, date_of_birth FROM customers WHERE date_of_birth IN (
SELECT MIN(date_of_birth) as min_dob
FROM customers);
-- q7. Find the customer(s) whose date of birth is the latest (youngest
-- customer).
-- Option-1:
SELECT customer_id, customer_name, date_of_birth
FROM customers
ORDER BY date_of_birth DESC
LIMIT 1;

-- Option-2:
SELECT customer_id, customer_name, date_of_birth FROM customers WHERE date_of_birth IN (SELECT MAX(date_of_birth)
FROM customers);

-- q8. Find the policy(s) having the earliest start date.
SELECT * FROM policies WHERE start_date IN (SELECT MIN(start_date)
FROM policies);

-- q9. Find the agent(s) who has the smallest agent_id.
SELECT * FROM agents WHERE agent_id IN (
SELECT MIN(agent_id)
FROM agents);

-- q10. Find the customer(s) living in the state that comes first
-- alphabetically.
SELECT * FROM customers WHERE state IN (
SELECT MIN(state)
FROM customers);

-- q11. Find all claims whose claim amount is greater than the average
-- claim amount.

SELECT * FROM claims WHERE claim_amount > (SELECT AVG(claim_amount) 
FROM claims);

-- q12. Find policies whose start date is later than the average policy start date.
SELECT * FROM policies WHERE start_date > (
SELECT AVG(start_date) AS avg_start_date
FROM policies);

-- q13. Find customers whose age is greater than the average customer age.

SELECT * FROM customers WHERE age > (
SELECT AVG(age) FROM 
(SELECT TIMESTAMPDIFF(YEAR, date_of_birth, CURRENT_DATE()) AS age			-- Syntax: TIMESTAMPDIFF(YEAR, my_date, CURRENT_DATE())
FROM customers) as tmp_tbl);

-- q14. Find agents who have sold more policies than the average number of
-- policies sold per agent.
SELECT AVG(policy_id) as avg_sold_policies
FROM policies;

SELECT * FROM agents where avg_sold_pol > 
(
SELECT AVG(avg_sold_pol) FROM 
	(
		SELECT agent_id, COUNT(*) AS avg_sold_pol
		FROM policies
		GROUP BY agent_id
	) AS tmp_tbl);
    
-- oPTION-2:

SELECT COUNT(*) AS policy_count
FROM policies p
GROUP BY agent_id
JOIN agents a
ON p.agent_id = a.agent_id
	SELECT AVG(policy_count) as avg_policy_count
	FROM
		(
		SELECT COUNT(*) AS policy_count
		FROM policies
		GROUP BY agent_id
		) AS t;
        
-- OPTION-3: working
SELECT a.*, p.policy_count
FROM agents a
JOIN
(
    SELECT agent_id, COUNT(*) AS policy_count
    FROM policies
    GROUP BY agent_id
) p
ON a.agent_id = p.agent_id
WHERE p.policy_count >
(
    SELECT AVG(policy_count)
    FROM
    (
        SELECT COUNT(*) AS policy_count
        FROM policies
        GROUP BY agent_id
    ) t
);        

-- q15. Find customers who own more policies than the average number of
-- policies owned by customers.

-- q16. Find policies whose claim amount is greater than the average claim
-- amount of all claimed policies.

-- q17. Find the customer(s) who owns the maximum number of policies.

-- q18. Find the agent(s) who sold the minimum number of policies.

-- q19. Find policy statuses whose count is greater than the average status
-- count.

-- q20. Find states having more customers than the average number of
-- customers per state.

-- q21. Find customers who have made at least one claim.

-- q22. Find customers who have never made a claim.

-- q23. Find agents who have sold at least one policy.

-- q24. Find agents who have never sold any policy.

-- q25. Find customers who own at least one active policy.

-- q26. Find customers for whom at least one policy exists.

-- q27. Find customers for whom no policy exists.

-- q28. Find policies for which at least one claim exists.

-- q29. Find policies for which no claim exists.

-- q30. Find agents who have at least one customer from Maharashtra.
