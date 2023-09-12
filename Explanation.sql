Truncate table dbo.cart

/* Customer Places an Order
Customer Number: 100
has ordered Item No:4 (2 Nos)
                    13 (2 Nos)  
*/

Insert into dbo.cart values (100,4,2);
Insert into dbo.cart values (100,13,2);

Select * from dbo.cart


/*------------------------------------------------------------------------------------*/
/* We Start the Process */

Exec calculation_SP

/* We get an error,order is not placed */

select * from dbo."order"

truncate table dbo.cart

/*-----------------------------------------------------------------------------------*/

/* Customer Places an Order
Customer Number: 100
has ordered Item No:4 (2 Nos)
                    13 (1 No)  
*/


Insert into dbo.cart values (100,4,2);
Insert into dbo.cart values (100,13,1);

Select * from dbo.cart

/*We Start the process */

Exec calculation_SP

/* Order are entered in the database table as well
Tax are calculated as per state from where the order is placed*/

select * from dbo."order"
select * from dbo.order_details
select * from dbo.delivery_Status

/*----------------------------------------------------------------*/

/*when the product is delivered, Delivery Flag should be on and Date delivered should be recorded*/

update dbo.delivery_status
set Delivery_Flag=1 , Date_delivered= '2023-09-15'
where Order_Id=1

select * from dbo.delivery_status

/*-------------------------------------------------------------------------*/

/* Customer wants to return the product after 30 days period
Item 4: 1 Nos
Item 13: 1 Nos
*/

truncate table dbo."return"

insert into dbo."return" Values (100,1,1,'2023-10-26');
insert into dbo."return" Values (100,2,1,'2023-10-26');


/*-------------------------------------------------------------------------------------*/


/*We start the process*/

Exec Return_SP

/*Can not return the product as 30 days have passed after Delivery Date not the Order Date*/

/* return request is not updated in the database table*/
select * from return_request

/*---------------------------------------------------------------------------------------------*/


select * from dbo.item where Item_Id in (4,13)

/*Meanwhile the Product cost has been incresed */

update dbo.Item
set Price= 50
where Item_Id=4;

update dbo.Item
set Price= 60
where Item_Id=13;

select * from dbo.item where Item_Id in (4,13)

/*-----------------------------------------------------------------------------------------------------*/


/* Customer tries to place the return Request within 30 days*/


truncate table dbo."return"

insert into dbo."return" Values (100,1,1,'2023-10-06');
insert into dbo."return" Values (100,2,1,'2023-10-06');

/* We Start the Process*/

Exec Return_SP

/*Return Request is not updated the datbase table*/

select * from return_request



/*-----------------------------------------------------------------------------------------*/


/* Now Customer 102 places some order*/

Truncate table dbo.cart

Insert into dbo.cart values (102,6,1);
Insert into dbo.cart values (102,10,1);
Insert into dbo.cart values (102,14,1);



/* we process */

Exec calculation_SP



/*Check Database Tables*/

select * from dbo."order"
select * from dbo.order_details
select * from dbo.delivery_Status



/* Update the Delivery Status*/

update dbo.delivery_status
set Delivery_Flag=1 , Date_delivered= '2023-09-15'
where Order_Id=2

select * from dbo.delivery_Status


/* Customer Places Return Request*/
truncate table dbo."return"

insert into dbo."return" Values (102,3,1,'2023-09-16');



/* we Process Return Request*/
Exec Return_SP



/* we check the database table*/

Select * from dbo."return" 




