CREATE TABLE EMPLOYEE
(
	EmployeeId int identity(1,1) CONSTRAINT PK_EMPLOYEE_EmployeeId PRIMARY KEY,
	EmployeeName varchar(20) NOT NULL,
	ESalary MONEY NOT NULL,
	Eage int NOT NULL,
	EGender Varchar(10) NOT NULL,
	EDept varchar(30) NOT NULL
);

INSERT INTO EMPLOYEE (EmployeeName,ESalary,Eage,EGender,EDept) VALUES
	('SAM',95000,45,'MALE','OPERATIONS'),
	('BOB',80000,21,'MALE','SUPPORT'),
	('ANNE',125000,25,'FEMALE','ANALYTICS'),
	('JULIA',73000,30,'FEMALE','ANALYTICS'),
	('MATT',159000,33,'MALE','SALES'),
	('JEFF',112000,27,'MALE','OPERATIONS');
	GO

CREATE PROCEDURE SP_GetEmployeesByAge(@age int) 
AS
BEGIN
SELECT * FROM EMPLOYEE e
WHERE e.Eage >30
END
GO 

CREATE PROCEDURE SP_UpdateSupportEmployee(@EmpName varchar(20),@EmpSalary money,@Eage int,@Egender varchar(10),@Edept varchar(30))
AS
BEGIN
UPDATE EMPLOYEE 
SET 
	EmployeeName = @EmpName, 
	ESalary = @EmpSalary,
	Eage = @Eage,
	EGender = @Egender,
	EDept = @Edept
WHERE EDept = 'SUPPORT'
END
GO

EXEC SP_GetEmployeesByAge 30;
GO 

EXEC SP_UpdateSupportEmployee 'SAMVID',30000,23,'MALE','IT'
GO