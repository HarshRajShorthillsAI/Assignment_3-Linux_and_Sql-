CREATE DATABASE Ass3Exe3;

USE Ass3Exe3;

CREATE TABLE employee_2023 (
employee_Id INT NOT NULL,
_name VARCHAR(15) NOT NULL,
department VARCHAR(15) NOT NULL
); -- 1 --

INSERT INTO employee_2023 (employee_Id, _name, department)
VALUES (1, 'John Doe', 'Sales'),
(2, 'Jane Smith', 'Engineering'),
(3, 'Sam Brown', 'Marketing'),
(4, 'Nancy White', 'HR'),
(5, 'Paul Black', 'Finanace'); -- 2 --

CREATE TABLE employee_2024 (
employee_Id INT NOT NULL,
_name VARCHAR(15) NOT NULL,
department VARCHAR(15) NOT NULL
); -- 1 --

INSERT INTO employee_2024 (employee_Id, _name, department)
VALUES
(2, 'Jane Smith', 'Engineering'),
(3, 'Sam Brown', 'Marketing'),
(4, 'Peter Parker', 'IT'),
(5, 'Mary Jane', 'Sales'),
(8, 'Bruce Wayne', 'Finance'); -- 2 --

SELECT _name FROM employee_2023
UNION
SELECT _name FROM employee_2024; -- 3 --

SELECT e1._name FROM employee_2023 as e1
WHERE e1._name NOT IN (SELECT e2._name FROM employee_2024 as e2); -- 4 --

SELECT e1._name  FROM employee_2023 AS e1 LEFT JOIN employee_2024 AS e2 ON e1._name = e2._name WHERE e2._name IS NULL; -- 5 --

SELECT * from employee_2024;