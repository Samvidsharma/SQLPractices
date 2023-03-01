CREATE DATABASE StoredProcedures;
Use StoredProcedures;

CREATE TABLE Cars
(
	CarId INT identity(1,1) CONSTRAINT PK_Cars_CarId PRIMARY KEY,
	[Year] SMALLINT NOT NULL,
	Make varchar(30) NOT NULL,
	Model varchar(25) NOT NULL,
	IsActive bit CONSTRAINT DF_Cars_IsActive DEFAULT(1)
);

INSERT INTO Cars ([Year],Make,Model) Values
(2020,'Honda','Accord Hybrid'),
(2020,'Honda','Accord Sedan'),
(2020,'Honda','Civic Coupe'),
(2020,'Honda','Civic HatchBack'),
(2020,'Honda','Civic Sedan'),
(2020,'Honda','Civic si Coupe'),
(2020,'Honda','Civic si Sedan'),
(2020,'Honda','Civic Type R'),
(2020,'Honda','CR-V'),
(2020,'Honda','CR-V Hybrid'),
(2020,'Honda','Fit'),
(2020,'Honda','HR-V'),
(2020,'Honda','Insight'),
(2020,'Honda','Odyssey'),
(2020,'Honda','Passport'),
(2020,'Honda','Pilot'),
(2020,'Honda','RidgeLine'),
(2020,'Honda','CR V'),
--
(2021,'Honda','Accord Hybrid'),
(2021,'Honda','Accord Sedan'),
(2021,'Honda','Civic HatchBack'),
(2021,'Honda','Civic Sedan'),
(2021,'Honda','CR-V'),
(2021,'Honda','HR-V'),
(2021,'Honda','Insight'),
(2021,'Honda','Odyssey'),
(2021,'Honda','Passport'),
(2021,'Honda','Pilot'),
(2021,'Honda','RidgeLine'),
--
(2022,'Honda','Accord Hybrid'),
(2022,'Honda','Accord Sedan'),
(2022,'Honda','Civic HatchBack'),
(2022,'Honda','Civic Sedan'),
(2022,'Honda','CR-V'),
(2022,'Honda','HR-V'),
(2022,'Honda','Insight'),
(2022,'Honda','Odyssey'),
(2022,'Honda','Passport'),
(2022,'Honda','Pilot'),
(2022,'Honda','RidgeLine'),
(2022,'Honda','HR-V'),
(2022,'Honda','Odyssey'),
(2022,'Honda','RidgeLine');

SELECT * FROM CARS;

GO;

create view TempCars as 
(
	select c.CarId,c.Model,cast(c.Year as varchar(4))+':'+c.Model as yearsModels from Cars c
)
select * from TempCars;

GO;
Create PROCEDURE DeleteData(@ExcludeYears varchar(50)='', @ExcludeYearModels varchar(50)='')
As
BEGIN

	WITH 
	YearsData As
		(SELECT VALUE FROM string_split(@ExcludeYears,','))

	Update c1 
	set c1.IsActive = 0
	From Cars c1
	Inner join
	YearsData c2 
	on 
	c2.value  = c1.Year;

	With
	YearsModelsData(value) as
		(
			SELECT VALUE FROM string_split(@ExcludeYearModels,';')
		)

    Update c1 
	set c1.IsActive = 0
	FROM Cars c1 
			inner join TempCars t2 on t2.CarId = c1.CarId
		    Inner Join YearsModelsData t1 on 
			(t1.value = t2.yearsModels OR t1.value = t2.Model)
	Select c.CarId,c.Year,c.Make,c.Model,c.IsActive from Cars c where IsActive=1

	Update Cars 
	set IsActive = 1
END;

EXEC DeleteData;
EXEC DeleteData '2020','2021:CR-V';
EXEC DeleteData '2020','2021:CR-V;HR-V';
EXEC DeleteData '2020';
EXEC DeleteData '2020,2021'

Begin
Declare @EcludeYears varchar(30) = '2021:HR-V;2022:Pilot;Odyssey,';
with temp(value)
as(
	SELECT VALUE FROM string_split(@EcludeYears,';'))
	select * from temp t1
	inner join TempCars t2
	on t1.value = t2.yearsModels
ENd

update cars 
set IsActive = 1;

select * from TempCars;
select * from cars

Begin
Declare @ExcludeYears2 varchar(30) = '2021:HR-V;2022:Pilot;Odyssey';
with YearsModelsData(value) as
		(
			SELECT VALUE FROM string_split(@ExcludeYears2,';')
		),
		
		UpdateData as(
		select * from YearsModelsData t1
		inner join TempCars t2
		on 
		t1.value = t2.yearsModels
		OR 
		t1.value = t2.Model
		)
 update Cars 
set IsActive = 0
 where CarId in(select u.carId from UpdateData u);
--where yearsModels in
--select u.carId from UpdateData u;
End

with som1 as
(
	select * from Cars
)
select * from som1

--with some2 as
--(select * from som1)