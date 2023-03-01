create table Deposit(
Actno varchar(5) Not Null ,
CName varchar(20) not null Constraint CHK_Deposit_CName Check(len(CName)>5),
BName varchar(20) Constraint PK_Deposit Primary key,
Amount numeric(8,2) not null Constraint CHK_Deposit_Amount Check(Amount>0),
ADate Date
);

create table Branch(
BName varchar(20) Constraint FK_Branch_Deposit Foreign key references Deposit(BName),
City varchar(20)
Constraint PK_Branch Primary key (City)
)

Create table Customer(
CName varchar(20) Constraint PK_Customer Primary key,
City varchar(20),
Constraint FK_Customer_Branch Foreign Key(City) references Branch(City)
)

Create table Borrow(
LoanNo varchar(5) not null,
CName varchar(20) Constraint FK_Borrow_Customer Foreign Key references Customer(CName),
BName varchar(20) Constraint FK_Borrow_Deposit Foreign key references Deposit(BName),
Amount numeric(8,2) not null Constraint CHK_Borrow_Amount check(Amount>0)
)