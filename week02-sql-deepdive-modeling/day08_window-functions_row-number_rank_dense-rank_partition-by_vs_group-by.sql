-- Advanced SQL
-- WINDOW FUNCTIONS : ROW_NUMBER(), RANK(), DENSE_RANK(),
-- PARTITION BY vs GROUP BY
-- Function	Example	Result:
-- ROW_NUMBER()	ROW_NUMBER() OVER(PARTITION BY dept ORDER BY salary DESC) ::: Unique sequence per department
-- RANK()	RANK() OVER(PARTITION BY dept ORDER BY salary DESC) ::: Same rank for ties, gaps remain
-- DENSE_RANK()	DENSE_RANK() OVER(PARTITION BY dept ORDER BY salary DESC) ::: Same rank for ties, no gaps
-- PARTITION BY vs GROUP BY
-- GROUP BY reeturns just one row and used for aggregations, where as PARTITION BY gives entire table and according to the WINDOW parameter, it creates 'sequence'.

---------------
-- Create Database
CREATE DATABASE windows_functions_sample_db_08;
USE windows_functions_sample_db_08;

-- Create Employee Table
CREATE TABLE employees (
    emp VARCHAR(10) PRIMARY KEY,
    dept VARCHAR(50) NOT NULL,
    salary INT NOT NULL
);

-- Insert Sample Data
INSERT INTO employees (emp, dept, salary) VALUES
('A', 'IT', 5000),
('B', 'IT', 7000),
('C', 'IT', 6000),
('D', 'HR', 4000),
('E', 'HR', 6000);

SELECT * 
FROM employees;

-- Ranking Example
-- emp	dept	salary	ROW_NUMBER	RANK	DENSE_RANK
-- B	IT		7000		1		1			1
-- C	IT		6000		2		2			2
-- A	IT		5000		3		3			3
-- E	HR		6000		1		1			1
-- D	HR		4000		2		2			2

-- If salaries were 7000, 7000, 5000:

-- salary	ROW_NUMBER	RANK	DENSE_RANK
-- 7000			1			1			1
-- 7000			2			1			1
-- 5000			3			3			2
--------------

CREATE DATABASE retail_db_59_days_08;
USE retail_db_59_days_08;
-- DROP DATABASE retail_db_59_days;
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50),
    registration_date DATE
);

INSERT INTO customers VALUES
(1,'Rahul Sharma','Mumbai','2024-01-10'),
(2,'Priya Patel','Pune','2024-02-15'),
(3,'Amit Singh','Delhi','2024-03-20'),
(4,'Sneha Joshi','Mumbai','2024-04-05'),
(5,'Vikram Shah','Bangalore','2024-05-12'),
(6,'Neha Gupta','Delhi','2024-06-01'),
(7,'Rohan Mehta','Pune','2024-06-15'),
(8,'Karan Verma','Mumbai','2024-07-10');


CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

INSERT INTO products VALUES
(101,'iPhone 15','Mobile',80000),
(102,'Samsung S24','Mobile',70000),
(103,'MacBook Air','Laptop',95000),
(104,'Dell XPS','Laptop',85000),
(105,'Sony Headphones','Accessories',10000),
(106,'Apple Watch','Accessories',35000),
(107,'iPad Air','Tablet',60000),
(108,'Samsung Tab','Tablet',45000);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,

    FOREIGN KEY (customer_id)
    REFERENCES customers(customer_id)
);

INSERT INTO orders VALUES
(1001,1,'2025-01-05'),
(1002,2,'2025-01-08'),
(1003,1,'2025-02-12'),
(1004,3,'2025-02-15'),
(1005,4,'2025-03-10'),
(1006,2,'2025-03-12'),
(1007,5,'2025-03-20'),
(1008,1,'2025-04-01'),
(1009,6,'2025-04-05'),
(1010,7,'2025-04-10'),
(1011,8,'2025-05-01'),
(1012,3,'2025-05-15'),
(1013,4,'2025-05-20'),
(1014,5,'2025-06-05'),
(1015,1,'2025-06-18');

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,

    FOREIGN KEY (order_id)
    REFERENCES orders(order_id),

    FOREIGN KEY (product_id)
    REFERENCES products(product_id)
);
SELECT * FROM products;

INSERT INTO order_items VALUES
(1,1001,101,1),
(2,1001,105,2),

(3,1002,102,1),

(4,1003,103,1),

(5,1004,101,1),
(6,1004,106,1),

(7,1005,107,1),

(8,1006,104,1),

(9,1007,108,2),

(10,1008,101,1),

(11,1009,105,3),

(12,1010,103,1),

(13,1011,106,2),

(14,1012,104,1),

(15,1013,107,1),

(16,1014,101,1),
(17,1014,105,1),

(18,1015,103,1),
(19,1015,106,1);

