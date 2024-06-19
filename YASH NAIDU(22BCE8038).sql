CREATE DATABASE COMPANY;
SHOW DATABASES;
USE COMPANY;

CREATE TABLE Employee (
    EMPLOYEE_ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    FIRST_NAME CHAR(25),
    LAST_NAME CHAR(25),
    INCOME INT,
    HIRE_DATE DATETIME,
    DIVISION CHAR(25)
);

INSERT INTO Employee (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, INCOME, HIRE_DATE, DIVISION) VALUES
(101, 'Anna', 'White', 130000, '2015-03-20 09:00:00', 'Finance'),
(102, 'David', 'Brown', 98000, '2015-07-11 09:00:00', 'Operations'),
(103, 'Emily', 'Clark', 370000, '2015-03-20 09:00:00', 'Finance'),
(104, 'Michael', 'Johnson', 620000, '2015-03-20 09:00:00', 'Operations'),
(105, 'Sarah', 'Davis', 620000, '2015-07-11 09:00:00', 'Operations'),
(106, 'James', 'Miller', 260000, '2015-07-11 09:00:00', 'Sales'),
(107, 'Emma', 'Wilson', 87000, '2015-02-20 09:00:00', 'Marketing'),
(108, 'Lucas', 'Lee', 102000, '2015-05-11 09:00:00', 'Operations');

CREATE TABLE Compensation (
    EMPLOYEE_REF_ID INT,
    COMPENSATION_AMOUNT INT,
    COMPENSATION_DATE DATETIME,
    FOREIGN KEY (EMPLOYEE_REF_ID) REFERENCES Employee(EMPLOYEE_ID) ON DELETE CASCADE
);

INSERT INTO Compensation (EMPLOYEE_REF_ID, COMPENSATION_AMOUNT, COMPENSATION_DATE) VALUES
(101, 7200, '2017-03-20'),
(102, 4200, '2017-07-11'),
(103, 5200, '2017-03-20'),
(101, 6700, '2017-03-20'),
(102, 4700, '2017-07-11');

CREATE TABLE Role (
    EMPLOYEE_REF_ID INT,
    EMPLOYEE_ROLE CHAR(25),
    START_DATE DATETIME,
    FOREIGN KEY (EMPLOYEE_REF_ID) REFERENCES Employee(EMPLOYEE_ID) ON DELETE CASCADE
);

INSERT INTO Role (EMPLOYEE_REF_ID, EMPLOYEE_ROLE, START_DATE) VALUES
(101, 'Director', '2017-03-20 00:00:00'),
(102, 'Supervisor', '2017-07-11 00:00:00'),
(108, 'Supervisor', '2017-07-11 00:00:00'),
(105, 'Director', '2017-07-11 00:00:00'),
(104, 'Deputy Director', '2017-07-11 00:00:00'),
(107, 'Supervisor', '2017-07-11 00:00:00'),
(106, 'Coordinator', '2017-07-11 00:00:00'),
(103, 'Coordinator', '2017-07-11 00:00:00');

SELECT * FROM Employee;
SELECT * FROM Compensation;
SELECT * FROM Role;

SELECT FIRST_NAME AS EMPLOYEE_NAME FROM Employee;

SELECT UPPER(FIRST_NAME) FROM Employee;

SELECT DISTINCT DIVISION FROM Employee;

SELECT LEFT(FIRST_NAME, 3) FROM Employee;

SELECT INSTR(FIRST_NAME, 'o') FROM Employee WHERE FIRST_NAME = 'John';

SELECT RTRIM(FIRST_NAME) FROM Employee;

SELECT LTRIM(DIVISION) FROM Employee;

SELECT DISTINCT LENGTH(DIVISION) FROM Employee;

SELECT REPLACE(FIRST_NAME, 'e', 'E') FROM Employee;

SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) AS FULL_NAME FROM Employee;

SELECT * FROM Employee ORDER BY FIRST_NAME ASC;

SELECT * FROM Employee ORDER BY FIRST_NAME ASC, DIVISION DESC;

SELECT * FROM Employee WHERE FIRST_NAME IN ('Eve', 'Frank');

SELECT * FROM Employee WHERE FIRST_NAME NOT IN ('Eve', 'Frank');

SELECT * FROM Employee WHERE DIVISION = 'Operations';

SELECT * FROM Employee WHERE FIRST_NAME LIKE '%o%';

SELECT * FROM Employee WHERE FIRST_NAME LIKE '%e';

SELECT * FROM Employee WHERE FIRST_NAME LIKE '______n%';

SELECT * FROM Employee WHERE INCOME BETWEEN 120000 AND 600000;

SELECT * FROM Employee WHERE HIRE_DATE LIKE '2015-03%';

SELECT COUNT(*) AS EMPLOYEE_COUNT FROM Employee WHERE DIVISION = 'Operations';

SELECT * FROM Employee WHERE INCOME >= 85000 AND INCOME <= 120000;

SELECT DIVISION, COUNT(*) AS EMPLOYEE_COUNT FROM Employee
GROUP BY DIVISION
ORDER BY EMPLOYEE_COUNT DESC;

SELECT e.* FROM Employee e INNER JOIN Role r ON e.EMPLOYEE_ID = r.EMPLOYEE_REF_ID WHERE r.EMPLOYEE_ROLE = 'Director';

SELECT * FROM Employee e1 INNER JOIN Employee e2 ON e1.EMPLOYEE_ID <> e2.EMPLOYEE_ID AND e1.FIRST_NAME = e2.FIRST_NAME AND e1.LAST_NAME = e2.LAST_NAME;

SELECT * FROM Employee WHERE EMPLOYEE_ID MOD 2 = 1;

SELECT * FROM Employee WHERE EMPLOYEE_ID MOD 2 = 0;

CREATE TABLE NewEmployeeTable LIKE Employee;

INSERT INTO NewEmployeeTable
SELECT * FROM Employee;

SELECT * FROM Employee
WHERE EMPLOYEE_ID IN (SELECT EMPLOYEE_REF_ID FROM Compensation);

SELECT * FROM Employee
WHERE EMPLOYEE_ID NOT IN (SELECT EMPLOYEE_ID FROM Compensation);

SELECT NOW();

SELECT * FROM Employee LIMIT 10;

SELECT DISTINCT INCOME FROM Employee
ORDER BY INCOME
DESC LIMIT 1 OFFSET 4;

SELECT DISTINCT INCOME FROM Employee e1
WHERE 4 = (SELECT COUNT(DISTINCT INCOME)
FROM Employee e2
WHERE e2.INCOME >= e1.INCOME);

SELECT FIRST_NAME, LAST_NAME, INCOME FROM Employee
WHERE INCOME IN (
    SELECT INCOME
    FROM Employee
    GROUP BY INCOME
    HAVING COUNT(*) > 1
);

SELECT DISTINCT INCOME FROM Employee
ORDER BY INCOME
DESC LIMIT 1 OFFSET 1;

SELECT * FROM Employee UNION ALL SELECT * FROM Employee LIMIT 1;

SELECT DISTINCT e.* FROM Employee e
INNER JOIN Compensation c ON e.EMPLOYEE_ID = c.EMPLOYEE_REF_ID;

SELECT * FROM Employee
LIMIT (SELECT COUNT(*) FROM Employee) / 2;

SELECT DIVISION, COUNT(*) AS EMPLOYEE_COUNT FROM Employee
GROUP BY DIVISION
HAVING COUNT(*) < 5;

SELECT DIVISION, COUNT(*) AS EMPLOYEE_COUNT FROM Employee
GROUP BY DIVISION;

SELECT * FROM Employee
ORDER BY EMPLOYEE_ID DESC
LIMIT 1;

SELECT * FROM Employee
LIMIT 1;

SELECT * FROM (SELECT * FROM Employee
ORDER BY EMPLOYEE_ID DESC LIMIT 5) AS RecentRecords
ORDER BY EMPLOYEE_ID ASC;

SELECT e1.FIRST_NAME, e1.LAST_NAME, e1.INCOME, e1.DIVISION FROM Employee e1
WHERE (e1.DIVISION, e1.INCOME) IN (
    SELECT DIVISION, MAX(INCOME) AS MAX_INCOME FROM Employee
    GROUP BY DIVISION
);

SELECT DISTINCT INCOME FROM Employee
ORDER BY INCOME DESC
LIMIT 3;

SELECT DISTINCT INCOME FROM Employee
ORDER BY INCOME ASC
LIMIT 3;

SELECT DISTINCT INCOME FROM Employee
ORDER BY INCOME DESC
LIMIT 1 OFFSET 4;

SELECT DIVISION, SUM(INCOME) AS TOTAL_INCOME FROM Employee
GROUP BY DIVISION;

SELECT FIRST_NAME, LAST_NAME, INCOME FROM Employee
WHERE INCOME = (SELECT MAX(INCOME) FROM Employee);
