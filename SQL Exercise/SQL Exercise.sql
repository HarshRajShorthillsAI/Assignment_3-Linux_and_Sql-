-- SQL Excercise 1 [FILTER AND SORTING] --
CREATE DATABASE assignment3;
SHOW DATABASES;

USE assignment3;
CREATE TABLE orders( -- 1 --
	order_Id INT NOT NULL,
    customer_Id INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount INT NOT NULL
);

DESCRIBE orders;
INSERT INTO orders(  -- 2 --
order_Id, customer_Id, order_date, total_amount
) VALUES 
	(1, 101, STR_TO_DATE('09/01/2023', '%m/%d/%Y'), 350),
	(2, 102, STR_TO_DATE('08/15/2023', '%m/%d/%Y'), 600),
    (3, 103, STR_TO_DATE('09/21/2023', '%m/%d/%Y'), 150),
    (4, 104, STR_TO_DATE('07/30/2023', '%m/%d/%Y'), 75),
    (5, 101, STR_TO_DATE('08/25/2023', '%m/%d/%Y'), 480),
    (6, 105, STR_TO_DATE('09/18/2023', '%m/%d/%Y'), 250),
    (7, 106, STR_TO_DATE('07/29/2023', '%m/%d/%Y'), 500);

SELECT * FROM orders;

SELECT order_Id FROM orders WHERE total_amount BETWEEN 100 AND 500; -- 3 --

SELECT * FROM orders ORDER BY total_amount; -- 4 --

SELECT * FROM orders WHERE order_date - STR_TO_DATE('09/21/2023', '%m/%d/%Y') ORDER BY total_amount  -- 5 --
-- SQL excercise1 --