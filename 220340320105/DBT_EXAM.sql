create database DBT_exam;
use DBT_exam;
show tables;

-- 1. Create table DEPT with the following structure:-

create table DEPT(
DEPTNO INT(2),
DNAME VARCHAR(15),
LOC VARCHAR(10)
);

DESC DEPT;

-- Insert the following rows into the DEPT table:-

INSERT INTO DEPT (DEPTNO, DNAME, LOC) VALUES
(10, 'ACCOUNTING', 'NEW YORK'),
(20, 'RESEARCH', 'DALLAS'),
(30, 'SALES' , 'CHICAGO'),
(40, 'OPERATIONS', 'BOSTON');

SELECT * FROM DEPT;

-- 2. Create table EMP with the following structure:-

CREATE TABLE EMP(
EMPNO INT(4),
ENAME VARCHAR(10),
JOB VARCHAR(9),
HIREDATE DATE,
SAL FLOAT(7,2),
COMM FLOAT(7,2),
DEPTNO INT(2)
);

DESC EMP;

-- Insert the following rows into the EMP table:-

INSERT INTO EMP (EMPNO, ENAME, JOB, HIREDATE, SAL, COMM, DEPTNO) VALUES
(7839, 'KING', 'MANAGER', '1991-11-17', 5000, NULL, 10),
(7698, 'BLAKE', 'CLERK', '1981-05-01', 2850, NULL, 30),
(7782, 'CLARK', 'MANAGER', '1981-06-09', 2450, NULL, 10),
(7566, 'JONES', 'CLERK', '1981-04-02', 2975, NULL, 20),
(7654, 'MARTIN', 'SALESMAN', '1981-09-28', 1250, 1400, 30),
(7499, 'ALLEN', 'SALESMAN', '1981-02-20', 1600, 300, 30);

SELECT * FROM EMP;

-- 3. Display all the employees where SAL between 2500 and 5000 (inclusive of both).
SELECT EMPNO, ENAME FROM EMP WHERE SAL BETWEEN 2500 AND 5000;

-- 4. Display all the ENAMEs in descending order of ENAME.
SELECT ENAME FROM EMP ORDER BY ENAME DESC;

-- 5. Display all the JOBs in lowercase.
SELECT LOWER(JOB) FROM EMP; 

-- 6. Display the ENAMEs and the lengths of the ENAMEs.
SELECT ENAME, LENGTH(ENAME) FROM EMP;

-- 7. Display the DEPTNO and the count of employees who belong to that DEPTNO .
SELECT DEPT.DEPTNO, COUNT(EMP.DEPTNO) FROM EMP, DEPT WHERE EMP.DEPTNO=DEPT.DEPTNO GROUP BY DEPT.DEPTNO;

-- 8. Display the DNAMEs and the ENAMEs who belong to that DNAME.
SELECT DNAME, ENAME FROM EMP, DEPT WHERE  EMP.DEPTNO=DEPT.DEPTNO;

-- 9. Display the position at which the string ‘AR’ occurs in the ename.
SELECT POSITION('AR' IN ENAME) FROM EMP;

-- 10. Display the HRA for each employee given that HRA is 20% of SAL.
SELECT ENAME, SAL, SAL*0.20 AS "HRA" FROM EMP;

-- 1. Write a stored procedure by the name of PROC1 that accepts two varchar strings
-- as parameters. Your procedure should then determine if the first varchar string
-- exists inside the varchar string. For example, if string1 = ‘DAC’ and string2 =
-- ‘CDAC, then string1 exists inside string2. The stored procedure should insert the
-- appropriate message into a suitable TEMPP output table. Calling program for the
-- stored procedure need not be written.

CREATE TABLE DEMO(OUTPUT VARCHAR(10));

DELIMITER //
CREATE PROCEDURE PROC1 (A VARCHAR(30), B VARCHAR(30))
BEGIN 
IF INSTR(A, B)>0 OR INSTR(B,A) THEN
        INSERT INTO DEMO VALUES ('EXISTS');
        ELSE
        INSERT INTO DEMO VALUES ('NOT EXITS');
END IF;
END; //
DELIMITER ;

CALL PROC1('DAC', 'CDAC');

SELECT * FROM DEMO;

-- 2.Create a stored function by the name of FUNC1 to take three parameters, the
-- sides of a triangle. The function should return a Boolean value:- TRUE if the
-- triangle is valid, FALSE otherwise. A triangle is valid if the length of each side is
-- less than the sum of the lengths of the other two sides. Check if the dimensions
-- entered can form a valid triangle. Calling program for the stored function need not
-- be written.

CREATE TABLE TEMP(OUTPUT BOOLEAN);

DELIMITER //
CREATE FUNCTION FUNC1(A FLOAT, B FLOAT, C FLOAT)
RETURNS BOOLEAN 
DETERMINISTIC 
BEGIN
IF A+B > C 
      THEN IF B+C > A
             THEN IF C+A > B
             THEN RETURN TRUE;
	         END IF;
	  END IF;
END IF;
RETURN FALSE;
END; //
DELIMITER ;

DROP PROCEDURE OUTPUT;

DELIMITER //
CREATE PROCEDURE OUTPUT()
BEGIN
DECLARE X BOOLEAN;
SET X = FUNC1(100, 3,4);
INSERT INTO TEMP VALUES(X);
END; //
DELIMITER ;


-- OUTPUT FOR VALUES (3,4,5)
CALL OUTPUT();
SELECT * FROM TEMP;

-- OUTPUT FOR VALUES (100, 3,4)
CALL OUTPUT();
SELECT * FROM TEMP;


