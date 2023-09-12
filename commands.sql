--start server
sudo service mysql start;

--connect to server
sudo mysql -u username@localhost -p;

--create new user 
create user 'forgithub'@'localhost' identified as 'password123';

--create schema/database
create database mydatabase_forgithub;

--use the db and create table 
use mydatabase_forgithub;
create table california_housing(
          id int auto_increment primary key,  
          income double, 
          house_age int, 
          house_size int, 
          rooms int, 
          bedrooms int, 
          latitude double, 
          longitude double, 
          house_price double 
);

--import the data
load data local infile "/home/kali/Desktop/database_manipulation/full_data.csv" into table california_housing fields terminated by ',' lines terminated by '\n' ignore 1 lines (income, house_age, house_size, rooms, bedrooms, latitude, longitude, house_price); 
alter table california_housing change column income next_yr_price_est;

--swap the values of names of bedrooms and house size then bedrooms and rooms
update table california_housing change column house_size brooms;
update table california_housing change column bedrooms house_size;
update table california_housing change column rooms bedrooms;
update table california_housing change column brooms rooms;

--multiply all income values by 100,000
update california_housing set next_yr_price_est = concat("$",next_yr_price_est);
update california_housing set next_yr_price_est = next_yr_price_est * 100,000;

--view the cheapest 10 and most expensive house prices.
select * from california_housing order by house_price asc limit 10;
select * from california_housing order by house_price desc limit 10;

--top 10 house price mean & median, bottom 10 house price mean & median 
select avg(subq.house_price) as avg_of_10_cheapest_houses from(
    select house_price 
    from california_housing 
    order by house_price asc 
    limit 10) as subq; 

select avg(subq.house_price) as avg_of_10_cheapest_houses from(
    select house_price 
    from california_housing 
    order by house_price desc 
    limit 10) as subq; 

--store the avg values colwise as csv
select avg(subq.house_price), avg(subq.next_yr_price_est), avg(subq.house_size) as avg_house_price, avg_next_yr_price_est, avg_house_size from (
    select * 
    from california_housing
    order by house_price asc
    limit 100
) as subq into outfile "averages.csv" fields terminated by ',' lines terminated by '\n';