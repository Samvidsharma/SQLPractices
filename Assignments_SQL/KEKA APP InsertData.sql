INSERT INTO Skills(SkillId,SkillName) Values 
(1,'C'),
(2,'C++'),
(3,'java'),
(4,'python'),
(5,'Dotnet'),
(6,'C#'),
(7,'HTML5'),
(8,'CSS5'),
(9,'BootStrap'),
(10,'Javascript'),
(11,'JQuery'),
(12,'Angular'),
(13,'SQL'),
(14,'LINQ'),
(15,'EntityFrameWork'),
(16,'ADO.Net'),
(17,'Dapper'),
(18,'Asp.net web api'),
(19,'Networking');


INSERT INTO SkillLevel (SkillLevelId,LevelName)
VALUES
(1,'Beginner'),
(2,'Advanced Beginner'),
(3,'Intermediate'),
(4,'Advanced'),
(5,'Expertise')

SELECT * FROM Employee
Update Employee
Set EmployeePin = 'QLC0001' where EmployeeId=1

update Employee
set EmployeeName ='Saraswathi'
where EmployeePin = 'QLC0007'

INSERT INTO Employee (EmployeeName,EmployeePin,Gender,DateOfBirth,EmailId,MobileNumber)
Values
--('GANESH','QLH0001','Male','1985','Ganesh@qm.com',9999999999),
('Vishnu','QLC0002','Male','1985','Vishnu@qm.com',9999998899),
('Shiva','QLC0003','Male','1985','Shiva@qm.com',9999956999),
('Brahma','QLC0004','Male','1985','Brahma@qm.com',9994599999),
('Parvathi','QLC0005','FeMale','1985','Parvathi@qm.com',9999332999),
('Laxmi','QLC0006','FeMale','1985','Laxmi@qm.com',9999975699),
('Sartswathi','QLC0007','FeMale','1985','Sartswathi@qm.com',9911999999),
('Indra','QLM0001','Male','1985','Indra@qm.com',9999888999)

INSERT INTO PasswordHelp(EmployeeId,EmailPassword)
Values
(1,'Ganesh123$'),
(8,'vishnu123#'),
(9,'Shiva123@'),
(10,'Brahma123&'),
(11,'Parvathi321@'),
(12,'Laxmi321$'),
(13,'Saraswathi321&'),
(14,'IndraKing123'),

SELECT * FROM PasswordHelp p
inner join Employee e
on p.EmployeeId = e.EmployeeId

INSERT INTO [USER] (EmployeeId)
(select EmployeeId From Employee)

Select * FROM [USER];

INSERT INTO [ROLE](RoleName,[Description])
VALUES
('Chief executive officer','A CEO is a leading role responsible for making top-level decisions'),
('Chief operating officer','A COO oversees the company''s operations.'),
('Chief technology officer','The CTO manages the technological functions of their organization. They commonly integrate new technology trends and ensure any technology they introduce meets the needs of their company.'),
('Human resources manager','Human resources managers direct the human resources department.')

select * from [Role]


INSERT INTO Department(DepartmentName,[Description])
values
('Information Technology','Information technology (IT) is the use of any computers, storage, networking and other physical devices, infrastructure and processes to create, process, store, secure and exchange all forms of electronic data.'),
('Admin Department','The admin department does everything from maintaining office equipment like fax machines, telephones, and scanners, to updating the blog or website of a company to maintain a significant online presence.'),
('Human Resource Management','The HR or Human Resources team is a vital department for any organization. It maximizes employees’ productivity and protects a company from any problems that might take place in the workforce.'),
('Sales and Marketing Department','The sales and marketing department is an integral unit of an IT enterprise. It sets realistic sales goals, annually, monthly, weekly, or daily. ')

select * from Department;
Alter table Designation
Alter column DesignationName varchar(50)
INSERT INTO Designation(DesignationName,[Description])
Values
('Associate Software Engineer',''),
('Software Engineer',''),
('Senior Software Engineer',''),
('Principal Software Engineer',''),
('Director Of Product Engineering',''),
('Technical Lead',''),
('Senior Technical Lead',''),
('DevOps Engineer',''),
('Senior DevOps Engineer',''),
('Technical Architect',''),
('Senior Technical Architect',''),
('Director Of Operations',''),
('HR Manager',''),
('HR Executive',''),
('Inside Sales Executive',''),
('Managing Director',''),
('CEO',''),

SELECT * FROM Designation


SELECT * FROM PasswordHelp p
inner join Employee e
on p.EmployeeId = e.EmployeeId

select * from [User] u
inner join Employee e
on u.EmployeeId = e.EmployeeId
inner join PassWordHelp p
on p.EmployeeId = e.EmployeeId


DECLARE @__userEmailId_0 varchar(50) = 'Ganesh@qm.com';

SELECT [u].[UserId], [u].[CreatedDate], [u].[EmployeeId], [u].[IsActive], [u].[IsLocked], [u].[NoOfWrongAttempts], [u].[UpdatedDate], [e].[EmployeeId], [e].[CreatedByEmpId], [e].[CreatedDate], [e].[DateOfBirth], [e].[EmailId], [e].[EmployeeName], [e].[EmployeePin], [e].[Gender], [e].[IsActive], [e].[MobileNumber], [e].[UpdatedByEmpId], [e].[UpdatedDate]
FROM [User] AS [u]
LEFT JOIN [Employee] AS [e] ON [u].[EmployeeId] = [e].[EmployeeId]
WHERE [e].[EmailId] = @__userEmailId_0


DECLARE @__password_0 varchar(30) = 'Ganesh123';
DECLARE @__userEmailId_1 varchar(50) = 'Ganesh@qm.com';

SELECT [u].[UserId], [u].[EmployeeId], [u].[IsActive], [u].[IsLocked], [u].[NoOfWrongAttempts],[e].[EmailId], [e].[EmployeeName],[t].[PassWordHelpId], [t].[EmailPassword], [t].[EmployeeId], [t].[PasswordSalt]
FROM [User] AS [u]
LEFT JOIN [Employee] AS [e] ON [u].[EmployeeId] = [e].[EmployeeId]
Left JOIN (
    SELECT [p].[PassWordHelpId], [p].[EmailPassword], [p].[EmployeeId], [p].[PasswordSalt]
    FROM [PassWordHelp] AS [p]
    WHERE [p].[EmailPassword] = @__password_0
) AS [t] ON [e].[EmployeeId] = [t].[EmployeeId]
WHERE [e].[EmailId] = @__userEmailId_1
ORDER BY [u].[UserId], [e].[EmployeeId]