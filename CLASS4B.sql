-- DATA MANIPULATION LANGUAGE, DML 
-- INSERT UPDATE DELETE STATEMENTS 

-- INSERT STATEMENTS 
-- SYNTAX 

/*
	INSERT INTO TableName(Col1_name, Col2_name...ColN_name)
	VALUES(val1, val2...valN)

	OR 

	INSERT INTO TableName 
	VALUES()

*/

select * from departments 
-- add a new entry to the departments table 

insert into Departments(DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
values(301, 'AdvSQL', 190, 1700)

insert into Departments
values(302, 'python', 203, 1700)

-- COPYING COLUMNS FROM TABLES 

-- DUPLICATE AN ENTIRE TABLE, BOTH THE STRUCTURE AND DATA 

SELECT * INTO EMPLOEENEWTABLE FROM Employees
WHERE 1=1

SELECT * FROM EMPLOEENEWTABLE

--COPY THE TABLE STRUCTURE WITHOUT COPYING THE DATA 
SELECT * INTO EMPLOEENEWTABLESTC FROM Employees
WHERE 1=0

SELECT * FROM EMPLOEENEWTABLESTC

-- COPY SPECIFIC COLUMNS 
SELECT EMPLOYEE_ID, LAST_NAME, FIRST_NAME, SALARY 
INTO EMPLOYEESNEWTABLE
FROM Employees
WHERE 1=1

SELECT * FROM EMPLOYEESNEWTABLE

-- CREATE SOME EXTRA COLS
SELECT LAST_NAME, SALARY, DEPARTMENT_NAME
INTO EMPLOYEES_SALARIES
FROM Employees
INNER JOIN Departments
ON Employees.DEPARTMENT_ID = Departments.DEPARTMENT_ID
WHERE 1=1

SELECT * FROM EMPLOYEES_SALARIES

-- USING TRANSACTIONS 
-- USE TRANSACTIONS BEFORE RUNNING UPDATE STATEMENTS 
-- TRANSACTIONS BASICALLY WORK AS CHECK POINTS 
-- THEY PROVIDE YOU WITH A 'RESTORE POINT' IF FOR ANY REASON 
-- YOU HAVE TO ROLL BACK YOUR DATA 

BEGIN TRANSACTION UPDATE_SALARIES

UPDATE EMPLOYEES_SALARIES
SET SALARY = SALARY + 5000
WHERE LAST_NAME = 'KING' AND
DEPARTMENT_NAME = 'EXECUTIVE'

SELECT * FROM EMPLOYEES_SALARIES


UPDATE EMPLOYEES_SALARIES
SET SALARY = SALARY + 500
WHERE LAST_NAME <> 'KING' OR
DEPARTMENT_NAME <> 'EXECUTIVE'

-- IF ERRORS HAVE BEEN MADE 
-- WE CAN ROLLBACK TRANSACTIONS 

ROLLBACK TRANSACTION UPDATE_SALARIES

SELECT * FROM EMPLOYEES_SALARIES

-- REMOVING A ROW A TABLE 
-- USE THE DELETE STATEMENT 
-- MAKE SURE YOU HAVE THE WHERE CLAUSE IF NOT ALL ROWS 
-- IN YOUR TABLE WILL BE DELETED 

--SYNTAX 
-- DELETE FROM [TABLE] 
-- WHERE [CONDITION]

DELETE FROM EMPLOYEES_SALARIES
WHERE LAST_NAME = 'king'

SELECT * FROM EMPLOYEES_SALARIES

BEGIN TRANSACTION UPDATE_SAL
ROLLBACK TRANSACTION UPDATE_SAL
COMMIT TRANSACTION UPDATE_SAL --PERMANENT 

-- CREATE A TABLE 

CREATE TABLE DA_CLASS
(
	PERSONID INT,
	LASTNAME VARCHAR(100),
	FIRSTNAME VARCHAR(100),
	EMAIL VARCHAR(100),
	HOBBY VARCHAR(100)
) 

SELECT * FROM DA_CLASS

INSERT INTO DA_CLASS
VALUES(01, 'JOHN', 'ABU', 'JABU@GMAIL.COM', 'READING')

-- DROP THE TABLE AND RECREATE 

--DROP TABLE DA_CLASS

CREATE TABLE DA_CLASS1
(
	PERSONID INT UNIQUE,
	LASTNAME VARCHAR(100),
	FIRSTNAME VARCHAR(100),
	EMAIL VARCHAR(100),
	HOBBY VARCHAR(100)
) 

INSERT INTO DA_CLASS1
VALUES(01, 'JOHN', 'ABU', 'JABU@GMAIL.COM', 'READING')