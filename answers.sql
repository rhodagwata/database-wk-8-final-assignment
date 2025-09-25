--- Building a Complete Database Management System for E-Commerce

-- 1. Creating a Database
CREATE DATABASE IF NOT EXISTS ECommerceDB;
USE ECommerceDB;

-- 2. Creating Customers Table
CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Phone VARCHAR(20),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. Creating CustomerProfiles Table (One-to-One with Customers)
CREATE TABLE CustomerProfiles (
    ProfileID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT UNIQUE,  -- ensures One-to-One
    Address VARCHAR(255),
    DateOfBirth DATE,
    LoyaltyPoints INT DEFAULT 0,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- 4.Creating Products Table
CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Description TEXT,
    Price DECIMAL(10,2) NOT NULL,
    Stock INT DEFAULT 0,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 5.Creating Orders Table (One-to-Many: Customer → Orders)
CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT NOT NULL,
    OrderDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Status ENUM('Pending', 'Shipped', 'Delivered', 'Cancelled') DEFAULT 'Pending',
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- 6. Creating OrderItems Table (Many-to-Many between Orders and Products)
CREATE TABLE OrderItems (
    OrderItemID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL CHECK (Quantity > 0),
    Price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    UNIQUE (OrderID, ProductID)
);
