/* Drop Tables: */

drop table dbo.address;
drop table dbo.options;
drop table dbo.delivery_status;
drop table dbo.return_request;
drop table dbo.Region_Tax;
drop table dbo.order_details;
drop table dbo."order";
drop table dbo.item;
drop table dbo.variation_details;
drop table dbo.variation;
drop table dbo.payment_method;
drop table dbo.product;
drop table dbo.category;
drop table dbo.users;



/*----------------------------------------------------------------------------------------*/




/* Craete Tables */

create table dbo.users (
ID int IDENTITY(100,2),
First_Name varchar(255),
Last_Name varchar(255),
Email varchar(255),
Password varchar(255),
Location varchar(255),
Contact_Number char(10),
Primary Key (ID)
);


create table dbo.region_tax (
Region varchar(2),
Tax decimal(4,2),
primary key (Region)
)

create table dbo.address (
Address_ID int IDENTITY(1,1),
User_Id int,
Unit_number varchar(255),
Address_Line_1 varchar(255),
Address_Line_2 varchar(255),
City varchar(55),
Region varchar(2),
Postal_Code char(6),
Country_Id varchar(55),
primary key (Address_ID),
Foreign Key (User_Id) references users(Id),
Foreign Key (Region) references Region_Tax(Region)
)

create table dbo.payment_method (
Payment_Method_Id int identity(1,1),
User_Id int,
Provider varchar(55),
Card_Number char(16),
Expiry_Date char(5),
primary key (Payment_Method_Id),
check (Provider in ('VISA','MASTERCARD')),
Foreign Key (User_Id) references users(ID)
)


create table dbo."order" (
Order_Id int Identity(1,1),
User_Id int,
Payment_Method_Id int,
Order_Date date,
Order_Amount decimal(14,2),
primary key (Order_Id),
Foreign Key (Payment_Method_Id) references payment_method(Payment_Method_Id)
)


create table dbo.category (
Category_Id int identity(1,1),
Parent_Category_Id int,
Description varchar(255),
primary key (Category_Id),
CONSTRAINT FK_Category FOREIGN KEY (Parent_Category_Id) REFERENCES category(Category_Id)
)

create table dbo.product (
Product_Id int identity(1,1),
Category_Id int,
Name varchar(255),
Description varchar(255),
primary key (Product_Id),
foreign Key (Category_Id) references category(Category_Id)
)

create table dbo.item (
Item_Id int identity(1,1),
Product_Id int,
SKU char(5),
Stock int,
Price Decimal(14,2)
Primary Key (Item_Id),
Foreign Key (Product_Id) references product(Product_Id)
)


create table dbo.variation(
Variation_Id int identity(1,1),
Category_Id int,
Attribute varchar(255),
Primary Key (Variation_Id),
Foreign Key (Category_Id) references category(Category_Id)
)


create table dbo.variation_details(
Variation_Details_Id int identity(1,1),
Variation_Id int,
Details varchar(255),
primary key (Variation_Details_Id),
Foreign Key (Variation_Id) references variation(Variation_Id)
)

create table dbo.options(
Item_Id int,
Variation_Id int,
Foreign Key (Item_Id) references item(Item_Id),
Foreign Key (Variation_Id) references variation_details(Variation_Details_Id),
)


create table dbo.order_details(
Order_Details_Id int identity(1,1),
Order_Id int,
Item_Id int,
Unit int,
Unit_Price decimal(14,2)
primary key (Order_Details_Id),
foreign key (Order_Id) references "order"(Order_Id),
foreign key (Item_Id) references item(Item_Id)
)


create table dbo.delivery_status(
Order_Id int,
Delivery_Flag bit,
Date_Delivered date
primary key (Order_Id),
foreign key (Order_Id) references "order"(Order_Id)
)



create table dbo.return_request(
Return_Request_Id int identity(1,1),
Order_details_Id int,
Unit int,
Return_Date date,
primary key (Return_Request_Id),
foreign key (Order_Details_Id) references order_details(Order_Details_Id)
)



/*--------------------------------------------------------------------------------------------------*/


/* Inserting Values */


/*Inserting Data Into Users table*/

insert into [dbo].[users] values ('Koustav','Roy','koustav.roy@gmail.com','qwerty123','US','5717236526')
insert into [dbo].[users] values ('Brian','Ross','Brian.Ross@gmail.com','asdfg123','US','7654876250')

Select * from dbo.users

/*Inserting Data into region_tax table*/

insert into [dbo].[region_tax] values ('VA',6);
insert into [dbo].[region_tax] values ('CA',11);
insert into [dbo].[region_tax] values ('FL',5);
insert into [dbo].[region_tax] values ('DE',0);

Select * from dbo.region_tax;


/*Inserting Data into address table*/

insert into [dbo].[address] values (100,'10427','Courthouse Dr','','Fairfax','VA','22030','US');
insert into [dbo].[address] values (102,'3255','Mayers Ln','','Tampa','FL','33592','US');

select * from dbo.address


/*Inserting Data into payment_method table*/

insert into [dbo].[payment_method] values ('100','VISA','1234567812345670','02/25');
insert into [dbo].[payment_method] values ('102','MASTERCARD','6536768518453098','07/27');

select * from dbo.payment_method


/*Inserting Data into category table*/

insert into [dbo].[category] values(1,'Lingerie');
insert into [dbo].[category] values(1,'Teddies');
insert into [dbo].[category] values(3,'Sports');
insert into [dbo].[category] values(3,'Leggings');

select * from dbo.category

/*Inserting Data into Products*/

insert into [dbo].[product] values (2,'Fishnet Floral','Bombshell Fitness Floral Teddy');
insert into [dbo].[product] values (2,'Adore Me','Juliana Teddy');
insert into [dbo].[product] values (4,'Essential Pocket Leggings','');
insert into [dbo].[product] values (4,'Essential Fine Line Leggings','');

select * from dbo.product

/*Inserting Data into Item*/

insert into dbo.item values (1,'15392',20,30);
insert into dbo.item values (1,'57163',34,30);
insert into dbo.item values (1,'81158',43,30);
insert into dbo.item values (1,'47423',23,35);
insert into dbo.item values (1,'43332',22,35);
insert into dbo.item values (2,'71814',20,35);
insert into dbo.item values (2,'62759',33,35);
insert into dbo.item values (2,'67978',27,35);
insert into dbo.item values (3,'86870',40,26);
insert into dbo.item values (3,'16546',28,26);
insert into dbo.item values (3,'70035',35,26);
insert into dbo.item values (4,'92026',43,44);
insert into dbo.item values (4,'68273',45,44);
insert into dbo.item values (4,'12707',45,44);


select * from dbo.item

/*Inserting Data into variation*/

insert into dbo.variation values (1,'Color');
insert into dbo.variation values (1,'Size');
insert into dbo.variation values (2,'Color');
insert into dbo.variation values (2,'Size');
insert into dbo.variation values (3,'Color');
insert into dbo.variation values (3,'Piping');
insert into dbo.variation values (3,'Size');
insert into dbo.variation values (3,'Length');
insert into dbo.variation values (4,'Color');
insert into dbo.variation values (4,'Piping');
insert into dbo.variation values (4,'Size');
insert into dbo.variation values (4,'Length');

select * from dbo.variation

/*Inserting Data into variation_details*/

insert into dbo.variation_details values (1,'Green');
insert into dbo.variation_details values (1,'Blue');
insert into dbo.variation_details values (1,'Green');
insert into dbo.variation_details values (1,'Black');
insert into dbo.variation_details values (2,'XS');
insert into dbo.variation_details values (2,'S');
insert into dbo.variation_details values (2,'M');
insert into dbo.variation_details values (2,'L');
insert into dbo.variation_details values (2,'XL');
insert into dbo.variation_details values (3,'Green');
insert into dbo.variation_details values (3,'Blue');
insert into dbo.variation_details values (3,'Green');
insert into dbo.variation_details values (3,'Black');
insert into dbo.variation_details values (4,'XS');
insert into dbo.variation_details values (4,'S');
insert into dbo.variation_details values (4,'M');
insert into dbo.variation_details values (4,'L');
insert into dbo.variation_details values (4,'XL');
insert into dbo.variation_details values (5,'Green');
insert into dbo.variation_details values (5,'Blue');
insert into dbo.variation_details values (5,'Green');
insert into dbo.variation_details values (5,'Black');
insert into dbo.variation_details values (6,'Piping');
insert into dbo.variation_details values (6,'No Piping');
insert into dbo.variation_details values (7,'XS');
insert into dbo.variation_details values (7,'S');
insert into dbo.variation_details values (7,'M');
insert into dbo.variation_details values (7,'L');
insert into dbo.variation_details values (7,'XL');
insert into dbo.variation_details values (8,'Short');
insert into dbo.variation_details values (8,'Regular');
insert into dbo.variation_details values (8,'Long');
insert into dbo.variation_details values (9,'Green');
insert into dbo.variation_details values (9,'Blue');
insert into dbo.variation_details values (9,'Green');
insert into dbo.variation_details values (9,'Black');
insert into dbo.variation_details values (10,'Piping');
insert into dbo.variation_details values (10,'No Piping');
insert into dbo.variation_details values (11,'XS');
insert into dbo.variation_details values (11,'S');
insert into dbo.variation_details values (11,'M');
insert into dbo.variation_details values (11,'L');
insert into dbo.variation_details values (11,'XL');
insert into dbo.variation_details values (12,'Short');
insert into dbo.variation_details values (12,'Regular');
insert into dbo.variation_details values (12,'Long');


select * from dbo.variation_details



/*Inserting Data into Options*/

insert into dbo.options values (1,10);
insert into dbo.options values (1,14);
insert into dbo.options values (2,10);
insert into dbo.options values (2,15);
insert into dbo.options values (3,10);
insert into dbo.options values (3,16);
insert into dbo.options values (4,10);
insert into dbo.options values (4,17);
insert into dbo.options values (5,10);
insert into dbo.options values (5,18);
insert into dbo.options values (6,11);
insert into dbo.options values (6,14);
insert into dbo.options values (7,11);
insert into dbo.options values (7,15);
insert into dbo.options values (8,11);
insert into dbo.options values (8,16);
insert into dbo.options values (9,33);
insert into dbo.options values (9,37);
insert into dbo.options values (9,40);
insert into dbo.options values (9,44);
insert into dbo.options values (10,33);
insert into dbo.options values (10,37);
insert into dbo.options values (10,40);
insert into dbo.options values (10,44);
insert into dbo.options values (11,34);
insert into dbo.options values (11,38);
insert into dbo.options values (11,41);
insert into dbo.options values (11,45);

select * from dbo.options


/*---------------------------------------------------------------------------------------------------*/


/* Creation Of Cart */

create table dbo.cart (
Customer_Id int,
Item_Id int,
Quantity int)


/*-----------------------------------------------------------------------------------------------------*/


/* Creation of View for Order Calculation*/

create view dbo.calculation as 

with Price_CTE as
( select A.*,B.Stock,B.Price from dbo.cart A left outer join dbo.item B on A.Item_Id = B.Item_Id),

Address_CTE as
( Select C.*,
D.Unit_number,
D.Address_Line_1,
D.Address_Line_2,
D.City,
D.Region,
D.Postal_Code,
D.Country_Id
from Price_CTE C left outer join dbo.address D on C.Customer_id = D.User_Id),

Tax_CTE as
(
select E.*,F.Tax from Address_CTE E left outer join dbo.region_tax F on E.Region = F.Region
),

Payment_CTE as(
select G.*,
H.Payment_Method_Id,
H.Provider,
H.Card_Number,
H.Expiry_Date
from Tax_CTE G left outer join dbo.payment_method H on G.Customer_Id = H.User_Id),

Product_CTE_1 as(
select I.*,J.Product_Id from Payment_CTE I left outer join dbo.item J on I.Item_Id = J.Item_Id),

Product_CTE_2 as(
select K.*,L.Name from Product_CTE_1 K left outer join dbo.product L on K.Product_Id = L.Product_Id
),

Name_CTE as(
select M.*,N.First_Name,
N.Last_Name,
N.Contact_Number
from Product_CTE_2 M left outer join dbo.users N on M.Customer_Id = N.Id)


Select *,
Cast(Round(((Price*Quantity)*(Tax/100)),2) as Numeric(36,2)) as Tax_Value,
Cast(Round(((Price*Quantity)*(1+(Tax/100))),2) as Numeric(36,2)) As Total_Cost,
Stock-Quantity as New_Stock
from Name_CTE;


/*------------------------------------------------------------------------------------------------------------*/


/* Creation of Stored Procedure for Order Calculation*/

Create procedure dbo.calculation_SP

As

begin

declare @x int;

select @x= sum(Quantity) from dbo.calculation;


if @x >3

begin

print 'You can not order more than 3 items for Try At Home' ;

end

else

begin


insert into dbo."order" 
select distinct Customer_Id, Payment_Method_Id, GETDATE(), 
sum(Total_Cost) over (partition by Customer_Id)
from dbo.calculation


insert into dbo.order_details
Select a.*,b.* from 
(select max(Order_Id) as ID from dbo."order") a
cross join
( select Item_Id, Quantity,cast(round(Total_Cost/Quantity,2) as Numeric(36,2)) as Unit_Cost from dbo.calculation) b 

insert into dbo.delivery_status
select max(Order_Id),0 as status,Null as del_date from dbo."order"



select distinct First_Name,Last_Name,Contact_Number,
Unit_Number , Address_Line_1, Address_Line_2, City, Region, Postal_Code, Country_Id as Country
from dbo.calculation;

select Name, Quantity, Price, Tax as State_Tax_Perc, Tax_Value as Tax, 
Total_Cost as Price_With_Tax from dbo.calculation;

select distinct sum(Total_Cost) over (partition by Customer_Id) as Charge_To_Be_Processed, Provider,
Card_Number, Expiry_date
from dbo.calculation;

end

end

Go


/*----------------------------------------------------------------------------------------------------*/


/* Creating Table for Return*/

create table dbo."return" (
Customer_Id int,
Order_Details_Id int,
Quantity int,
return_date date)



/*--------------------------------------------------------------------------------------------------*/


/*Creating View for Return Calculation*/

create view dbo.return_calculation as

with Retreive_CTE as(
Select a.*,b.Order_Id,b.Item_Id,b.Unit, b.Unit_Price from dbo."return" a left outer join dbo.order_details b
on a.Order_Details_Id = b.Order_Details_Id
),

Deliver_CTE as(
select c.*, d.Date_delivered from Retreive_CTE c left outer join dbo.Delivery_Status d
on c.Order_Id = d.Order_Id
),

Payment_Method_CTE as(
Select e.*, f.Provider,f.Card_Number,f.Expiry_Date from Deliver_CTE e left outer join dbo.Payment_Method f on e.Customer_Id = f.User_Id
),

Product_CTE_1 as(
select I.*,J.Product_Id from Payment_Method_CTE I left outer join dbo.item J on I.Item_Id = J.Item_Id),

Product_CTE_2 as(
select K.*,L.Name from Product_CTE_1 K left outer join dbo.product L on K.Product_Id = L.Product_Id
)

select *,DATEDIFF(day,Date_delivered,return_date) as Date_Difference,
Unit_price*Quantity as Return_Amount from Product_CTE_2 ;

/*------------------------------------------------------------------------------------------*/


/* Creating Stored Procedure for return Calculation */

Create procedure dbo.Return_SP

As

begin

declare @x int;

select @x= max(Date_Difference) from dbo.return_calculation;


if @x >30

begin

print 'You have exceded the 30 day Return Period' ;

end

else

begin

insert into dbo.return_request
Select Order_Details_Id, Quantity, return_date from dbo.return_calculation;

select Name,Unit_Price as Price, Quantity as Return_Quantity,Return_Amount
from dbo.return_calculation;

Select Distinct sum(Return_Amount) over (partition by Customer_Id) as Amount_To_Be_Refunded,
Provider,Card_Number,Expiry_Date from dbo.return_calculation;

end

end

Go


/*-------------------------------------------------------------------------------------------------------*/

