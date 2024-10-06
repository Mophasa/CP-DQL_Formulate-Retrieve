--- 06-10-2024 01:15:54
--- MS SQL.1
/***** ERROR ******
Error 208 Invalid object name 'Products'.
 ----- 
SELECT * FROM Products;
*****/

--- 06-10-2024 01:16:06
--- MS SQL
/***** ERROR ******
Error 1919 Column 'ProductTypeName' in table 'ProductTypes' is of a type that is invalid for use as a key column in an index.
 ----- 
CREATE TABLE Products (
    ProductID INTEGER PRIMARY KEY,
    ProductName TEXT NOT NULL,
    ProductType TEXT NOT NULL,
    Price REAL NOT NULL,
    FOREIGN KEY (ProductType) REFERENCES ProductTypes(ProductTypeName) ON DELETE CASCADE
);

CREATE TABLE Customers (
    CustomerID INTEGER PRIMARY KEY,
    CustomerName TEXT NOT NULL,
    Email TEXT NOT NULL,
    Phone TEXT NOT NULL
);

CREATE TABLE Orders (
    OrderID INTEGER PRIMARY KEY,
    CustomerID INTEGER NOT NULL,
    OrderDate DATE NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) ON DELETE CASCADE
);

CREATE TABLE OrderDetails (
    OrderDetailID INTEGER PRIMARY KEY,
    OrderID INTEGER NOT NULL,
    ProductID INTEGER NOT NULL,
    Quantity INTEGER NOT NULL CHECK (Quantity > 0),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE
);

CREATE TABLE ProductTypes (
    ProductTypeID INTEGER PRIMARY KEY,
    ProductTypeName TEXT NOT NULL UNIQUE
);
*****/

--- 06-10-2024 01:38:36
--- MS SQL
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(450) NOT NULL,
    ProductType NVARCHAR(450) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL
);

--- 06-10-2024 01:38:43
--- MS SQL
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName NVARCHAR(450) NOT NULL,
    Email NVARCHAR(450) NOT NULL UNIQUE,
    Phone NVARCHAR(20) NOT NULL
);

--- 06-10-2024 01:38:53
--- MS SQL
/***** ERROR ******
Error 102 Incorrect syntax near ')'.
 ----- 
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT NOT NULL,
    OrderDate DATE NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID);
*****/

--- 06-10-2024 01:45:10
--- MS SQL
CREATE TABLE Orders (
    OrderID INTEGER PRIMARY KEY,
    CustomerID INTEGER NOT NULL,
    OrderDate DATE NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

--- 06-10-2024 01:46:07
--- MS SQL
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

--- 06-10-2024 01:46:29
--- MS SQL
CREATE TABLE ProductTypes (
    ProductTypeID INT PRIMARY KEY,
    ProductTypeName NVARCHAR(450)
);

--- 06-10-2024 01:46:48
--- MS SQL
INSERT INTO Products (ProductID, ProductName, ProductType, Price) VALUES 
(1, 'Widget A', 'Widget', 10.00),
(2, 'Widget B', 'Widget', 15.00),
(3, 'Gadget X', 'Gadget', 20.00),
(4, 'Gadget Y', 'Gadget', 25.00),
(5, 'Doohickey Z', 'Doohickey', 30.00);

--- 06-10-2024 01:47:07
--- MS SQL
INSERT INTO Customers (CustomerID, CustomerName, Email, Phone) VALUES 
(1, 'John Smith', 'john@example.com', '123-456-7890'),
(2, 'Jane Doe', 'jane.doe@example.com', '987-654-3210'),
(3, 'Alice Brown', 'alice.brown@example.com', '456-789-0123');

--- 06-10-2024 01:47:19
--- MS SQL
INSERT INTO Orders (OrderID, CustomerID, OrderDate) VALUES 
(101, 1, '2024-05-01'),
(102, 2, '2024-05-02'),
(103, 3, '2024-05-01');

--- 06-10-2024 01:47:32
--- MS SQL
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity) VALUES 
(1, 101, 1, 2),
(2, 101, 3, 1),
(3, 102, 2, 3),
(4, 102, 4, 2),
(5, 103, 5, 1);

--- 06-10-2024 01:47:46
--- MS SQL
INSERT INTO ProductTypes (ProductTypeID, ProductTypeName) VALUES 
(1, 'Widget'),
(2, 'Gadget'),
(3, 'Doohickey');

--- 06-10-2024 01:48:39
--- MS SQL.1
ALTER TABLE Products ALTER COLUMN ProductName NVARCHAR(450);
ALTER TABLE Products ALTER COLUMN ProductType NVARCHAR(450);
ALTER TABLE Customers ALTER COLUMN CustomerName NVARCHAR(450);
ALTER TABLE Customers ALTER COLUMN Email NVARCHAR(450);
ALTER TABLE Customers ALTER COLUMN Phone NVARCHAR(450);
ALTER TABLE ProductTypes ALTER COLUMN ProductTypeName NVARCHAR(450);

--- 06-10-2024 01:54:54
--- MS SQL.2
SELECT * FROM Products;

--- 06-10-2024 01:55:04
--- MS SQL.2
SELECT * FROM Customers;

--- 06-10-2024 01:55:10
--- MS SQL.2
SELECT * FROM Orders;

--- 06-10-2024 01:55:15
--- MS SQL.2
SELECT * FROM OrderDetails;

--- 06-10-2024 01:55:19
--- MS SQL.2
SELECT * FROM ProductTypes;

--- 06-10-2024 02:00:27
--- MS SQL.2
SELECT 
    p.ProductName,
    SUM(od.Quantity) AS TotalQuantity
FROM 
    Products p
JOIN 
    OrderDetails od ON p.ProductID = od.ProductID
JOIN 
    Orders o ON od.OrderID = o.OrderID
GROUP BY 
    p.ProductName
HAVING 
    SUM(od.Quantity) > 0;

--- 06-10-2024 02:08:32
--- MS SQL.2
WITH OrderCounts AS (
    SELECT 
        c.CustomerID,
        c.CustomerName,
        COUNT(o.OrderID) AS TotalOrders,
        COUNT(DISTINCT o.OrderDate) AS DistinctOrderDays
    FROM 
        Customers c
    JOIN 
        Orders o ON c.CustomerID = o.CustomerID
    GROUP BY 
        c.CustomerID, c.CustomerName
)
SELECT 
    CustomerID,
    CustomerName,
    TotalOrders
FROM 
    OrderCounts
WHERE 
    DistinctOrderDays = 7;

--- 06-10-2024 02:16:43
--- MS SQL.2
SELECT 
    c.CustomerName, 
    COUNT(o.OrderID) AS TotalOrders
FROM 
    Customers c
JOIN 
    Orders o ON c.CustomerID = o.CustomerID
GROUP BY 
    c.CustomerID, c.CustomerName
ORDER BY 
    TotalOrders DESC;

--- 06-10-2024 02:19:25
--- MS SQL.2
SELECT 
    p.ProductName,
    SUM(od.Quantity) AS TotalQuantity
FROM 
    Products p
JOIN 
    OrderDetails od ON p.ProductID = od.ProductID
JOIN 
    Orders o ON od.OrderID = o.OrderID
GROUP BY 
    p.ProductName
ORDER BY 
    TotalQuantity DESC;

--- 06-10-2024 02:19:42
--- MS SQL.2
SELECT 
    c.CustomerName, 
    COUNT(o.OrderID) AS TotalOrders
FROM 
    Customers c
JOIN 
    Orders o ON c.CustomerID = o.CustomerID
GROUP BY 
    c.CustomerID, c.CustomerName
ORDER BY 
    TotalOrders DESC;

--- 06-10-2024 02:25:04
--- MS SQL.2
SELECT DISTINCT c.CustomerName
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
WHERE p.ProductType = 'Widget';

--- 06-10-2024 02:28:18
--- MS SQL.2
/***** ERROR ******
Error 8120 Column 'Customers.CustomerName' is invalid in the select list because it is not contained in either an aggregate function or the GROUP BY clause.
 ----- 
SELECT 
    c.CustomerName,
    SUM(od.Quantity * p.Price) AS TotalCost
FROM 
    Customers c
JOIN 
    Orders o ON c.CustomerID = o.CustomerID
JOIN 
    OrderDetails od ON o.OrderID = od.OrderID
JOIN 
    Products p ON od.ProductID = p.ProductID
WHERE 
    p.ProductType IN ('Widget', 'Gadget')
GROUP BY 
    c.CustomerID
HAVING 
    COUNT(DISTINCT p.ProductType) = 2;
*****/

--- 06-10-2024 02:34:32
--- MS SQL.2
SELECT 
    c.CustomerName,
    SUM(od.Quantity * p.Price) AS TotalCost
FROM 
    Customers c
JOIN 
    Orders o ON c.CustomerID = o.CustomerID
JOIN 
    OrderDetails od ON o.OrderID = od.OrderID
JOIN 
    Products p ON od.ProductID = p.ProductID
WHERE 
    p.ProductType IN ('Widget', 'Gadget')
GROUP BY 
    c.CustomerName
HAVING 
    COUNT(DISTINCT CASE WHEN p.ProductType = 'Widget' THEN p.ProductID END) > 0
    AND COUNT(DISTINCT CASE WHEN p.ProductType = 'Gadget' THEN p.ProductID END) > 0;

--- 06-10-2024 02:45:00
--- MS SQL.2
SELECT 
    c.CustomerName,
    SUM(od.Quantity * p.Price) AS TotalCost
FROM 
    Customers c
JOIN 
    Orders o ON c.CustomerID = o.CustomerID
JOIN 
    OrderDetails od ON o.OrderID = od.OrderID
JOIN 
    Products p ON od.ProductID = p.ProductID
WHERE 
    p.ProductType = 'Gadget'
GROUP BY 
    c.CustomerName
HAVING 
    SUM(od.Quantity) > 0;

--- 06-10-2024 02:48:49
--- MS SQL.2
SELECT 
    c.CustomerName,
    SUM(od.Quantity * p.Price) AS TotalCost
FROM 
    Customers c
JOIN 
    Orders o ON c.CustomerID = o.CustomerID
JOIN 
    OrderDetails od ON o.OrderID = od.OrderID
JOIN 
    Products p ON od.ProductID = p.ProductID
WHERE 
    p.ProductType = 'Doohickey'
GROUP BY 
    c.CustomerName
HAVING 
    SUM(od.Quantity * p.Price) > 0;

--- 06-10-2024 02:56:10
--- MS SQL.2
WITH DailyOrders AS (
    SELECT 
        CustomerID,
        COUNT(DISTINCT OrderDate) AS OrderDays
    FROM 
        Orders
    GROUP BY 
        CustomerID
)

SELECT 
    c.CustomerName,
    COUNT(o.OrderID) AS TotalOrders
FROM 
    Customers c
JOIN 
    Orders o ON c.CustomerID = o.CustomerID
JOIN 
    DailyOrders d ON c.CustomerID = d.CustomerID
WHERE 
    d.OrderDays = 7  -- Assuming we are checking for orders across a week (7 days)
GROUP BY 
    c.CustomerName;

--- 06-10-2024 03:17:21
--- MS SQL.2
SELECT 
    c.CustomerName,
    SUM(od.Quantity) AS TotalItems,
    SUM(od.Quantity * p.Price) AS TotalCost
FROM 
    Customers c
JOIN 
    Orders o ON c.CustomerID = o.CustomerID
JOIN 
    OrderDetails od ON o.OrderID = od.OrderID
JOIN 
    Products p ON od.ProductID = p.ProductID
WHERE 
    p.ProductType IN ('Widget', 'Gadget')
GROUP BY 
    c.CustomerName;

