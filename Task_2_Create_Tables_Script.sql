
-- BEREALTY REAL ESTATE PROPERTY MANAGEMENT DATABASE

-- 1. Create Database
CREATE DATABASE IF NOT EXISTS BerealtyDB;
USE BerealtyDB;

-- 2. AGENT TABLE

CREATE TABLE Agent (
    AgentID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(20),
    HireDate DATE,
    OfficeLocation VARCHAR(100)
);

INSERT INTO Agent 
(AgentID, FirstName, LastName, Email, Phone, HireDate, OfficeLocation)
VALUES
(1, 'Anna', 'Schmidt', 'anna.schmidt@berealty.de', '01760000001', '2022-03-15', 'Berlin Mitte'),
(2, 'David', 'Meyer', 'david.meyer@berealty.de', '01760000002', '2023-01-10', 'Berlin West'),
(3, 'Sophie', 'Wagner', 'sophie.wagner@berealty.de', '01760000003', '2021-08-20', 'Berlin Charlottenburg'),
(4, 'Daniel', 'Fischer', 'daniel.fischer@berealty.de', '01760000004', '2024-02-12', 'Berlin Neukölln'),
(5, 'Laura', 'Becker', 'laura.becker@berealty.de', '01760000005', '2023-06-05', 'Berlin Friedrichshain');

-- 3. CLIENT TABLE

CREATE TABLE Client (
    ClientID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(20),
    ClientType VARCHAR(30),
    RegistrationDate DATE
);

INSERT INTO Client
(ClientID, FirstName, LastName, Email, Phone, ClientType, RegistrationDate)
VALUES
(1, 'John', 'Smith', 'john.smith@email.com', '01761111111', 'Buyer', '2026-01-15'),
(2, 'Maria', 'Brown', 'maria.brown@email.com', '01762222222', 'Tenant', '2026-02-10'),
(3, 'Thomas', 'Wilson', 'thomas.wilson@email.com', '01763333333', 'Buyer', '2026-02-18'),
(4, 'Emma', 'Taylor', 'emma.taylor@email.com', '01764444444', 'Tenant', '2026-03-05'),
(5, 'Oliver', 'Johnson', 'oliver.johnson@email.com', '01765555555', 'Buyer', '2026-03-12'),
(6, 'Sophia', 'Martin', 'sophia.martin@email.com', '01766666666', 'Tenant', '2026-04-01');


-- 4. OWNER TABLE

CREATE TABLE Owner (
    OwnerID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(20),
    Address VARCHAR(200)
);

INSERT INTO Owner
(OwnerID, FirstName, LastName, Email, Phone, Address)
VALUES
(1, 'Peter', 'Klein', 'peter.klein@email.com', '01767777777', 'Berlin Mitte'),
(2, 'Laura', 'Fischer', 'laura.fischer@email.com', '01768888888', 'Berlin Charlottenburg'),
(3, 'Michael', 'Schulz', 'michael.schulz@email.com', '01769999999', 'Berlin Prenzlauer Berg'),
(4, 'Julia', 'Hoffmann', 'julia.hoffmann@email.com', '01761000000', 'Berlin Friedrichshain'),
(5, 'Robert', 'Krause', 'robert.krause@email.com', '01762000000', 'Berlin Neukölln');


-- 5. PROPERTY TABLE

CREATE TABLE Property (
    PropertyID INT PRIMARY KEY,
    PropertyType VARCHAR(50) NOT NULL,
    Address VARCHAR(200) NOT NULL,
    City VARCHAR(50),
    PostalCode VARCHAR(20),
    Bedrooms INT,
    Bathrooms INT,
    AreaSqft DECIMAL(10,2),
    Price DECIMAL(12,2),
    Status VARCHAR(30),
    AgentID INT,
    FOREIGN KEY (AgentID) REFERENCES Agent(AgentID)
);

INSERT INTO Property
(PropertyID, PropertyType, Address, City, PostalCode,
 Bedrooms, Bathrooms, AreaSqft, Price, Status, AgentID)
VALUES
(101, 'Apartment', 'Alexanderplatz 10', 'Berlin', '10178',
 2, 1, 850.00, 420000.00, 'Available', 1),

(102, 'House', 'Kantstrasse 25', 'Berlin', '10623',
 4, 2, 1600.00, 780000.00, 'Available', 2),

(103, 'Apartment', 'Schönhauser Allee 45', 'Berlin', '10435',
 3, 2, 1100.00, 560000.00, 'Sold', 3),

(104, 'Commercial', 'Friedrichstrasse 80', 'Berlin', '10117',
 0, 2, 2500.00, 950000.00, 'Available', 4),

(105, 'Apartment', 'Warschauer Strasse 20', 'Berlin', '10245',
 2, 1, 780.00, 390000.00, 'Available', 5),

(106, 'House', 'Hermannstrasse 90', 'Berlin', '12051',
 5, 3, 2100.00, 850000.00, 'Available', 4),

(107, 'Apartment', 'Prenzlauer Allee 70', 'Berlin', '10405',
 1, 1, 620.00, 310000.00, 'Sold', 3),

(108, 'Commercial', 'Kurfürstendamm 120', 'Berlin', '10711',
 0, 3, 3200.00, 1250000.00, 'Available', 2);


-- 6. PROPERTY OWNER TABLE

CREATE TABLE PropertyOwner (
    PropertyID INT,
    OwnerID INT,
    OwnershipPercentage DECIMAL(5,2) NOT NULL,
    PRIMARY KEY (PropertyID, OwnerID),
    FOREIGN KEY (PropertyID) REFERENCES Property(PropertyID),
    FOREIGN KEY (OwnerID) REFERENCES Owner(OwnerID)
);

INSERT INTO PropertyOwner
(PropertyID, OwnerID, OwnershipPercentage)
VALUES
(101, 1, 100.00),
(102, 2, 100.00),
(103, 3, 100.00),
(104, 4, 100.00),
(105, 5, 100.00),
(106, 1, 50.00),
(106, 2, 50.00),
(107, 3, 100.00),
(108, 4, 100.00);

-- 7. VIEWING TABLE

CREATE TABLE Viewing (
    ViewingID INT PRIMARY KEY,
    PropertyID INT NOT NULL,
    ClientID INT NOT NULL,
    AgentID INT NOT NULL,
    ViewingDate DATE,
    ViewingTime TIME,
    ViewingStatus VARCHAR(30),
    FOREIGN KEY (PropertyID) REFERENCES Property(PropertyID),
    FOREIGN KEY (ClientID) REFERENCES Client(ClientID),
    FOREIGN KEY (AgentID) REFERENCES Agent(AgentID)
);

INSERT INTO Viewing
(ViewingID, PropertyID, ClientID, AgentID,
 ViewingDate, ViewingTime, ViewingStatus)
VALUES
(1, 101, 1, 1, '2026-05-10', '14:00:00', 'Completed'),
(2, 102, 2, 2, '2026-05-15', '11:00:00', 'Completed'),
(3, 105, 3, 5, '2026-05-18', '15:00:00', 'Completed'),
(4, 104, 4, 4, '2026-05-20', '10:30:00', 'Scheduled'),
(5, 106, 5, 4, '2026-05-25', '13:00:00', 'Completed'),
(6, 108, 6, 2, '2026-06-02', '16:00:00', 'Scheduled'),
(7, 103, 1, 3, '2026-04-12', '12:00:00', 'Completed'),
(8, 107, 3, 3, '2026-04-20', '11:30:00', 'Completed');


-- 8. TRANSACTION TABLE

CREATE TABLE `Transaction` (
    TransactionID INT PRIMARY KEY,
    PropertyID INT NOT NULL,
    ClientID INT NOT NULL,
    AgentID INT NOT NULL,
    TransactionType VARCHAR(30),
    TransactionDate DATE,
    Price DECIMAL(12,2),
    PaymentMethod VARCHAR(30),
    Status VARCHAR(30),
    FOREIGN KEY (PropertyID) REFERENCES Property(PropertyID),
    FOREIGN KEY (ClientID) REFERENCES Client(ClientID),
    FOREIGN KEY (AgentID) REFERENCES Agent(AgentID)
);

INSERT INTO `Transaction`
(TransactionID, PropertyID, ClientID, AgentID,
 TransactionType, TransactionDate, Price, PaymentMethod, Status)
VALUES
(1001, 103, 1, 3, 'Sale', '2026-04-25', 560000.00, 'Bank Transfer', 'Completed'),
(1002, 107, 3, 3, 'Sale', '2026-05-02', 310000.00, 'Bank Transfer', 'Completed'),
(1003, 101, 5, 1, 'Sale', '2026-06-05', 420000.00, 'Mortgage', 'Completed'),
(1004, 102, 2, 2, 'Rental', '2026-06-15', 2500.00, 'Bank Transfer', 'Completed'),
(1005, 105, 6, 5, 'Rental', '2026-07-01', 1800.00, 'Bank Transfer', 'Completed'),
(1006, 104, 4, 4, 'Sale', '2026-07-12', 950000.00, 'Bank Transfer', 'Completed'),
(1007, 106, 1, 4, 'Sale', '2026-08-03', 850000.00, 'Mortgage', 'Pending'),
(1008, 108, 5, 2, 'Sale', '2026-08-10', 1250000.00, 'Bank Transfer', 'Pending');


-- 9. PAYMENT TABLE

CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY,
    TransactionID INT NOT NULL,
    PaymentDate DATE,
    Amount DECIMAL(12,2),
    PaymentMethod VARCHAR(30),
    PaymentStatus VARCHAR(30),
    FOREIGN KEY (TransactionID) REFERENCES `Transaction`(TransactionID)
);

INSERT INTO Payment
(PaymentID, TransactionID, PaymentDate, Amount,
 PaymentMethod, PaymentStatus)
VALUES
(5001, 1001, '2026-04-25', 560000.00, 'Bank Transfer', 'Paid'),
(5002, 1002, '2026-05-02', 310000.00, 'Bank Transfer', 'Paid'),
(5003, 1003, '2026-06-05', 420000.00, 'Mortgage', 'Paid'),
(5004, 1004, '2026-06-15', 2500.00, 'Bank Transfer', 'Paid'),
(5005, 1005, '2026-07-01', 1800.00, 'Bank Transfer', 'Paid'),
(5006, 1006, '2026-07-12', 950000.00, 'Bank Transfer', 'Paid'),
(5007, 1007, '2026-08-03', 425000.00, 'Mortgage', 'Pending'),
(5008, 1008, '2026-08-10', 625000.00, 'Bank Transfer', 'Pending');

-- 10. CHECK ALL TABLES

SHOW TABLES;


-- 11. CHECK ROWS IN EACH TABLE

SELECT * FROM Agent;
SELECT * FROM Client;
SELECT * FROM Owner;
SELECT * FROM Property;
SELECT * FROM PropertyOwner;
SELECT * FROM Viewing;
SELECT * FROM `Transaction`;
SELECT * FROM Payment;