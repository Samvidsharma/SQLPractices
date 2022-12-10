-- DROP DATABASE ClassPracticesdb;

CREATE DATABASE ClassPracticesdb;

USE ClassPracticesdb;

------------------------------------------- 1. Creating the tables ----------------------------------------------------
--DROP TABLE Deposit;
create table Deposit
(
	Actno varchar(5) Not Null,
	CName varchar(20) not null Constraint CHK_Deposit_CName Check(len(CName)>5),
	BName varchar(20) Constraint PK_Deposit Primary key,
	Amount numeric(8,2) not null Constraint CHK_Deposit_Amount Check(Amount>0),
	ADate Date
);
Alter table Deposit Drop Constraint CHK_Deposit_CName
	

SELECT * FROM Deposit;

-- DROP TABLE Branch;
create table Branch
(
	BName varchar(20) Constraint FK_Branch_Deposit Foreign key references Deposit(BName),
	City varchar(20) 
	Constraint PK_Branch Primary key (City)
)

-- DELETE TABLE Customer;
Create table Customer(
	CName varchar(20) Constraint PK_Customer Primary key,
	City varchar(20),
	Constraint FK_Customer_Branch Foreign Key(City) references Branch(City)
)

-- DELETE TABLE Borrow;
Create table Borrow
(
	LoanNo varchar(5) not null,
	CName varchar(20) Constraint FK_Borrow_Customer Foreign Key references Customer(CName),
	BName varchar(20) Constraint FK_Borrow_Deposit Foreign key references Deposit(BName),
	Amount numeric(8,2) not null Constraint CHK_Borrow_Amount check(Amount>0)
)

---------------------------------2. Describing about the created tables. ----------------------------------------------
Exec sp_help Deposit;
Exec sp_help Customer;
Exec sp_help Branch;
Exec sp_help Borrow;

------------------------------- 3. Finding the tables which are created by the user ------------------------------
select Table_Name 
From INFORMATION_SCHEMA.TABLES
where TABLE_TYPE = 'Base Table'
-- We can also use Alt + F1 keys.

--------------------------------------------- 4. Inserting the data ----------------------------------------------
---- Deposit table------
Delete from Deposit;

Insert into Deposit(Actno,CName,BName,Amount,ADate) values ('100','ANIL','VRCE',1000.00,'01-Mar-1995');
Insert into Deposit(Actno,CName,BName,Amount,ADate) values (101,'SUNIL','MGROAD',5000.00,'04-Jan-1996');
INSERT INTO Deposit(Actno,CName,BName,Amount,ADate) values (102,'RAHUL','KAROLBAGH',3500.00,'17-Nov-1995');
INSERT INTO Deposit(Actno,CName,BName,Amount,ADate)
	values
	(103,'MADHURI','CHANDANI',1200.00,'17-Dec-1995'),
	(104,'PRAMOD','MGROAD2',3000.00,'27-Mar-1996'),
	(105,'SANDEEP','K-Bagh',2000.00,'31-Mar-1996');

select * from Deposit

--------- Branch Table -----
Delete from Branch;

INSERT INTO Branch(BName,City) values
	('VRCE','NAGPUR'),
	('KAROLBAGH','DELHI'),
	('CHANDANI','AGRA'),
	('MGROAD','BANGLORE'),
	('K-Bagh','DELHI-REDFORT'),
	('MGROAD2','BANGLORE-SilkBoard')

Select * From Branch;

------- Customer Table ----------

DELETE FROM Customer;

INSERT INTO Customer(CName,City) VALUES
	('ANIL','DELHI'),
	('RAHUL','BANGLORE'),
	('MADHURI','NAGPUR'),
	('PRAMOD','NAGPUR'),
	('SUNIL','DELHI-REDFORT')
SELECT * FROM Customer;

------- BORROW Table -----------

Delete from Borrow;
INSERT INTO Borrow(LoanNo,CName,BName,Amount) values
	(201,'ANIL','VRCE',1000.00),
	(206,'RAHUL','KAROLBAGH',5000.00),
	(311,'SUNIL','MGROAD',3000.00),
	(321,'MADHURI','CHANDANI',2000.00),
	(375,'PRAMOD','MGROAD',8000.00)
SELECT * FROM Borrow;

------------------------------ 5. Retriving the data from Deposit table ---------------------
SELECT * FROM Deposit;
 
------------------------------ 6. Retriving the Customer name and Account Number from Deposit table-------------
SELECT CName, Actno from Deposit;

------------------------------ 7. Retriving the name of Customer living in Nagpur -------------------------------
SELECT CName From Customer WHERE City = 'NAGPUR';

------------------------------ 8. Retriving the name of customers Who opened account after 17-Nov-1995 -----------
SELECT CName From Deposit Where ADate > '17-Nov-1995';

------------------------------ 9.Retrive the Account number and amount of the customer having account 
															-- opened between 01-12-95 and 01-06-96 ------------------
SELECT Actno,Amount From Deposit WHERE ADate>='01-Dec-1995' and ADate <='01-June-96'

----------------------------- 10. Retrive all the records From the table Deposit where CName starts with C -------------------------
SELECT * From Deposit WHERE CName Like 'C%';

----------------------------- 11. Retrive all the records From the table Borrow where 2nd character of CName is U ------------------
SELECT * FROM Borrow WHERE CName like '_U%';

----------------------------- 12. Retrive all the records From the table Deposit where Branch name is CHANDANI or MGROAD -----------
SELECT * FROM Deposit WHERE BName = 'CHANDANI' OR BName = 'MGROAD';

----------------------------- 13. Retrive all the records From the table Deposit where Branch name is not CHANDANI or MGROAD --------
SELECT * FROM Deposit WHERE not (BName = 'CHANDANI' OR BName = 'MGROAD'); 

----------------------------- 14. Retrive all the records From the table Borrow where amount in between 2000 and 3000  -----------
SELECT * FROM Borrow WHERE Amount BETWEEN 2000 AND 3000;

----------------------------- 15. Calculate TA(10% of amount), DA(20% of amount) and
								-- Total of each customer from BORROW table also project CName and Amount -----------	

-- SELECT Amount/10 as [TA] From Borrow; 
-- SELECT Amount/5 as [PA] From Borrow; 
SELECT CName,Amount,Amount/10 as [TA],Amount/5 as [DA], Amount/10 + Amount/5 as [Total] FROM Borrow
