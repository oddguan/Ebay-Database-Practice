drop table if exists Category;
drop table if exists Bid;
drop table if exists Item;
drop table if exists User;

CREATE TABLE User (
userID VARCHAR(255) NOT NULL,
rating DOUBLE(100, 2) NOT NULL,
location VARCHAR(255) NOT NULL,
country VARCHAR(255) NOT NULL, 
PRIMARY KEY (userID));

CREATE TABLE Item (
itemID VARCHAR(255) NOT NULL,
name TEXT NOT NULL,
currently DOUBLE(100,2) NOT NULL,
buy_price DOUBLE(100,2) NOT NULL,
first_bid DOUBLE(100,2) NOT NULL,
started DATETIME NOT NULL,
ends DATETIME NOT NULL,
userID VARCHAR(255) NOT NULL,
description TEXT NOT NULL,
PRIMARY KEY (itemID), 
FOREIGN KEY (userID) REFERENCES User(userID));

CREATE TABLE Category (
itemID VARCHAR(255) NOT NULL,
category VARCHAR(255) NOT NULL, 
PRIMARY KEY (itemID,category),
FOREIGN KEY (itemID) REFERENCES Item(itemID)
);

CREATE TABLE Bid (
itemID VARCHAR(255) NOT NULL,
userID VARCHAR(255) NOT NULL,
time DATETIME NOT NULL,
amount DOUBLE(100,2) NOT NULL, 
PRIMARY KEY (itemID,userID,amount), 
FOREIGN KEY (userID) REFERENCES User(userID),
FOREIGN KEY (itemID) REFERENCES Item(itemID)
);

DROP TABLE if exists CurrentTime ;
CREATE TABLE CurrentTime (timeNow DATETIME NOT NULL) ;
INSERT INTO CurrentTime values ('2001-12-20 00:00:01') ;
SELECT timeNow FROM CurrentTime ;
