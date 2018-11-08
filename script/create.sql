drop table if exists User; 
drop table if exists Item;
drop table if exists Category;
drop table if exists Bid;
CREATE TABLE User (userID VARCHAR(255) NOT NULL,rating DOUBLE(100, 2) NOT NULL,location VARCHAR(255) NOT NULL,country VARCHAR(255) NOT NULL, PRIMARY KEY (userID)); 
CREATE TABLE Item (itemID INT NOT NULL,name VARCHAR(255) NOT NULL,currently DOUBLE(100,2),buy_price DOUBLE(100,2) NOT NULL,first_bid DOUBLE(100,2) NOT NULL,started DATETIME NOT NULL,ends DATETIME NOT NULL,userID VARCHAR(255) NOT NULL,description TEXT NOT NULL,PRIMARY KEY (itemID), FOREIGN KEY (userID) REFERENCES User(userID));
CREATE TABLE Category (ItemID INT NOT NULL,category VARCHAR(255) NOT NULL, PRIMARY KEY (itemID,category), FOREIGN KEY (itemID) REFERENCES Item(itemID));
CREATE TABLE Bid (itemID INT NOT NULL,userID VARCHAR(255) NOT NULL,time DATETIME NOT NULL,amount DOUBLE(100,2) NOT NULL, PRIMARY KEY (itemID,userID,time), FOREIGN KEY (itemID) REFERENCES Item(itemID), FOREIGN KEY (userID) REFERENCES User(userID));
