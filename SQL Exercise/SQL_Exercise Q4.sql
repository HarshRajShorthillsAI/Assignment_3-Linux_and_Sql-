CREATE DATABASE Ass3Exe4;

USE Ass3Exe4;

CREATE DATABASE company_db; -- 1 --

CREATE TABLE employees (
    employee_Id INT NOT NULL,  
    employee_name VARCHAR(50) NOT NULL,
    department_id INT NOT NULL,                 
    salary INT NOT NULL,        
    hire_date DATE NOT NULL,       
    PRIMARY KEY (employee_id) -- 2 --
);

INSERT INTO employees (employee_id, employee_name, department_id, salary, hire_date) VALUES
(1, 'John Doe', 1, 50000, STR_TO_DATE('01/15/2022', '%m/%d/%Y')),
(2, 'Jane Smith', 2, 75000, STR_TO_DATE('05/20/2021', '%m/%d/%Y')),
(3, 'Sam Brown', 3, 45000, STR_TO_DATE('03/12/2023', '%m/%d/%Y')),  -- 3 --
(4, 'Nancy White', 4, 55000, STR_TO_DATE('10/01/2022', '%m/%d/%Y')),
(5, 'Paul Black', 5, 80000, STR_TO_DATE('08/30/2020', '%m/%d/%Y'));

CREATE TABLE departments (
	department_Id INT NOT NULL,
    department_name VARCHAR(15) NOT NULL,
    PRIMARY KEY (department_Id)
); -- 2 --

INSERT INTO departments (department_Id, department_name) VALUES -- 3 --
(1, 'Sales'),
(2, 'Engineering'),
(3, 'HR'),
(4, 'Marketing'),
(5, 'Finance');

