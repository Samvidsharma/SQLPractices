DROP DataBase ClassPracticesdb;

Create DataBase ClassPracticesdb;

USE ClassPracticesdb;

DROP table Bank;
Create table Bank
(
	Id int Constraint PK_Bank Primary Key Identity(1,1),
	[Name] Varchar(500) NOT NULL,
	Code varchar(500) NOT NULL Constraint UQ_Bank_Code Unique,
	CreatedDate DateTime NOT NULL,
	UpdatedDate DateTime NOT NULL
);
Delete from Bank;
INSERT INTO Bank ([Name],Code,CreatedDate,UpdatedDate) Values
	('State Bank Of India','SBI',GetDate(),GETDate()),
	('UNION Bank Of India','UNION',GetDate(),GetDate()),
	('CANARA BANK Of India','CAN',GetDate(),GetDate()),
	('ICICI Bank','ICICI',GetDate(),GetDate());
select * from Bank;

Drop table BankBranch;
Create table BankBranch
(
	Id int identity(1,1) Constraint PK_BankBranch Primary Key,
	Code varchar(500) Not Null Constraint UQ_BankBranch_Code Unique, 
	Address1 varchar(1000) Not Null ,
	Address2 varchar(1000),
	City varchar(500) NOT NULL,
	Dist varchar(500) NOT NULL,
	[State] varchar(500) NOT NULL,
	ZipCode varchar(10) NOT NULL,
	BankId int NOT NULL Constraint FK_BankBranch_Bank Foreign Key REFERENCES Bank(Id),
	CreatedDate DateTime NOT NULL,
	UpdatedDate DateTime NOT NULL
);

DELETE FROM BankBranch;
INSERT INTO BankBranch(Code,Address1,Address2,City,Dist,[State],ZipCode,BankId,CreatedDate,UpdatedDate) values
('SBI-Hyd-1','Gachibowli','Near ORR','Hyderabad','R.R.Dist','Telangana','500000',1,GetDate(),GetDate()),
('SBI-Hyd-2','Ibrahimpatnam','Near MRO Office','Hyderabad','R.R.Dist','Telangana','501506',1,GetDate(),GetDate()),
('UNION-Ibp-1','Ibrahimpatnam','Near Ashritha Degree College','Hyderabad','R.R.Dist','Telangana','501506',2,GetDate(),GetDate()),
('UNION-NWP-1','NandiWanaparty','Near BusStand','Warangal','Warangal Dist','Telangana','511508',2,GetDate(),GetDate()),
('CANARA-KMR-1','Kamareddy','Near Jeevadan School','Kamareddy','Kamareddy Dist','Telangana','500308',3,GetDate(),GetDate()),
('ICICI-Hyd-NRGuda-1','Nanakram Guda','Near Metro Station','Hyderabad','R.R.Dist','Telangana','551560',4,GetDate(),GetDate());

SELECT * FROM BankBranch;

DROP table Customer;
Create table Customer
(
	Id int identity(1,1) Constraint PK_Customer Primary Key,
	FirstName varchar(1000) NOT NULL,
	MiddleName varchar(1000),
	LastName varchar(1000) NOT NULL,
	Address1 varchar(1000) NOT NULL,
	Address2 varchar(1000),
	City varchar(500) not null,
	District varchar(500) not null,
	[State] varchar(500) not null,
	ZipCode varchar(10) not null,
	CreatedDate DateTime NOT NULL,
	UpdatedDate DateTime NOT NULL
);

Delete From Customer;
INSERT INTO Customer(FirstName,MiddleName,LastName,Address1,Address2,City,District,[State],ZipCode,CreatedDate,UpdatedDate) Values 
('SAMVID',null,'SHARMA','IBP','Near SBI','HYD','RR.Dist','Telangana','501506',GETDATE(),GETDATE()),
('Sudhamshu',null,'SHARMA','IBP','Near OC Commity Hall ','HYD','RR.Dist','Telangana','501506',GETDATE(),GETDATE()),
('Srivasthava',null,'SHARMA','IBP','Near Nagara Panchayathi','HYD','RR.Dist','Telangana','501506',GETDATE(),GETDATE()),
('Rahul','Kumar','JayPrakash','Piro','Near Shiva Temple','ARA','Bhojpur','Bihar','801202',GETDATE(),GETDATE());

SELECT * FROM Customer;

DROP table Account;
Create table Account
(
	Id int identity(1,1) Primary Key,
	CustomerId int NOT NULL Constraint FK_Account_Customer REFERENCES Customer(Id),
	BankId int NOT NULL Constraint FK_Account_Bank REFERENCES Bank(Id),
	BrachId int NOT NULL Constraint FK_Account_BankBranch REFERENCES BankBranch(Id),
	AccountType varchar(500) NOT NULL,
	IsActive bit NOT NULL Constraint DF_Account_IsActive DEFAULT(1),
	Balance money NOT NULL,
	CreatedDate DateTime NOT NULL,
	UpdatedDate DateTime NOT NULL
);

SELECT * FROM Customer;
SELECT * FROM Bank;
SELECT * FROM BankBranch;
INSERT INTO Account(CustomerId,BankId,BrachId,AccountType,IsActive,Balance,CreatedDate,UpdatedDate) Values 
(1,1,1,'Savings',1,2000,GETDATE(),GETDATE()),
(1,2,3,'Savings',1,5000,GETDATE(),GETDATE()),
(2,1,2,'Savings',1,10000,GETDATE(),GETDATE()),
(2,3,5,'Savings',1,3000,GETDATE(),GETDATE()),
(3,4,6,'Savings',1,15000,GETDATE(),GETDATE()),
(3,4,6,'Salary',1,200000,GETDATE(),GETDATE()),
(4,1,1,'Salary',1,30000,GETDATE(),GETDATE()),
(4,2,3,'Savings',1,5000,GETDATE(),GETDATE());

Select * From Account


Drop table Transactions;
Create table Transactions
(
	Id int Identity(1,1) NOT NULL Primary Key,
	AccountId int NOT NULL Constraint FK_Transactions_Account Foreign Key REFERENCES Account(Id),
	[Transcation Type] varchar(500) NOT NULL,
	Amount money not null,
	TransactionTime DateTime not null,
	CreatedDate DateTime NOT NULL,
	UpdatedDate DateTime NOT NULL
);

Select * From Account

Delete From Transactions;
INSERT INTO Transactions(AccountId,[Transcation Type],Amount,TransactionTime,CreatedDate,UpdatedDate) VALUES 
(1,'Deposit',200,cast(getdate() as time),GETDATE(),GETDATE()),
(2,'WithDraw',500,cast(getdate() as time),GETDATE(),GETDATE()),
(2,'Deposit',1000,cast(getdate() as time),GETDATE(),GETDATE()),
(3,'Deposit',800,cast(getdate() as time),GETDATE(),GETDATE()),
(4,'With Draw',100,cast(getdate() as time),GETDATE(),GETDATE()),
(5,'With Draw',300,cast(getdate() as time),GETDATE(),GETDATE()),
(6,'Deposit',1000,cast(getdate() as time),GETDATE(),GETDATE()),
(7,'Deposit',100,cast(getdate() as time),GETDATE(),GETDATE()),
(8,'Withdraw',200,cast(getdate() as time),GETDATE(),GETDATE())

Select * From Transactions


-- 1. 
Select * From Account
Select * From Account Where BankId = 1
Select * From Customer Left Join Account on Customer.Id = Account.CustomerId Where (BankId = 1 or BankId = (select Id from Bank where Bank.Code = 'UNION-NWP-1'));

-- 2. 
Select * From Account
Select Max(Balance) From Account Where BankId = 1 
Select Max(Balance) From Account Where BankId = 2 
Select Max(Balance) From Account Where BankId = 3 
Select Max(Balance) From Account Where BankId = 4

--3.