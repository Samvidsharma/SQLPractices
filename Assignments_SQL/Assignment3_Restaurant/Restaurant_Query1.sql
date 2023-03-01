DROP Database ResturantManagementdb;

Create Database ResturantManagementdb;

Use ResturantManagementdb;


Drop table CustomerAddress;
Create Table CustomerAddress
(
	AddressId int Identity(1,1) Constraint PK_CustomerAddress Primary Key,
	HouseNumber varchar(20) NOT NULL,
	Landmark varchar(20) NOT NULL,
	Village varchar(20) NOT NULL,
	City varchar(20) NOT NULL,
	District varchar(20) NOT NULL,
	[State] varchar(20) NOT NULL,
	ZipCode varchar(6) NOT NULL Constraint CHK_CustomerAddress_ZipCode Check(ZipCode like '^\d{6}$'),
	CreatedDate DateTime2 NOT NULL,
	UpdatedDate DateTime2 NOT NULL
 );

Drop Table Customers;

Create Table Customers
(
	CostumerId int Identity(1,1) Constraint PK_Customers Primary Key,
	CostumerName varchar(50) NOT NULL,
	DateOfBirth Date, 
	PhoneNumber varchar(10) Constraint UQ_Customers_PhoneNumber Unique Constraint CHK_Costumers_PhoneNumber Check(len(PhoneNumber) = 10 and PhoneNumber like'^[789]\d{9}$'),
	EmailId		varchar(50) Constraint UQ_Costumers_EmailId Unique,
	CustomerAddressId int Constraint FK_Customers_CustomerAddress References CustomerAddress(AddressId),
    CreatedDate DateTime2 NOT NULL,
	UpdatedDate DateTime2 NOT NULL
);



 Drop table ItemInfo;
 Create table ItemInfo
 (
	InfoId int identity(1,1) Constraint PK_ItemInfo Primary Key,
	Calories float NOT NULL,
	CarbohydratesInGrams float NOT NULL,
	ExistedVitamins text,
	ExtraInformation text,
    CreatedDate DateTime2 NOT NULL,
	UpdatedDate DateTime2 NOT NULL
 )


Drop table ItemCategory;
Create table ItemCategory
(
	ItemCategoryId int identity(1,1) Constraint PK_ItemCategory Primary key,
	Category varchar(20) NOT NULL,
    CreatedDate DateTime2 NOT NULL,
	UpdatedDate DateTime2 NOT NULL
); 
Drop table Items;
Create Table Items
(
	ItemId int identity(1,1) Constraint PK_Items Primary Key,
	ItemName varchar(50) Constraint UQ_Items_ItemName Unique NOT NULL,
	[Description] text NOT NULL,
	ItemInfoId int Constraint FK_Items_ItemInfoId Foreign Key REFERENCES ItemInfo(InfoId),
	ItemCategoryId int Constraint FK_Item_ItemCategory Foreign key REFERENCES ItemCategory(ItemCategoryId),
	ItemType bit NOT NULL Constraint DF_Items_ItemType Default(0), -- 0 means veg, 1 means non veg 
	Price Money NOT NULL,
	PriceDescription varchar(20),
    CreatedDate DateTime2 NOT NULL,
	UpdatedDate DateTime2 NOT NULL
);


Drop table DeliveryPerson;

Create table DeliveryPerson
(
	DeliveryPersonId int identity(1,1) Constraint PK_DeliveryPerson Primary Key,
	DeliveryPersonName varchar(20) NOT NULL,
	PhoneNumber varchar(10) Constraint UQ_DeliveryPerson_PhoneNumber Unique Constraint CHK_DeliveryPerson_PhoneNumber Check(len(PhoneNumber) = 10 and PhoneNumber like'^[789]\d{9}$'),
	VehicleNumber varchar(10) Constraint UQ_DeliveryPerson_VehicleNumber Unique NOT NULL,
    CreatedDate DateTime2 NOT NULL,
	UpdatedDate DateTime2 NOT NULL
);

Drop Table Restaurant;
Create Table Restaurant
(
	RestaurantId int identity(1,1) Constraint PK_Restaurant Primary Key,
	RestaurantName varchar(50) NOT NULL,
	[Address] varchar (50) NOT NULL,
	ZipCode varchar(6) NOT NULL Constraint CHK_Restaurant_ZipCode Check(ZipCode like '^\d{6}$'),
    CreatedDate DateTime2 NOT NULL,
	UpdatedDate DateTime2 NOT NULL
);

Drop table RestaurantStaff;
Create table RestaurantStaff
(
	EmployeeId int identity(1,1) Constraint PK_RestaurantStaff Primary Key,
	RestaurantId int Constraint FK_RestaurantStaff_Restaurant Foreign key References Restaurant(RestaurantId),
	EmployeeName varchar(20) NOT NULL,
	EmployeeDesignation varchar(25) NOT NULL,
	PhoneNumber varchar(10) Constraint UQ_RestaurantStaff_PhoneNumber Unique Constraint RestaurantStaff_PhoneNumber Check(len(PhoneNumber) = 10 and PhoneNumber like'^[789]\d{9}$'),
    CreatedDate DateTime2 NOT NULL,
	UpdatedDate DateTime2 NOT NULL
)

Drop table OrderType;
Create table OrderType 
(
	id int identity(1,1) Constraint PK_OrderType Primary key,
	OrderType varchar(25) NOT NULL, -- Walkin or take away or online,
    CreatedDate DateTime2 NOT NULL,
	UpdatedDate DateTime2 NOT NULL
);

Drop Table [Tables];
Create Table [Tables] 
(
	TableId int identity(1,1) Constraint PK_Tables Primary key,
	NumberOfChairs int NOT NULL,
	RoomType bit Not NULL Constraint DF_RoomType_Room Default(0), -- 0 for non-ac, 1 for ac.
	LobbyNumber int NOT NULL Constraint UQ_Tables_LobbyNumber Unique,
    CreatedDate DateTime2 NOT NULL,
	UpdatedDate DateTime2 NOT NULL
);

Drop Table Reservations;
Create Table Reservations
(
	ReservationId int identity(1,1) Constraint PK_Reservations Primary Key,
	CustomerId int Constraint FK_Reservations_Customers Foreign Key REFERENCES Customers(CostumerId),
	RestaurantId int Constraint FK_Reservations_Restaurant Foreign Key REFERENCES Restaurant(RestaurantId),
	TableId int Constraint FK_Reservations_Tables Foreign Key REFERENCES [Tables](TableId),
	[Number of People] int NOT NULL Constraint DF_Reservation_NUMBER_OF_PEOPLE Default(1) ,
	CreatedByEmployeeId int Constraint FK_Reservations_RestaurantStaff Foreign Key REFERENCES RestaurantStaff(EmployeeId),
	UpdatedByEmployeeId int Constraint FK_Reservations_RestaurantStaff Foreign Key REFERENCES RestaurantStaff(EmployeeId) ,
	CreatedDate DateTime2 NOT NULL,
	UpdatedDate DateTime2
);


Drop table Orders;
Create table Orders
(
	OrderId int identity(1,1) Constraint PK_Orders Primary Key,
	CustomerId int Constraint FK_Orders_Customers Foreign Key REFERENCES Customers(CostumerId),
	OrderTypeId int Constraint FK_Orders_OrderType Foreign key REFERENCES OrderType(id),
	WebAppOrAppName varchar(30),
	ReservationId int Constraint FK_Orders_Reservations References Reservations(ReservationId),
    CreatedDate DateTime2 NOT NULL,
	UpdatedDate DateTime2 NOT NULL
);

Drop table OrderedItems;
Create Table OrderedItems
(
	OrderedItemsId int identity(1,1) Constraint PK_OrderedItems Primary Key,
	ItemId int Constraint FK_Orders_Items Foreign Key REFERENCES Items(ItemId), -- To show which item is ordered.
	OrderId int Constraint FK_OrderedItems_Orders Foreign Key REFERENCES Orders(OrderId),
	Quantity int NOT NULL Constraint DF_Orders_Quantity Default(1),
	TotalPrice money NOT NULL,
	DeliveryPersonId int Constraint FK_Orders_DeliveryPerson REFERENCES DeliveryPerson(DeliveryPersonId),
	OrderedTime DateTime2 NOT NULL Constraint DF_Orders_OrderedTime Default(GetDate()),
	--DeliveredTime DateTime2 NOT NULL Constraint DF_Orders_OrderedTime Default(select GetDate(),'Now',DateAdd(hour,1,GetDate()))
	DeliveredTime DateTime2 NOT NULL Constraint DF_Orders_DeliveredTime Default(DateAdd(hour,1,GetDate())),
    CreatedDate DateTime2 NOT NULL,
	UpdatedDate DateTime2 NOT NULL
);


