use PracticeDB
select * from College
select * from Persons
select * from Student


create table SelfJoinExample
(
	EmployeeId int identity(1,1),
	EmployeeName varchar(20),
	EmployeeRole varchar(20),
	ManagerId int
);
Insert into SelfJoinExample (EmployeeName,EmployeeRole,ManagerId)
values
('Usha Sundari','HOD ECE', 1),
('Shruti','Asst HOD ECE',2),
('Chandrakanth','Faculty',1),
('Bhaskar','Faculty',1),
('Shiva Shankar','Faculty',2),
('Raj Kumar','Faculty',2),
('Ashok','Faculty',7),
('Veeresh','Lab Incharge',3),
('Satish','Lab incharge',7)


select * From SelfJoinExample
select * From SelfJoinExample s1, SelfJoinExample s2
where s1.EmployeeId = s2.ManagerId

select * From SelfJoinExample s1
join SelfJoinExample s2 on s1.ManagerId = s2.EmployeeId