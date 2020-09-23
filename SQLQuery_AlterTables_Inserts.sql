--CREATE TABLE Customer(
--	[customerId] [int] IDENTITY(1,1) NOT NULL,
--	[name] [nvarchar](100) NOT NULL,
--	[birthday] [datetime] NULL,
--	[favoriteBarber] [nvarchar](100) NULL,
--	[notes] [varchar](2000) NULL
--) 

--Create Table Appointment (
--	appointmentId int Identity(1,1) not null,
--	customerId int not null,
--	[date] datetime not null,
--	[length] int not null,
--	barber nvarchar(100) null,
--	haircutId int null,
--)

--ALTER TABLE dbo.Customer ADD CONSTRAINT
--	PK_Customer PRIMARY KEY CLUSTERED 
--	(customerId) 

--	ALTER TABLE dbo.Appointment ADD CONSTRAINT
--	PK_Appointment PRIMARY KEY CLUSTERED 
--	(appointmentId)
	
	--Alter Table Appointment
	--Add Foreign Key (customerId) References Customer(customerId)

	insert into Customer([name],birthday,favoriteBarber,notes)
	values('Nathan', '5/27/1986', 'Geoff', 'needs a haircut!')

	select *
	from Customer


--Anca: sample script for creating a table and foreign key relationships / equivalent for using the UI to create the Payment table: 
--CREATE TABLE Payment (
--	paymentId int identity(1,1) Primary Key not null,
--	paymentType varchar(20) null,
--	appointmentId int not null,
--	discount int not null,
--	payer varchar(200) not null,
--	FOREIGN KEY(appointmentId) REFERENCES Appointment(appointmentId)
--);

insert Appointment(customerId,date,length,barber)
values(1, '2020-09-20', 60, 'barber3')


--ADD PAYMENTS - using variables:
declare @customerName varchar(15) = 'Aaron'
declare @appointmentId int 
declare @paymentType varchar(20) = 'Visa'
declare @discount int = 10
declare @payer varchar(200) = 'Nathan G'

--to change the value of a variabel later, use the keyword set / you can also set it equal to the result of a sql query:
set @appointmentId = (
	select a.appointmentId
	from Appointment a
		join Customer c
			on a.customerId = c.customerId
	--just to test it out - use a specific name: where c.name = 'Nathan' --@customerName
	where c.name = @customerName -- you want to make sure you get only one value when you do this query
	--order by a.Date desc
	)

print @appointmentId

select * 
from Appointment

insert into Payment(appointmentId,discount,paymentType,payer)
values(@appointmentId,@discount,@paymentType,@payer)

delete
from Appointment
where appointmentId = 3

select *
from Payment

update Appointment
set date = '9/30/2020',
	barber = 'Stanley'
where appointmentId = 4

-- you can also join tables inside the update (or delete - although not recommended) statement
--update all of Nathan's appointments to be with the customer's new favorite barber:
update Appointment
set barber = 'Stanley'
from Appointment a
	join Customer c
		on c.customerId = a.customerId
where c.name = 'Nathan'


--ANCA: To copy from Nathan:
--set favorite barber:
update Customer
set favoriteBarber = 'Stanley'
where name = 'Nathan'

--then change a specific appointment
update Appointment
set date = '9/30/2020'.
	barber = 'Stanley'
where appointmentId = 2

--then change all my appointments with the value from the favoriteBarber / a column from another table:
--XXXX!!
update a
set barber = c.favoriteBarber
from Appointment a
	join Customer c
		on c.customerId = a.customerId
where c.name = 'Nathan'

--TO add a new column to a table:
Alter Table Customer
Add FavoriteColor varchar(100) null