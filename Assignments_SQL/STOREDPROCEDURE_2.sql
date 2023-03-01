CREATE TYPE EmployeeObject AS TABLE 
(
	Ename varchar(20) NOT NULL,
	Esalary money NOT NULL,
	Eage int NOT NULL,
	Egender varchar(10) NOT NULL,
	Edept varchar(20) NOT NULL
);
GO 

Declare @Emp1 EmployeeObject
Insert into @Emp1 Values
(
'Sudhamshu',40000,22,'MALE','IT'
)
SELECT * FROM @Emp1
GO

CREATE PROCEDURE InsertEmployee(@EmployeeTable EmployeeObject readonly) AS 
BEGIN
INSERT INTO EMPLOYEE SELECT * FROM @EmployeeTable
END
GO

Declare @Emp1 EmployeeObject
Insert into @Emp1 Values
(
'Sudhamshu',40000,22,'MALE','IT'
)
SELECT * FROM @Emp1
EXEC InsertEmployee @Emp1 
GO

SELECT * FROM EMPLOYEE
