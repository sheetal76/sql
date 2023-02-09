-- Q1. Query all columns for all American cities in the CITY table with populations larger than 100000.
-- The CountryCode for America is USA

create database Assignment_db

USE  Assignment_db;

SELECT ID,NAME,COUNTRYCODE,DISTRICT,POPULATION
from city
WHERE population>100000 AND COUNTRYCODE='USA';





-- Q2. Query the NAME field for all American cities in the CITY table with populations larger than 120000.
-- The CountryCode for America is USA.

SELECT name
from city
WHERE population> 120000;





