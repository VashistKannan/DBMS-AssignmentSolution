create database  if not exists travelonthego;
use travelonthego;

/*1) You are required to create two tables PASSENGER and PRICE with the following
attributes and properties*/

create table if not exists `passenger`(
`Passenger_name` varchar(50),
`Category` varchar(20),
`Gender` varchar(10),
`Boarding_City` varchar(20),
`Destination_City` varchar(20),
`Distance` int not null,
`Bus_Type` varchar(10)
) ;

create table if not exists `price`(
`Bus_type` varchar(10),
`Distance` int not null,
`Price` int not null
);

/*2) Insert the following data in the tables*/

insert into `passenger` values("Sejal","AC","F","Bengaluru","Chennai",350 ,"Sleeper" );
insert into `passenger` values("Anmol","Non-AC","M","Mumbai","Hyderabad",700 ,"Sitting" );
insert into `passenger` values("Pallavi","AC","F","Panaji","Benagaluru", 600,"Sleeper" );
insert into `passenger` values("Kushboo","AC","F","Chennai","Mumbai", 1500,"Sleeper" );
insert into `passenger` values("Udit","Non-AC","M","Trivandrum","Panaji", 1000,"Sleeper" );
insert into `passenger` values("Ankur","AC","M","Nagpur","Hyderabad", 500,"Sitting" );
insert into `passenger` values("Hemant","Non-AC","M","Panaji","Mumbai", 700,"Sleeper" );
insert into `passenger` values("Manish","Non-AC","M","Hyderabad","Bengaluru", 500,"Sitting" );
insert into `passenger` values("Piyush","AC","M","Pune","Nagpur", 700,"Sitting" );


insert into `price` values("Sleeper",350,770);
insert into `price` values("Sleeper",500,1100);
insert into `price` values("Sleeper",600,1320);
insert into `price` values("Sleeper",700,1540);
insert into `price` values("Sleeper",1000,2200);
insert into `price` values("Sleeper",1200,2640);
insert into `price` values("Sleeper",1500,2700);
insert into `price` values("Sitting",500,620);
insert into `price` values("Sitting",600,744);
insert into `price` values("Sitting",700,868);
insert into `price` values("Sitting",1000,1240);
insert into `price` values("Sitting",1200,1488);
insert into `price` values("Sitting",1500,1860);

/*3) How many females and how many male passengers travelled for a minimum distance of
600 KM s?*/
select Gender, count(gender) as Count from travelonthego.passenger 
where distance>=600 /*i assume the question asks for passengers travelled atleast 600kms, in case if it meant exactly 600 kms then remove '>'*/
group by gender 
order by gender;

/*4) Find the minimum ticket price for Sleeper Bus.*/
select min(price) as Minimum_ticket_price_Sleeper from travelonthego.price
where bus_type='Sleeper'; 

/*5) Select passenger names whose names start with character 'S'*/
select passenger_name from travelonthego.passenger
where Passenger_name like 'S%';

/*6) Calculate price charged for each passenger displaying Passenger name, Boarding City,
Destination City, Bus_Type, Price in the output*/

select passenger.Passenger_name, passenger.Boarding_City, passenger.Destination_City, passenger.Bus_type, price.Price from travelonthego.passenger,travelonthego.price
where passenger.bus_type = price.bus_type and
passenger.distance = price.distance;

/*7) What are the passenger name/s and his/her ticket price who travelled in the Sitting bus
for a distance of 1000 KM s*/

select passenger.Passenger_name, price.Price as Ticket_Price from travelonthego.passenger,travelonthego.price
where passenger.distance=1000 and /*for passengers covering within/below 1000 kms add '<' before '=' */
passenger.Bus_Type = 'sitting' and
passenger.bus_type = price.bus_type and
passenger.distance = price.distance	;


/*8) What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to
Panaji?*/

select passenger.Passenger_name, price.Bus_type, price.Price  from travelonthego.passenger,travelonthego.price
where passenger.Passenger_name = 'Pallavi' and
passenger.distance = price.distance	;

/*9) List the distances from the "Passenger" table which are unique (non-repeated
distances) in descending order.*/

select distinct passenger.Distance from travelonthego.passenger
order by distance desc; 

/*10) Display the passenger name and percentage of distance travelled by that passenger
from the total distance travelled by all passengers without using user variables*/

select passenger.Passenger_name, 
passenger.distance*100/(select sum(passenger.Distance) from travelonthego.passenger) as Percentage_Of_Distance 
from travelonthego.passenger;

/*11) Display the distance, price in three categories in table Price
a) Expensive if the cost is more than 1000
b) Average Cost if the cost is less than 1000 and greater than 500
c) Cheap otherwise*/

select price.Distance, price.Price , 
case
	when price.Price>=1000 then 'Expensive'
    when 500<=price.Price<1000 then 'Average cost'
	else 'Cheap'
end as Verdict from travelonthego.price;
