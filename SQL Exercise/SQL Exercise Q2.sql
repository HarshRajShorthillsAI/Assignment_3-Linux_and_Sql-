-- SQL Exercise 2 --
SHOW DATABASES;

CREATE DATABASE Assignment3_2;

USE Assignment3_2;

CREATE TABLE customers -- 1 --
(
	customer_Id INT NOT NULL,
    customer_name VARCHAR(15) NOT NULL,
	city VARCHAR(15) NOT NULL
);

DESCRIBE customers;

INSERT INTO customers (customer_Id, customer_name, city) VALUES
(101, 'John Doe', 'New York'),
(102, 'Jane Smith', 'Los Angeles'),
(103, 'Sam Brown', 'Chicago'),
(104, 'Nancy White', 'Miami'),
(105, 'Paul Black', 'Boston'); -- 2 --

CREATE TABLE products -- 3 --
(
	product_Id INT NOT NULL,
    product_name VARCHAR(15) NOT NULL,
	price INT NOT NULL
);

DESCRIBE products;

INSERT INTO products (product_Id, product_name, price) VALUES
(201, 'Laptop', 1000),
(202, 'Phone', 600),
(203, 'Headphone', 100),
(204, 'Monitor', 300),
(205, 'Keyboard', 50);

SELECT * FROM products;

SELECT 
    c.customer_name,
    o.total_amount,
    p.product_name
FROM 
    customers c
JOIN 
    orders o ON c.customer_Id = o.customer_Id
JOIN 
    (SELECT product_Id, product_name 
     FROM products) AS p
ON o.order_Id = p.product_Id
ORDER BY 
    c.customer_name, o.order_Id;


SELECT c.customer_name, o.total_amount
FROM customers as c JOIN orders as o USING (customer_id); -- 4 --

CREATE TABLE orders -- 5 --
(
	order_Id INT NOT NULL,
    customer_Id INT NOT NULL,
    order_date DATE NOT NULL,
	total_amount INT NOT NULL
);

INSERT INTO orders (order_Id, customer_Id, order_date, total_amount)
VALUES (1, 101, STR_TO_DATE('09/01/2023', '%m/%d/%Y'), 350),
(2, 102, STR_TO_DATE('8/15/2023', '%m/%d/%Y'), 600),
(3, 103, STR_TO_DATE('9/21/2023', '%m/%d/%Y'), 150),
(4, 104, STR_TO_DATE('7/30/2023', '%m/%d/%Y'), 75),
(5, 101, STR_TO_DATE('8/25/2023', '%m/%d/%Y'), 480);
-- SQL Exercise 2 --