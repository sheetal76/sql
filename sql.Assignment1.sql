-- Q1. Query all columns for all American cities in the CITY table with populations larger than 100000.
-- The CountryCode for America is USA

create database Assignment_db;

USE Assignment_db;

SELECT ID,NAME,COUNTRYCODE,DISTRICT,POPULATION
from city
WHERE population>100000 AND COUNTRYCODE='USA';

-- Q2. Query the NAME field for all American cities in the CITY table with populations larger than 120000.
-- The CountryCode for America is USA.

SELECT name
from city
WHERE population> 120000;

-- Q3. Query all columns (attributes) for every row in the CITY table.

SELECT * from city;

-- Q4. Query all columns for a city in CITY with the ID 1661.
SELECT * from city
WHERE ID=1661;

-- Q5. Query all attributes of every Japanese city in the CITY table. The COUNTRYCODE for Japan is
-- JPN
SELECT * FROM city
WHERE countrycode='JPN';

-- Q6. Query the names of all the Japanese cities in the CITY table. The COUNTRYCODE for Japan is
-- JPN.
SELECT name 
from city
WHERE countrycode='JPN';

-- Q7. Query a list of CITY and STATE from the STATION table.

create table stationdata
( id int,
city varchar(25),
state varchar(30),
lat_N int,
long_w int);

select city, state
from stationdata;

-- Q8. Query a list of CITY names from STATION for cities that have an even ID number. Print the results
-- in any order, but exclude duplicates from the answer.

select city 
from stationdata
where ID%2=0
order by city ASC

-- Q9. Find the difference between the total number of CITY entries in the table and the number of
-- distinct CITY entries in the table
;
select count(city) -count(distinct city) from stationdata;  

-- Q10. Query the two cities in STATION with the shortest and longest CITY names, as well as their
-- respective lengths (i.e.: number of characters in the name). If there is more than one smallest or
-- largest city, choose the one that comes first when ordered alphabetically.

select CITY, length(CITY) from STATIONDATA order by length(CITY), CITY limit 1;
select CITY, length(CITY) from STATIONDATA order by length(CITY) desc, CITY limit 1;

-- Q11. Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result
-- cannot contain duplicates 
select distinct city from stationdata where REGEXP_LIKE(city,'^[aeiou]+');

-- Q12.Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. Your result cannot
-- contain duplicates.

select distinct(CITY) from STATIONDATA where CITY like '%a' or CITY like '%e' or CITY like '%i' or CITY like '%o' 
or CITY like '%u';     

-- Q13. Query the list of CITY names from STATION that do not start with vowels. Your result cannot
-- contain duplicates.
select distinct city from stationdata WHERE upper(SUBSTR(CITY,1,1)) NOT IN ('A','E','I','O','U') AND lower(SUBSTR(CITY,1,1)) NOT IN
('a','e','i','o','u'); 

-- Q14. Query the list of CITY names from STATION that do not end with vowels. Your result cannot
-- contain duplicates.

select distinct city from stationdata WHERE upper(substr(city,length(city),1)) NOT IN ('A','E','I','O','U') 
     AND lower(substr(city,length(city),1) NOT IN ('a','e','i','o','u') 
     
-- Q15. Query the list of CITY names from STATION that either do not start with vowels or do not end
-- with vowels. Your result cannot contain duplicates.
;
SELECT DISTINCT CITY FROM STATIONDATA WHERE LOWER(SUBSTR(CITY,1,1)) NOT IN ('a','e','i','o','u') OR LOWER(SUBSTR(CITY, LENGTH(CITY),1)) NOT IN ('a','e','i','o','u');   

-- Q16. Query the list of CITY names from STATION that do not start with vowels and do not end with
-- vowels. Your result cannot contain duplicates.

SELECT DISTINCT CITY FROM STATIONDATA WHERE LOWER(SUBSTR(CITY,1,1)) NOT IN ('a','e','i','o','u') AND LOWER(SUBSTR(CITY,LENGTH(CITY),1)) NOT IN ('a','e','i','o','u');    

-- Q.17 Write an SQL query that reports the products that were only sold in the first quarter of 2019. That is,
-- between 2019-01-01 and 2019-03-31 inclusive.
-- Return the result table in any order.

create table product
( product_id int not null ,
  product_name varchar(20),
  unit_price int,
 primary key(product_id));

INSERT INTO product values(2,'G4',800);
INSERT INTO product values(3,'iPhone',1400);

create table sales(
seller_id int,
product_id int,
buyer_id int,
sale_date date,
quantity int,
price int,
foreign key(product_id) references product( product_id)
);

INSERT INTO sales values(1,1,1,'2019-01-21',2,2000);
INSERT INTO sales values(1,2,2,'2019-02-17',1,800);
INSERT INTO sales values(2,2,3,'2019-06-02',1,800);
INSERT INTO sales values(3,3,4,'2019-05-13',2,2800);

select product.product_id, product.product_name from product join sales on product.product_id = sales.product_id
Group by product_id Having min(sale_date)>="2019-01-01" And Max(sale_date)<="2019-03-31"

 -- Q.18 Write an SQL query to find all the authors that viewed at least one of their own articles.
-- Return the result table sorted by id in ascending order.
;
create table Views
( article_id int,
  viewer_id int,
  author_id int,
  view_date date
);

INSERT INTO Views values(1,5,3,'2019-08-01');
INSERT INTO Views values(1,6,3,'2019-08-02');
INSERT INTO Views values(2,7,7,'2019-08-01');
INSERT INTO Views values(2,6,7,'2019-08-02'); 
INSERT INTO Views values(4,1,7,'2019-07-22');
INSERT INTO Views values(3,4,4,'2019-07-21');
INSERT INTO Views values(3,4,4,'2019-07-21');

select distinct author_id as id
from Views 
WHERE author_id = viewer_id
order by id asc;

-- Q.19 If the customer's preferred delivery date is the same as the order date, then the order is called
-- immediately; otherwise, it is called scheduled.
-- Write an SQL query to find the percentage of immediate orders in the table, rounded to 2 decimal
-- places. 
create table Delivery
(delivery_id int not null,
 customer_id int,
 order_date date,
 customer_pref_del_date date,
 primary key(delivery_id));
 
 INSERT INTO Delivery values (1,1,'2019-08-01','2019-08-02');
 INSERT INTO Delivery values (2,5,'2019-08-02','2019-08-02'); 
 INSERT INTO Delivery values (3,1,'2019-08-11','2019-08-11');
 INSERT INTO Delivery values (4,3,'2019-08-24','2019-08-26');
 INSERT INTO Delivery values (5,4,'2019-08-21','2019-08-22');
 INSERT INTO Delivery values (6,2,'2019-08-11','2019-08-13');
 
 select Round(sum(order_date =  customer_pref_del_date)*100/6,2) as immediate_orders from Delivery;

-- Q.20 Write an SQL query to find the ctr of each Ad. Round ctr to two decimal points.
-- Return the result table ordered by ctr in descending order and by ad_id in ascending order in case of a
-- tie.

create table Ads
( ad_id int not null,
  user_id int not null,
  action ENUM ('Clicked', 'Viewed', 'Ignored'),
  primary key(ad_id, user_id)
);

INSERT INTO Ads values(1,1,'clicked');
 INSERT INTO Ads values(2,2,'clicked');       
 INSERT INTO Ads values(3,3,'viewed');
INSERT INTO Ads values(5,5,'ignored');
INSERT INTO Ads values(1,7,'ignored');
INSERT INTO Ads values(2,7,'viewed');        
INSERT INTO Ads values(3,5,'clicked');           
 INSERT INTO Ads values(1,4,'viewed');             
 INSERT INTO Ads values(2,11,'viewed'); 
 INSERT INTO Ads values(1,2,'clicked'); 
 
select ad_id,
    ifnull(round(sum(action ='Clicked')/sum(action !='ignored') *100,2),0) ctr
from ads
group by ad_id
order by ctr desc, ad_id;
 
 -- Q.21Write an SQL query to find the team size of each of the employees.
-- Return result table in any order.
 
 create table  Employee
 ( employee_id int not null,
   team_id int
 );
 
 INSERT INTO Employee values(1,8);
 INSERT INTO Employee values(2,8);
 INSERT INTO Employee values(3,8);
 INSERT INTO Employee values(4,7);
 INSERT INTO Employee values(5,9);
 INSERT INTO Employee values(6,9);
 
select e.employee_id, (select count(team_id) from Employee where e.team_id = team_id) as team_size
from Employee e;
 
-- Q.22.Write an SQL query to find the type of weather in each country for November 2019.
-- The type of weather is:
-- ● Cold if the average weather_state is less than or equal 15,
-- ● Hot if the average weather_state is greater than or equal to 25, and
-- ● Warm otherwise.
-- Return result table in any order.

create table countries
( country_id int not null,
  country_name varchar(30),
  primary key(country_id)
);

INSERT INTO countries values(2,'USA');
INSERT INTO countries values(3,'Australia');
INSERT INTO countries values(7,'Peru');
INSERT INTO countries values(5,'China');
INSERT INTO countries values(8,'Morocco');
INSERT INTO countries values(9,'Spain');

create table  Weather
( country_id int not null,
  weather_state int,
  day date ,
  primary key (country_id, day));
  
INSERT INTO Weather VALUES(2,15,'2019-11-01');
INSERT INTO Weather VALUES(2,12,'2019-10-28');
INSERT INTO Weather VALUES(2,12,'2019-10-27');
INSERT INTO Weather VALUES(3,-2,'2019-11-10');
INSERT INTO Weather VALUES(3,0,'2019-11-11');
INSERT INTO Weather VALUES(3,3,'2019-11-12');
INSERT INTO Weather VALUES(5,16,'2019-11-07');
INSERT INTO Weather VALUES(5,18,'2019-11-09');
INSERT INTO Weather VALUES(5,21,'2019-11-23');
INSERT INTO Weather VALUES(7,25,'2019-11-28');
INSERT INTO Weather VALUES(7,22,'2019-12-01');
INSERT INTO Weather VALUES(7,20,'2019-12-02');
INSERT INTO Weather VALUES(8,25,'2019-11-05');
INSERT INTO Weather VALUES(8,27,'2019-11-15');
INSERT INTO Weather VALUES(8,31,'2019-11-25');
INSERT INTO Weather VALUES(9,7,'2019-10-23');
INSERT INTO Weather VALUES(9,3,'2019-12-23');

SELECT c.country_name,
case when avg(weather_state)<=15 then 'cold'
     when avg(weather_state)>=25 then 'Hot'
	else 'warm' end as weather_type
from weather w
left join countries c 
on w.country_id = c.country_id
where month(day) = 11
and year(day) = 2019
group by c .country_name;   

-- Q23. Write an SQL query to find the average selling price for each product. average_price should be
-- rounded to 2 decimal places.
-- Return the result table in any order.   

create table prices
( product_id int not null,
  start_date date not null,
  end_date date not null,
  price int,
  primary key(product_id ,start_date,end_date)
);

INSERT INTO prices values(1,'2019-02-17','2019-02-28',5);
INSERT INTO prices values(1,'2019-03-01','2019-03-22',20);
INSERT INTO prices values(2,'2019-02-01','2019-02-20',15);
INSERT INTO prices values(2,'2019-02-21','2019-03-31',30);

create table  UnitsSold
(product_id int,
purchase_date date,
units int
);

INSERT INTO  UnitsSold values(1,'2019-02-25',100);
INSERT INTO  UnitsSold values(1,'2019-03-01',15);
INSERT INTO  UnitsSold values(2,'2019-02-10',200);
INSERT INTO  UnitsSold values(2,'2019-03-22',30);

select product_id, ifnull(round(sum(prices_sum) / sum(units), 2), 0) as average_price
    from (
        select p.product_id as product_id, units, price * units as prices_sum
            from Prices p left join UnitsSold u
            on p.product_id = u.product_id and purchase_date between start_date and end_date
    ) as temp
    group by product_id;
    
-- Q 24.Write an SQL query to report the first login date for each player.
-- Return the result table in any order.

create table Activity
(player_id int not null,
device_id int,
event_date date not null,
games_played int,
primary key(player_id,event_date) );

INSERT INTO Activity values(1,2,'2016-03-01',5);
INSERT INTO Activity values(1,2,'2016-05-02',6);
INSERT INTO Activity values(2,3,'2017-06-25',1);
INSERT INTO Activity values(3,1,'2016-03-02',0);
INSERT INTO Activity values(3,4,'2018-07-03',5);

select player_id, min(event_date) as first_login
from Activity 
group by player_id;

-- Q25.Write an SQL query to report the device that is first logged in for each player.
-- Return the result table in any order.

SELECT player_id,device_id
FROM Activity
WHERE (player_id, event_date) IN (SELECT player_id, MIN(event_date) FROM Activity group by  player_id);
                                      
-- Q26.Write an SQL query to get the names of products that have at least 100 units ordered in February 2020
-- and their amount.
-- Return result table in any order

create table Products
( product_id int not null,
  product_name varchar(30),
  product_category varchar(30),
  primary key(product_id) );
  
  create table Orders(
  product_id int,
  order_date date,
  unit int,
  foreign key(product_id) references Products( product_id)
  );
  
  INSERT INTO Products values(1,'Leetcode Solutions','Book');
  INSERT INTO Products values(2,'Jewels of Stringology','Book');
  INSERT INTO Products values(3,'HP','Laptop');
  INSERT INTO Products values(4,'Lenovo','Laptop');
  INSERT INTO Products values(5,'Leetcode kit','T-shirt');

  INSERT INTO Orders values(1,'2020-02-05',60);
  INSERT INTO Orders values(1,'2020-02-10',70);
  INSERT INTO Orders values(2,'2020-01-18',30);
  INSERT INTO Orders values(2,'2020-02-11',80);
  INSERT INTO Orders values(3,'2020-02-17',2);
  INSERT INTO Orders values(3,'2020-02-24',3);
  INSERT INTO Orders values(4,'2020-03-01',20);
  INSERT INTO Orders values(4,'2020-03-04',30);
  INSERT INTO Orders values(4,'2020-03-04',60);
  INSERT INTO Orders values(5,'2020-02-27',50);
  INSERT INTO Orders values(5,'2020-02-05',50);
  INSERT INTO Orders values(5,'2020-03-01',50);

select p.product_name as product_name, o.sum_unit as unit from Products p 
join (select product_id, sum(unit) as sum_unit from Orders where order_date >= '2020-02-01' and order_date < '2020-03-01' 
group by product_id) o 
on p.product_id = o.product_id
where o.sum_unit >= 100

-- Q27.Write an SQL query to find the users who have valid emails.
create table Users(
user_id int not null,
name varchar(30),
email varchar(30),
primary key (user_id)
);

Insert into Users values(1,'Winston','winston@leetcode.com');
Insert into Users values(2,'Jonathan','Jonathanis greate');
Insert into Users values(3,'Annabelle','bella-@leetcode.com');
Insert into Users values(4,'Sally','sally.come@leetcode.com');
Insert into Users values(5,'Marwan','quarz#2020@leetcode.com');
Insert into Users values(6,'David','david69@gmail.com');
Insert into Users values(7,'Shapiro','.shapo@leetcode.com');

SELECT *
FROM Users
WHERE REGEXP_LIKE(email, '^[a-zA-Z][a-zA-Z0-9\_\.\-]*@leetcode.com')

-- Q28.Write an SQL query to report the customer_id and customer_name of customers who have spent at
-- least $100 in each month of June and July 2020.
;
create table Customers(
customer_id int not null,
name varchar(30),
country varchar(30),
primary key(customer_id)
);

create table  Product1(
Product_id int not null,
description varchar(30),
price int,
primary key(Product_id)
);

create table  Orders1
(order_id int not null,
 customer_id int,
 product_id int,
 order_date date,
 quantity int,
 primary key(order_id)
);

INSERT INTO Customers values(1,'Winston','USA');
INSERT INTO Customers values(2,'Jonathan', 'Peru');
INSERT INTO Customers values(3,'Moustafa','Egypt');

INSERT INTO Product1 values(10,'LCPhone',300);
INSERT INTO Product1 values(20,'LC T-Shirt',10);
INSERT INTO Product1 values(30,'LC Book',45);
INSERT INTO Product1 values(40,'LC keychain',2);

INSERT INTO Orders1 values(1,1,10,'2020-06-10',1);
INSERT INTO Orders1 values(2,1,20,'2020-07-01',1);
INSERT INTO Orders1  values(3,1,30,'2020-07-08',2);
INSERT INTO  Orders1  values(4,2,10,'2020-06-15',2);
INSERT INTO  Orders1  values(5,2,40,'2020-07-01',10);
INSERT INTO  Orders1  values(6,3,20,'2020-06-24 ',2);
INSERT INTO  Orders1  values(7,3,30,'2020-06-25',2);
INSERT INTO  Orders1  values(9,3,30,' 2020-05-08',3);

select o.customer_id, c.name
from Customers c, Product1 p, Orders1 o
where c.customer_id = o.customer_id and p.product_id = o.product_id
group by o.customer_id
having 
(
    sum(case when o.order_date like '2020-06%' then o.quantity*p.price else 0 end) >= 100
    and
    sum(case when o.order_date like '2020-07%' then o.quantity*p.price else 0 end) >= 100
);

-- Q29.Write an SQL query to report the distinct titles of the kid-friendly movies streamed in June 2020.
-- Return the result table in any order

create table TVProgram(
program_date date not null,
content_id int not null,
channel varchar(30),
primary key(program_date,content_id)
);

create table  Content(
content_id int not null,
title varchar(25),
Kids_content enum  ('Y', 'N'),
content_type varchar(25),
primary key(content_id)
);

INSERT INTO TVProgram values('2020-06-10 08:00', 1, 'LC-Channel');
INSERT INTO TVProgram values('2020-05-11 12:00', 2, 'LC-Channel');
INSERT INTO TVProgram values('2020-05-12 12:00', 3 ,'LC-Channel');
INSERT INTO TVProgram values('2020-05-13 14:00', 4, 'Disney Ch');
INSERT INTO TVProgram values('2020-06-10 08:00', 1, 'LC-Channel');

INSERT INTO Content values(1,'Leetcode Movie', 'N', 'Movies');
INSERT INTO Content values(2, 'Alg.for Kids', 'Y', 'Series');
INSERT INTO Content values(3, 'Database Sols', 'N', 'Serie,s');
INSERT INTO Content values(4, 'Aladdin', 'Y', 'Movies');
INSERT INTO Content values(5, 'Cinderella', 'Y', 'Movies');

select c.title from Content c
join TVProgram t on c.content_id = t.content_id
where content_type = 'Movies' and kids_content = 'Y';

-- Q30.Write an SQL query to find the npv of each query of the Queries table.
-- Return the result table in any order
;
create table NPV(
id int not null,
year int not null,
npv int,
primary key(id ,year)
);

create table  Queries(
id int not null,
year int not null,
primary key(id , year)
);

INSERT INTO NPV values(1,2018,100),(7,2020,30),(13, 2019, 40),(1, 2019, 113),(2, 2008, 121),(3, 2009, 12),(11, 2020, 99),(7, 2019, 0);
INSERT into  Queries values(1,2019),(2,2008),(3,2009),(7,2018),(7,2019),(7,2020),(13,2019);

select q.id , q.year , 
case when NPV.npv is not null then NPV.npv
else 0 end as npv
from  Queries q left join NPV
on q.id = NPV.id and q.year = NPV.year;

-- Q.31.Write an SQL query to show the unique ID of each user, If a user does not have a unique ID replace just
-- show null.

create table Employees1(
id int not null,
name varchar(30),
primary key(id));

create table  EmployeeUNI(
id int not null,
unique_id int not null,
primary key(id, unique_id));

INSERT INTO Employees1 values(1, 'Alice'),(7, 'Bob'),(11, 'Meir'),(90, 'Winston'),(3, 'Jonathan');
insert into  EmployeeUNI values(3,1),(11,2),(90,3);

select e.name , ifnull(q.unique_id, 'null') as unique_id from Employees1 e
left join EmployeeUNI q on e.id =q.id
order by q.unique_id;

-- Q32.Write an SQL query to report the distance travelled by each user.
-- Return the result table ordered by travelled_distance in descending order, if two or more users
-- travelled the same distance, order them by their name in ascending order.

create table Users2(
id int not null,
name varchar(25),
primary key(id)
);

create table Rides(
id int not null,
user_id int,
distance int,
primary key(id));

INSERT INTO Users2 values(1,'Alice'),(2, 'Bob'),(3, 'Alex'),(4, 'Donald'),(7, 'Lee'),(13, 'Jonathan'),(19 ,'Elvis');
INSERT INTO  Rides values(1, 1, 120),(2, 2, 317),(3, 3, 222),(4, 7, 100),(5 ,13 ,312),(6, 19, 50),(7 ,7 ,120),(8, 19, 400),(9, 7 ,230);

select  u.name , sum(ifnull(r.distance,0)) as distance_travelled
from Users2 u left join Rides r on u.id = r.user_id
group by name
order by distance_travelled desc;

-- Q33.Write an SQL query to:
-- ● Find the name of the user who has rated the greatest number of movies. In case of a tie,
-- return the lexicographically smaller user name.
-- ● Find the movie name with the highest average rating in February 2020. In case of a tie, return
-- the lexicographically smaller movie name

create table Movies1(
movie_id int not null,
title varchar(25),
primary key(movie_id));

create table Users1(
user_id int not null,
name varchar(25),
primary key(user_id));

create table MovieRating(
movie_id int not null,
user_id int not null,
rating int,
created_at date,
primary key(movie_id,user_id));

INSERT INTO Movies1 values( 1 , 'Avengers'),(2, 'Frozen 2'),(3, 'Joker');
INSERT INTO Users1 values(1, 'Daniel'),(2, 'Monica'),(3, 'Maria'),(4, 'James');
INSERT INTO MovieRating values(1, 1, 3, '2020-01-12'),(1, 2, 4, '2020-02-11'),(1 ,3, 2 ,'2020-02-12'),(1, 4, 1, '2020-01-01'),
(2, 1, 5, '2020-02-17'),(2, 2, 2, '2020-02-01'),(2, 3, 2, '2020-03-01'),(3, 1, 3, '2020-02-22'),(3, 2, 4, '2020-02-25');

SELECT user_name AS results FROM
(
SELECT a.name AS user_name, COUNT(*) AS counts FROM MovieRating AS b
    JOIN Users1 AS a
    on a.user_id = b.user_id
    GROUP BY b.user_id
    ORDER BY counts DESC, user_name ASC LIMIT 1
) first_query
UNION
SELECT movie_name AS results FROM
(
SELECT c.title AS movie_name, AVG(d.rating) AS rate FROM MovieRating AS d
    JOIN Movies1 AS c
    on c.movie_id = d.movie_id
    WHERE substr(d.created_at, 1, 7) = '2020-02'
    GROUP BY d.movie_id
    ORDER BY rate DESC, movie_name ASC LIMIT 1
) second_query;

-- Q34.Write an SQL query to find the id and the name of all students who are enrolled in departments that no
-- longer exist.

create table departments(
id int not null,
name varchar(30),
primary key(id));

create table students(
id int not null,
name varchar(30),
department_id int,
primary key(id));

INSERT INTO departments values(1, 'Electrical Engineering'),(7, 'Computer Engineering'),(13, 'Business Administration');
INSERT INTO students values(23, 'Alice', 1),(1, 'Bob', 7),(5, 'Jennifer', 13),(2, 'John', 14),(4, 'Jasmine', 77),(3, 'Steve', 74),
          (6, 'Luis', 1),(8, 'Jonathan' ,7),(7, 'Daiana', 33),(11, 'Madelynn', 1);
 
SELECT id, name 
FROM students
WHERE department_id not in (SELECT id from departments);

-- Q35.Write an SQL query to report the number of calls and the total call duration between each pair of
-- distinct persons (person1, person2) where person1 < person2. 

create table calls
(from_id int,
to_id int,
duration int);

INSERT INTO  calls values(1, 2, 59),(2, 1, 11),(1, 3, 20),(3, 4, 100),(3, 4, 200),(4, 3, 499);

select least(from_id , to_id) as person1, greatest(from_id , to_id) as person2,
count(*) as call_count,
sum(duration) as total_duration
from calls
group by person1,person2;

-- Q36.Write an SQL query to find the average selling price for each product. average_price should be
-- rounded to 2 decimal places.

create table Prices1
( product_id int not null,
start_date date not null,
end_date date not null,
price int, 
primary key(product_id,start_date,end_date));

INSERT INTO Prices1 values(1,'2019-02-17', '2019-02-28', 5),(1, '2019-03-01', '2019-03-22', 20),(2, '2019-02-01', '2019-02-20', 15),
						(2, '2019-02-21', '2019-03-31', 30);

create table UnitsSold1
(product_id int,
purchase_date date,
units int);

INSERT INTO UnitsSold1 values(1, '2019-02-25', 100),(1, '2019-03-01', 15),(2, '2019-02-10', 200),(2, '2019-03-22', 30);

select p.product_id , (round(sum(p.price*s.units)/sum(s.units),2) ,0) as average_price from Prices1 p  
join UnitsSold s on p.product_id = s.product_id 
group by product_id

-- Q37.Write an SQL query to report the number of cubic feet of volume the inventory occupies in each
-- warehouse
;
create table Warehouse
(name varchar(30) not null,
product_id int not null,
units int,
primary key(name,product_id));

INSERT INTO Warehouse values('LCHouse1', 1, 1),('LCHouse1', 2, 10),('LCHouse1', 3, 5),('LCHouse2', 1, 2),('LCHouse2', 2, 2),('LCHouse3', 4, 1);
 
 create table Products3
 (product_id int not null,
product_name varchar(25),
Width int,
Length int,
Height int,
primary key(product_id));

INSERT INTO  Products3 values(1, 'LC-TV', 5, 50 ,40),(2, 'LC-KeyChain', 5, 5, 5),(3, 'LC-Phone', 2, 10, 10),(4, 'LC-T-Shirt', 4, 10, 20);

select name as warehouse_name, sum(units * vol) as volume
from Warehouse w
join (select product_id, Width*Length*Height as vol
     from Products3) p
on w.product_id = p.product_id
group by name

-- Q38.Write an SQL query to report the difference between the number of apples and oranges sold each day.
-- Return the result table ordered by sale_date.

create table sales1
(sale_date date not null,
fruit enum  ("Apples","Oranges") not null,
sold_num int,
primary key(sale_date,fruit));

INSERT INTO sales1 values('2020-05-01', 'apples', 10),('2020-05-01', 'oranges',8),('2020-05-02','apples', 15),('2020-05-02','oranges', 15),
                     ('2020-05-03', 'apples', 20),('2020-05-03', 'oranges', 0),('2020-05-04', 'apples', 15),('2020-05-04', 'oranges', 16);

select date(sale_date) as sale_date,
       sum(case when fruit = 'apples' then sold_num
			when fruit = 'oranges' then -sold_num end) as diff from sales1
group by 1
order by 1;

-- Q39.Write an SQL query to report the fraction of players that logged in again on the day after the day they
-- first logged in, rounded to 2 decimal places. In other words, you need to count the number of players
-- that logged in for at least two consecutive days starting from their first login date, then divide that
-- number by the total number of players.

create table Activity1
(player_id int not null,
device_id int,
event_date date not null,
games_played int,
primary key(player_id,event_date));

INSERT INTO Activity1 values(1, 2, '2016-03-01', 5),(1, 2, '2016-03-02', 6),(2, 3, '2017-06-25', 1),(3, 1, '2016-03-02', 0),
(3, 4, '2018-07-03', 5);

select Round(count(distinct b.player_id)/count(a.player_id),2) as Fraction from
((select player_id, min(event_date) as event_date from Activity1
group by player_id) a left join Activity1 b on a.player_id = b.player_id and a.event_date+1 = b.event_date) ;

-- Q40.Write an SQL query to report the managers with at least five direct reports.
-- Return the result table in any order 

create table Employee1
(id int not null,
name varchar(25),
department varchar(25),
managerId int,
primary key(id));

INSERT INTO Employee1 values(101, 'John', 'A',"None"),(102, 'Dan', 'A', 101),(103, 'James', 'A', 101),(104, 'Amy', 'A', 101),
    (105, 'Anne', 'A', 101),(106, 'Ron', 'B', 101);

select a.name from  Employee1 a
inner join Employee1 b
on (a.id = b.managerid) 
group by a.name 

--  Q41.Write an SQL query to report the respective department name and number of students majoring in
-- each department for all departments in the Department table (even ones with no current students).
-- Return the result table ordered by student_number in descending order. In case of a tie, order them by
-- dept_name alphabetically.

create table Students1
(student_id int not null,
student_name varchar(25),
gender varchar(25),
dept_id int,
primary key(student_id));

INSERT INTO Students1 values(1, 'Jack', 'M', 1),(2, 'Jane', 'F', 1),(3, 'Mark', 'M', 2);

create table Department1(dept_id int not null,
dept_name varchar(25),
primary key(dept_id));

INSERT INTO Department1 values(1, 'Engineering'),(2, 'Science'),(3, 'Law');

select d.dept_name,  coalesce(count(student_id), 0) as student_number from Department1 d
left join Students1 s on s.dept_id = d.dept_id
group by d.dept_name, s.dept_id
order by student_number desc , d.dept_name asc; 

-- Q42.Write an SQL query to report the customer ids from the Customer table that bought all the products in
-- the Product table.

create table customer1
(customer_id int,
product_key int,
foreign key(product_key) references products4(product_key));

INSERT INTO Customer values(1, 5),(2, 6),(3, 5),(3, 6),(1, 6);

select customer_id from customer1
group by customer_id
having count(distinct product_key)=(select count(distinct product_key) from products4


   

create table products4
(product_key int not null,
primary key(product_key));



-- Q43.Write an SQL query that reports the most experienced employees in each project. In case of a tie,
-- report all employees with the maximum number of experience years

 create table Project
 (project_id int not null,
employee_id int not null,
primary key(project_id ,employee_id));

INSERT INTO Project values(1, 1),(1, 2),(1, 3),(2, 1),(2, 4);

create table Employee3
(employee_id int not null,
name varchar(25),
experience_years int,
primary key(employee_id),
constraint fk_employee_id foreign key(employee_id) references Project(employee_id));











 


 








































































