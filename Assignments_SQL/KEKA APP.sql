DROP DATABASE QMHRMApplication;

CREATE DATABASE QMHRMApplication;

USE QMHRMApplication;


--- 1. Create skills table, 2. Create Attendance Regularaisation Table, 3. Create Leave History Table 4.login-history. 5.Permissions Table
DROP TABLE Skills;
CREATE TABLE Skills
(
	SkillId INT Identity(1,1) CONSTRAINT PK_Skills_SkillId PRIMARY KEY,
	SkillName varchar(30) NOT NULL
);

CREATE TABLE SkillLevel
(
	SkillLevelId INT CONSTRAINT PK_SkillLevel_SkillLevelId PRIMARY KEY,
	LevelName varchar(20)
);


CREATE TABLE Employee
(
	EmployeeId INT IDENTITY(1,1) CONSTRAINT PK_Employee_EmployeeId PRIMARY KEY,
	EmployeeName VARCHAR(50) NOT NULL,
	EmployeePin VARCHAR(30) NOT NUll,
	Gender VARCHAR(10) NOT NULL,
	DateOfBirth DATETIME2 NOT NULL,
	EmailId VARCHAR(50) NOT NULL CONSTRAINT UQ_Employee_EmailId UNIQUE,
	MobileNumber VARCHAR(10) NOT NULL CONSTRAINT UQ_EMPLOYEE_MobileNumber UNIQUE,
	IsActive bit CONSTRAINT DF_Employee_IsActive DEFAULT(1),
	CreatedByEmpId INT NOT NULL CONSTRAINT DF_Employee_CreatedByEmpId DEFAULT(1) CONSTRAINT FK_Employee_User_CreatedByEmpId FOREIGN KEY REFERENCES Employee(EmployeeId),
	UpdatedByEmpId INT NOT NULL CONSTRAINT DF_Employee_UpdatedByEmpId DEFAULT(1) CONSTRAINT FK_Employee_User_UpdatedByEmpId FOREIGN KEY REFERENCES Employee(EmployeeId),
	CreatedDate DateTime2 NOT NULL CONSTRAINT DF_Employee_CreatedDate DEFAULT(GetDate()), 
	UpdatedDate DateTime2 NOT NULL CONSTRAINT DF_Employee_UpdatedDate DEFAULT(GetDate()) 
);

CREATE TABLE PassWordHelp
(
PassWordHelpId INT IDENTITY(1,1) CONSTRAINT PK_PassWordHelp_PassWordHelpId PRIMARY KEY,
EmployeeId INT CONSTRAINT FK_PassWordHelp_Employee_EmployeeId FOREIGN KEY REFERENCES Employee(EmployeeId),
EmailPassword varchar(30) NOT NULL CONSTRAINT UQ_Employee_EmployeePassword UNIQUE,
PasswordSalt varchar(30)
);

CREATE TABLE [User]
(
	UserId INT IDENTITY(1,1) CONSTRAINT PK_User_USERID PRIMARY KEY,
	EmployeeId INT CONSTRAINT FK_User_Employee_EmployeeId FOREIGN KEY REFERENCES Employee(EmployeeId),
	IsActive bit CONSTRAINT DF_User_IsActive DEFAULT(1),
	IsLocked bit CONSTRAINT DF_User_IsLocked DEFAULT(0),
	NoOfWrongAttempts INT DEFAULT(0),
	CreatedDate DateTime2 CONSTRAINT DF_User_CreatedDate DEFAULT(GetDate()), 
	UpdatedDate DateTime2 CONSTRAINT DF_User_UpdatedDate DEFAULT(GetDate()) 
);

select * from User

DROP TABLE LoginHistory;
CREATE Table LoginHistory
(
	LoginHistoryId INT Identity CONSTRAINT PK_LoginHistory_LoginHistoryId Primary KEY,
	UserId INT CONSTRAINT FK_LoginHistory_User_UserId REFERENCES [User](userId),
	LoginTime DateTime2 NOT NULL,
	LogoutTime DateTime2,
)

CREATE TABLE Role
(
	RoleId INT identity(1,1) CONSTRAINT PK_Role_RoleId PRIMARY KEY,
	RoleName varchar(30) NOT NULL,
	IsActive bit CONSTRAINT DF_Role_IsActive DEFAULT(1),
	[Description] text, 
	CreatedByUserId INT NOT NULL CONSTRAINT DF_Role_CreatedByUserId DEFAULT(1) CONSTRAINT FK_Role_User_CreatedByUserId FOREIGN KEY REFERENCES [User](userId),
	UpdatedByUserId INT NOT NULL CONSTRAINT DF_Role_UpdatedByUserId DEFAULT(1) CONSTRAINT FK_Role_User_UpdatedUserId FOREIGN KEY REFERENCES [User](userId),
	CreatedDate DateTime2 NOT NULL CONSTRAINT DF_Role_CreatedDate DEFAULT(GetDate()), 
	UpdatedDate DateTime2 NOT NULL CONSTRAINT DF_Role_UpdatedDate DEFAULT(GetDate())
);


CREATE TABLE DEPARTMENT
(
	DepartmentId INT IDENTITY(1,1) CONSTRAINT PK_Department_DepartmentId PRIMARY KEY,
	DepartmentName VARCHAR(50) NOT NULL,
	[Description] text,
	IsActive bit CONSTRAINT DF_Department_IsActive DEFAULT(1),
	CreatedByUserId INT NOT NULL CONSTRAINT DF_Department_CreatedByUserId DEFAULT(1) CONSTRAINT FK_Department_User_CreatedByUserId FOREIGN KEY REFERENCES [User](userId),
	UpdatedByUserId INT NOT NULL CONSTRAINT DF_Department_UpdatedByUserId DEFAULT(1) CONSTRAINT FK_Department_User_UpdatedByUserId FOREIGN KEY REFERENCES [User](userId),
	CreatedDate DateTime2 NOT NULL CONSTRAINT DF_Department_CreatedDate DEFAULT(GetDate()), 
	UpdatedDate DateTime2 NOT NULL CONSTRAINT DF_Department_UpdatedDate DEFAULT(GetDate())
);


CREATE TABLE Designation
(
	DesignationId INT IDENTITY(1,1) CONSTRAINT PK_Designation_DesignationId PRIMARY KEY,
	DesignationName Varchar(30) NOT NULL,
	[Description] text,
	IsActive bit CONSTRAINT DF_Designation_IsActive DEFAULT(1),
	CreatedByUserId INT NOT NULL CONSTRAINT DF_Designation_CreatedByUserId DEFAULT(1) CONSTRAINT FK_Designation_User_CreatedByUserId FOREIGN KEY REFERENCES [User](userId),
	UpdatedByUserId INT NOT NULL CONSTRAINT DF_Designation_UpdatedByUserId DEFAULT(1) CONSTRAINT FK_Designation_User_UpdatedByUserId FOREIGN KEY REFERENCES [User](userId),
	CreatedDate DateTime2 NOT NULL CONSTRAINT DF_Designation_CreatedDate DEFAULT(GetDate()), 
	UpdatedDate DateTime2 NOT NULL CONSTRAINT DF_Designation_UpdatedDate DEFAULT(GetDate())
);


CREATE TABLE EmployeeDetails
(
	EmployeeDetailsId INT IDENTITY(1,1) CONSTRAINT PK_EmployeeDetails_EmployeeDetailsId PRIMARY KEY,
	EmployeeId INT CONSTRAINT FK_EmployeeDetails_Employee_EmployeeId FOREIGN KEY REFERENCES Employee(EmployeeId),
	RoleId INT CONSTRAINT FK_Employee_Role_RoleId FOREIGN KEY REFERENCES ROLE(RoleId) ,--- M
	DepartmentId INT CONSTRAINT FK_Employee_Department_DepartmentId FOREIGN KEY REFERENCES Department(DepartmentId),
	DesignationId INT CONSTRAINT FK_Employee_Designation_DesignationId FOREIGN KEY REFERENCES Designation(DesignationId),
	ReportingToUserId INT NOT NULL CONSTRAINT DF_Employee_User_ReportingToUserId DEFAULT(1) CONSTRAINT FK_Employee_User_CreatedByUserId FOREIGN KEY REFERENCES [User](userId),
)
Create Table EmployeeSkills
(
	EmployeeSkillsId INT IDENTITY(1,1) CONSTRAINT PK_EmployeeSkills_EmployeeSkillsId PRIMARY KEY,
	EmployeeId INT CONSTRAINT FK_EmployeeSkills_Employee_EmployeeId FOREIGN KEY REFERENCES Employee(EmployeeId),
	SkillId INT  CONSTRAINT FK_EmployeeSkills_Skills_SkillId FOREIGN KEY REFERENCES Skills(SkillId),
	SkillLevel INT  CONSTRAINT FK_EmployeeSkills_SkillLevel_SkillLevelId FOREIGN KEY REFERENCES SkillLevel(SkillLevelId)
	
);

CREATE TABLE AddressType
(
	AddressTypeId INT CONSTRAINT PK_AddressType_AddressTypeId PRIMARY KEY,
	AddressType Varchar(30) NOT NULL
);

CREATE TABLE Address
(
	AddressId INT identity(1,1) CONSTRAINT PK_Address_AddressId PRIMARY KEY,
	EmployeeId INT CONSTRAINT FK_Address_Employee_EmployeeId FOREIGN KEY REFERENCES Employee(EmployeeId),
	AddressTypeId INT CONSTRAINT FK_Address_Employee_AddressType_AddressTypeId FOREIGN KEY REFERENCES AddressType(AddressTypeId),
	HouseNumber VARCHAR(30) NOT NULL,
	LandMark VARCHAR(30),
	AddressLine Varchar(30),
	City VARCHAR(30) NOT NULL,
	District VARCHAR(30) NOT NULL,
	ZipCode Varchar(6) NOT NULL,
	State VARCHAR(30) NOT NULL,
	Country VARCHAR(30) NOT NULL,
	IsActive bit CONSTRAINT DF_Address_IsActive DEFAULT(1),
	CreatedByUserId INT NOT NULL CONSTRAINT DF_Address_CreatedByUserId DEFAULT(1) CONSTRAINT FK_Address_User_CreatedByUserId FOREIGN KEY REFERENCES [User](userId),
	UpdatedByUserId INT NOT NULL CONSTRAINT DF_Address_UpdatedByUserId DEFAULT(1) CONSTRAINT FK_Address_User_UpdatedByUserId FOREIGN KEY REFERENCES [User](userId),
	CreatedDate DateTime2 NOT NULL CONSTRAINT DF_Address_CreatedDate DEFAULT(GetDate()), 
	UpdatedDate DateTime2 NOT NULL CONSTRAINT DF_Address_UpdatedDate DEFAULT(GetDate()) 
);



CREATE TABLE LeaveType
(
	LeaveTypeId INT CONSTRAINT PK_LeaveType_LeaveTypeId Primary Key,
	LeaveTypeName VARCHAR(20) NOT NULL
);

CREATE TABLE RequestedStatus
(
	RequestedStatusId INT CONSTRAINT PK_RequestedStatus_RequestedStatusId PRIMARY KEY,
	[Status] Varchar(20) NOT NULL
);

CREATE TABLE EmployeeLeave
(
	EmployeeLeaveId INT identity(1,1) CONSTRAINT PK_EmployeeLeave_EmployeeLeaveId PRIMARY KEY,
	LeaveTypeId INT CONSTRAINT FK_EmployeeLeave_LeaveType_LeaveTypeId FOREIGN KEY REFERENCES LeaveType(LeaveTypeId),
	StartDate DATETIME2 NOT NULL,
	EndDate Datetime2 NOT NULL,
	numberOfDays INT NOT NULL,
	Description Varchar(30),
	AppliedByEmpId INT CONSTRAINT FK_EmployeeLeave_Employee_AppliedByEmpId FOREIGN KEY REFERENCES Employee(EmployeeId),
	AppliedDate Datetime2 NOT NULL,
	ReportedToUserId INT CONSTRAINT FK_EmployeeLeave_User_ReportedToUserId FOREIGN KEY REFERENCES [User](userId),
	
);

DROP TABLE LeavesProvided
CREATE TABLE LeavesProvided
(
	LeavesProvidedId INT identity(1,1) CONSTRAINT PK_LeavesProvided_LeavesProvidedId Primary Key,
	EmployeeId INT CONSTRAINT FK_LeavesProvided_Employee_EmployeeId FOREIGN KEY REFERENCES Employee(EmployeeId),
	LeaveTypeId INT CONSTRAINT FK_LeavesProvided_LeaveType_LeaveTypeId FOREIGN KEY REFERENCES LeaveType(LeaveTypeId),
	NumberOfLeavesProvided INT NOT NULL,
	LeavesConsumed INT NOT NULL CONSTRAINT DF_LeavesProvided_LeavesConsumed Default(0),
	ProvidedDate datetime2 NOT NULL,
	UpdatedDate datetime2 NOT NULL,
	ProvidedByUserId INT NOT NULL CONSTRAINT DF_LeavesProvided_ProvidedByUserId DEFAULT(1) CONSTRAINT FK_LeavesProvided_User_CreatedByUserId FOREIGN KEY REFERENCES [User](userId),
	UpdatedByUserId INT NOT NULL CONSTRAINT DF_LeavesProvided_UpdatedByUserId DEFAULT(1) CONSTRAINT FK_LeavesProvided_User_UpdatedByUserId FOREIGN KEY REFERENCES [User](userId), 
);

DROP Table LeavesHistory;
CREATE TABLE LeavesHistory
(
	LeavesHistoryId INT identity(1,1) CONSTRAINT PK_LeavesHistory_LeavesHistoryId Primary Key,
	EmployeeLeaveId INT CONSTRAINT FK_LeavesHistory_EmployeeLeave_EmployeeLeaveId FOREIGN KEY REFERENCES EmployeeLeave(EmployeeLeaveId),
	UpdatedByUserId INT NOT NULL CONSTRAINT FK_LeavesHistory_User_UpdatedByUserId FOREIGN KEY REFERENCES [User](userId)
								 Constraint DF_LeavesHistory_UpdatedByUserId DEFAULT(1),
	StatusId INT CONSTRAINT FK_EmployeeLeave_RequestedStatus_RequestedStatusId FOREIGN KEY  REFERENCES RequestedStatus(RequestedStatusId),
	--PerviousHistory int,
	UpdatedDate DateTime2 CONSTRAINT DF_EmployeeLeave_ApprovedDate Default(Null),
	UpdateComment varchar(20)
);

CREATE TABLE Attendance
(
	AttendanceId INT identity(1,1) CONSTRAINT PK_Attendance_AttendanceId Primary Key,
	EmployeeID INT NOT NULL CONSTRAINT FK_Attendance_Employee_EmployeeId FOREIGN KEY REFERENCES Employee(EmployeeId),
	DateOfLog DateTime NOT NULL,
	LoginTime time NOT NULL,
	LogoutTime time ,
	LateBy TIME CONSTRAINT DF_Attendance_LateBy DEFAULT(null), 
	RequestedDate datetime2 NOT NULL,
	AttendanceType varchar Default('Normal Type'), --- Attendace type may be regularaize type.
);

CREATE TABLE AttendanceHistory
(
	AttendanceHistoryId INT IDENTITY(1,1) CONSTRAINT PK_AttendanceHistory_AttendanceHistoryId PRIMARY KEY,
	AttendanceId INT CONSTRAINT FK_AttendanceHistory_Attendance_AttendanceId REFERENCES Attendance(AttendanceId),
	UpdatedbyUserId INT CONSTRAINT FK_AttendanceHistory_User_UpdatedByUserId FOREIGN KEY REFERENCES [User](userId),
	UpdatedDate DateTime,
	Note varchar NOT NULL, 
	StatusId INT CONSTRAINT FK_Attendance_RequestedStatus_RequestedStatusId FOREIGN KEY REFERENCES RequestedStatus(RequestedStatusId),
);

CREATE TABLE Salary
(
	SalaryId INT identity(1,1) CONSTRAINT PK_Salary_SalaryId Primary Key,
	EmployeeId INT CONSTRAINT FK_Salary_Employee_EmployeeId FOREIGN KEY REFERENCES Employee(EmployeeId),
	DepartmentId INT CONSTRAINT FK_Salary_Department_DepartmentId FOREIGN KEY REFERENCES Department(DepartmentId),
	DesignationId INT CONSTRAINT FK_Salary_Designation_DesignationId FOREIGN KEY REFERENCES Designation(DesignationId),
	Salary money NOT NULL,
);

CREATE TABLE Holiday
(
	HolidayId INT identity(1,1) CONSTRAINT PK_Holiday_HoidayId Primary KEY,
	HolidayName varchar(30) NOT NULL,
	IsActive bit CONSTRAINT DF_Holiday_IsActive DEFAULT(1),
	CreatedByUserId INT NOT NULL CONSTRAINT DF_Holiday_CreatedByUserId DEFAULT(1) CONSTRAINT FK_Holiday_User_CreatedByUserId FOREIGN KEY REFERENCES [User](userId),
	UpdatedByUserId INT NOT NULL CONSTRAINT DF_Holiday_UpdatedByUserId DEFAULT(1) CONSTRAINT FK_Holiday_User_UpdatedByUserId FOREIGN KEY REFERENCES [User](userId),
	CreatedDate DateTime2 NOT NULL, 
	UpdatedDate DateTime2 NOT NULL 
);

DROP TABLE Poll

CREATE TABLE Poll
(
	PollId INT identity(1,1) Constraint PK_Poll_PollId PRIMARY KEY,
	PollName Varchar(25) NOT NULL,
	[Description] text,
	CreatedByUserId INT NOT NULL CONSTRAINT DF_Poll_CreatedByUserId DEFAULT(1) CONSTRAINT FK_Poll_User_CreatedByUserId FOREIGN KEY REFERENCES [User](userId),
	UpdatedByUserId INT NOT NULL CONSTRAINT DF_Poll_UpdatedByUserId DEFAULT(1) CONSTRAINT FK_Poll_User_UpdatedByUserId FOREIGN KEY REFERENCES [User](userId),
	CreatedDate DateTime2 NOT NULL CONSTRAINT DF_Poll_CreatedDate DEFAULT(GetDate()), 
	UpdatedDate DateTime2 NOT NULL CONSTRAINT DF_Poll_UpdatedDate DEFAULT(GetDate()) 
);

CREATE TABLE PollVote
(
	VoteId INT identity(1,1) Constraint PK_PollVote_VoteId Primary Key,
	EmployeeId INT CONSTRAINT FK_PollVote_Employee_EmployeeId FOREIGN KEY REFERENCES Employee(EmployeeId),
	Comment varchar(50),
);

CREATE TABLE POST
(
	PostId INT identity(1,1) Constraint PK_Post_PostId Primary Key,
	PostName varchar(25) NOT NULL,
	[Description] text,
	CreatedByUserId INT NOT NULL CONSTRAINT DF_Post_CreatedByUserId DEFAULT(1) CONSTRAINT FK_Post_User_CreatedByUserId FOREIGN KEY REFERENCES [User](userId),
	UpdatedByUserId INT NOT NULL CONSTRAINT DF_Post_UpdatedByUserId DEFAULT(1) CONSTRAINT FK_Post_User_UpdatedByUserId FOREIGN KEY REFERENCES [User](userId),
	CreatedDate DateTime2 NOT NULL CONSTRAINT DF_Post_CreatedDate DEFAULT(GetDate()), 
	UpdatedDate DateTime2 NOT NULL CONSTRAINT DF_Post_UpdatedDate DEFAULT(GetDate()) 
);

CREATE TABLE PostComment
(
	PostComment INT IDENTITY(1,1) CONSTRAINT PK_PostComment_PostCommentId PRIMARY KEY,
	PostId INT CONSTRAINT FK_PostComment_Post_PostId Foreign key REFERENCES Post(postId),
	CommentedByEmpId INT CONSTRAINT FK_PostComment_Employee_EmployeeId FOREIGN KEY REFERENCES Employee(EmployeeId),
	Comment varchar(50)
);

CREATE TABLE [Permissions]
(
	PermissionsId INT CONSTRAINT PK_Permissions_PermissionsId Primary key,
	Permission varchar(50) NOT NULL
);

CREATE TABLE UserPermissions
(
	UserPermissionsId INT identity(1,1) CONSTRAINT PK_UserPermissions_UserPermissionsId Primary key,
	UserId INT CONSTRAINT FK_UserPermissions_UserPermissionsId Foreign Key REFERENCES [User](UserId),
	[Permission] varchar(50),-- from permission table as , format
);