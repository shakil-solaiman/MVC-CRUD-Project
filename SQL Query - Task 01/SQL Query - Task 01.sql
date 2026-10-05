
create database ShopDB;

use ShopDB;


create table Customers
(
	Id int primary key identity(1,1),
	Name varchar (53) not null,
	City varchar (53),
	Age int
);

select * from Customers;


create table Products 
(
	Id int primary key identity(1,1),
	Name varchar (55) not null,
	Category varchar (55),
	Price decimal (10,2),
	Stock int
);

select * from Products;


create table Orders
(
	Id int primary key identity(1,1),
	CustomerId int,
	OrderDate date,
	TotalAmount decimal (10,2),

	foreign key (CustomerId) references Customers (Id)
);

select * from Orders;

create table OrderDetails
(
	Id int primary key identity (1,1),
	OrderId int,
	ProductId int,
	Quantity int,
	UnitPrice decimal (10,2),

	foreign key (OrderId) references Orders(Id),
	foreign key (ProductId) references Products(Id)
);

select * from OrderDetails;



insert into Customers (Name, City, Age) values
('Solaiman', 'Rajshahi', 24),
('Shakil', 'Dhaka', 30),
('Zaman', 'Chittagong', 34),
('Pranto', 'Dhaka', 28),
('Rahman', 'Rajshahi', 22),
('Hasan', 'Sylhet', 32);

select * from Customers;


insert into Products (Name, Category, Price, Stock) values
('Laptop', 'Electronics', 65000, 10),
('Mouse', 'Electronics', 800, 50),
('Apple', 'Fruits', 45, 250),
('Chair', 'Furniture', 4300, 20),
('Table', 'Furniture', 3500, 15),
('Notebook', 'Stationery', 80, 150);

insert into Products (Name, Category, Price, Stock) values
('Keyboard', 'Electronics', 800, 30),
('Headphones', 'Electronics', 800, 25),
('Banana', 'Fruits', 30, 400),
('Desk Lamp', 'Furniture', 1800, 40),
('Bookshelf', 'Furniture', 1800, 8),
('Pen Set', 'Stationery', 120, 300);

select * from Products;

insert into Orders (CustomerId, OrderDate, TotalAmount) values
(1, '2026-10-01', 81200),
(2, '2026-10-02', 12000),
(1, '2026-10-05', 2500),
(3, '2026-10-07', 7000),
(4, '2026-10-10', 80000);

select * from Orders;


insert into OrderDetails (OrderId, ProductId, Quantity, UnitPrice) values
(1, 1, 2, 1560),
(1, 2, 1, 1243),
(2, 4, 2, 549),
(2, 5, 4, 8600),
(3, 3, 2, 9865),
(4, 4, 5, 2453),
(5, 1, 1, 456);




-- Query Start from Here



select * from OrderDetails;

select OrderId, Quantity from OrderDetails;

select * from Customers
where City = 'Rajshahi';

select * from Customers
where City = 'Dhaka' and Age > 25;


select * from Products
order by price desc;


select * from customers
where City = 'Dhaka' and Age > 20
order by age asc;

-- Inner Join

select c.Name, o.OrderDate, o.TotalAmount 
from Customers as c
inner join
Orders as o
on c.Id = o.Id


-- Left Join 

select c.Name, c.City, o.TotalAmount, o.OrderDate
from Customers as c
left join 
Orders as o
on c.Id = o.Id
where c.City = 'Rajshahi'


-- Right Join

select o.CustomerID, o.TotalAmount, od.ProductID, od.UnitPrice
from Orders as o
right join
OrderDetails as od
on o.Id = od.OrderId;

-- Group By

select city, count(*) as TotalCustomers
from Customers 
group  by city;

select Category, count(*) as TotalCategory
from Products 
group by Category; 


-- Aggregate Functions 

select count(*) as TotalCustomers
from Customers

select sum(TotalAmount) as TotalSales
from Orders

select avg(TotalAmount) as AverageSales
from Orders

select avg(age) as AverageAge 
from Customers

select min(age) as MinimumAge
from Customers

select max(TotalAmount) as IndivisualMaximumSales
from Orders


select CustomerId, sum(TotalAmount) as TotalPurchase
from orders 
group by CustomerId
order by TotalPurchase desc;


-- Having 

select CustomerId, sum(TotalAmount) as TotalPurchase
from Orders 
group by CustomerId
having sum(TotalAmount) > 11000
order by TotalPurchase asc;


-- SubQuery 

select * from Products
where Price < 
(select avg(Price) from Products)


select * from products 
where Price = 
(select max(Price) from Products);


-- Store Procedure 

create procedure getAllCustomers
as
begin 
	select * from Customers
end;

exec GetAllCustomers;


create procedure getCustomersByCity
@City varchar (50)
as
begin
	select * from Customers where City = @City
end;

exec getCustomersByCity @City = 'Sylhet';
exec getCustomersByCity @City = 'Rajshahi';
exec getCustomersByCity @City = 'Dhaka';





-- CTE (Common Table Expression)

with CTE1 as 
( 
	select * from Orders where (TotalAmount > 5000)
) 
select * from CTE1

---------------

with CTE1 as 
( 
	select * from Orders where (TotalAmount > 5000)
),
CTE2 as
(
	select top 3 * from CTE1
)
select * from CTE2





-- Transaction 

begin transaction UpdateProductPrice
update Products
set Price = 350
where Id = 7

commit transaction
rollback transaction UpdateProductPrice

select * from products

---------------

begin try
	begin transaction;

	update products
	set stock = 101
	where id = 7;

	update products
	set price = 100
	where id = 7;

	commit transaction;
end try


begin catch
    rollback transaction;
end catch;


select * from products




-- Window Function

select * from products;

select * ,
row_number() over (partition by Products.Category order by Products.Price desc) as Rows_No
from Products

select * ,
rank() over (partition by Products.Category order by Products.Price desc) as Rows_No
from Products

select * ,
dense_rank() over (partition by Products.Category order by Products.Price desc) as Rows_No
from Products




-- Indexing 

create clustered index Index_Products on Products (Id) -- Not Possible 

create nonclustered index Index_Customers on Customers (City)


-- NOTE: I downloaded Microsofts official database "AdventureWorks2022" to test the benefits of indexing.


/*
When to Create Indexes:

1. The column has many different values (like unique phone numbers or email addresses).   
2. The column does not have many empty or NULL values.   
3. The column is often used in WHERE or JOIN conditions to search or connect tables.   

When NOT to Create Indexes:

1. The table is very small (searching the whole table is already fast).   
2. The column is rarely used to filter or search data.   
3. The column values change or update constantly (indexes slow down INSERT, UPDATE, and DELETE operations).   
*/

