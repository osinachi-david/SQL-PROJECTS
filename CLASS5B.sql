-- SQL VIEWS 

-- AN SQL VIEW IS A VIRTUAL TABLE BASED ON THE RESULT-SET OF 
-- AN SQL STATEMENT

-- A VIEW WILL CONTAIN ROWS AND COLUMNS LIKE A REAL TABLE 

-- USE THE CREATE VIEW STATEMENT TO CREATE A VIEW 

-- THERE ARE 2 TYPES OF VIEWS 
-- SIMPLE VIEW 
-- COMPLEX VIEW

-- SIMPLE VIEW 

/*
CREATE VIEW VIEW_001 AS 
SELECT EMPLOYEE_ID, LAST_NAME, SALARY 
FROM Employees
WHERE DEPARTMENT_ID = 50 OR DEPARTMENT_ID = 20
*/

-- RETRIEVE DATA FROM A VIEW 
SELECT * FROM VIEW_001

-- UPDATE VIEW_001
CREATE OR ALTER VIEW VIEW_001 AS
SELECT FIRST_NAME, LAST_NAME, JOB_ID 
FROM Employees

-- DELETE A VIEW BY DROPPING IT
-- DROP VIEW NAME

-- COMPLEX VIEWS 
-- COMPLEX VIEWS ARE DERIVED FROM MANY TABLES 
-- CONTAIN FUNCTIONS OR GROUPS OF DATA 

--EX
CREATE OR ALTER VIEW VIEW_003
					(NAME, MINSAL, MAXSAL, AVGSAL) AS
SELECT D.DEPARTMENT_NAME,
MIN(SALARY), MAX(SALARY), AVG(SALARY)
FROM Employees E
JOIN Departments D
ON (E.DEPARTMENT_ID = D.DEPARTMENT_ID)
GROUP BY D.DEPARTMENT_NAME;

SELECT * FROM VIEW_003

-- STORED PROCEDURES
--EX
CREATE PROCEDURE SELECTEMPLOYEES AS
SELECT * FROM Employees
WHERE DEPARTMENT_ID = 50;


--RUN THE STORE PROCEDURE
EXEC SELECTEMPLOYEES

-- STORED PROCEDURE WITH SINGLE PARAMETER 

--EX
CREATE PROCEDURE SELECTEMPLOYEESNAME @NAME VARCHAR(50)
AS
SELECT * FROM Employees
WHERE LAST_NAME = @NAME;

--RUN THE PROCEDURE 
EXEC SELECTEMPLOYEESNAME @NAME = 'KING'


-- STORED PROCEDURES WITH MULTIPLE PARAMETERS 
CREATE PROCEDURE SELECTEMPLOYEESDETAILS 
@NAME VARCHAR(50),
@JOB VARCHAR(20)
AS
SELECT * FROM Employees
WHERE LAST_NAME = @NAME
OR JOB_ID = @JOB;

-- RUN PROCEDURE WITH MULTIPLE PARAMS
EXEC SELECTEMPLOYEESDETAILS @NAME = '', @JOB = 'IT_PROG'

--PRACTICE QUESTIONS
-- Q1
-- WRITE A QUERY TO DISPLAY THE CURRENT DATE. LABEL THE COLUMN
-- 'DATE'

-- solu
select GETDATE() 'Date'

-- Q2
-- WRITE A STORED PROCEDURE TO DISPLAY EMPLOYEES WHO EARN 
-- ABOVE A GIVEN SALARY VALUE (VALUE SHOULD NOT BE FIXED)

--solu
create procedure salarylevel @sal INT as
select * from Employees
where salary > @sal
--order by SALARY asc

--test 
exec salarylevel @sal = 10000

-- Q3
-- HR WANTS A REPORT TO DISPLAY EMPLOYEE NAME, SALARY AND 
-- SALARY INCREASED BY 15.5% (EXPRESSED AS A WHOLE NUMBER)
-- FOR EACH EMPLOYEE. LABEL THE COLUMN: 'NEW SALARY' 

-- solu
select CONCAT(FIRST_NAME,' ', LAST_NAME) as Name,
SALARY, (SALARY * 1.155) as 'New Salary'
from Employees

-- Q4.
-- WRITE A STORED PROCEDURE TO CALCULATE ALL EMPLOYEES 
-- EARNING ABOVE MINIMUM ANNUAL WAGE
-- ASSUME THE MINIMUM ANNUAL WAGE IS 50K

select * 
from Employees
where (SALARY * 12) > any
				(select salary * 12 as 'Annual Sal' 
					from Employees 
					where (salary * 12) > 50000)