/* TABLE PRODUIT */
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(450) NOT NULL,
    ProductType NVARCHAR(450) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL
);

/* TABLE CLIENT */
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName NVARCHAR(450) NOT NULL,
    Email NVARCHAR(450) NOT NULL UNIQUE,
    Phone NVARCHAR(20) NOT NULL
);

/* TABLE COMMANDES */
CREATE TABLE Orders (
    OrderID INTEGER PRIMARY KEY,
    CustomerID INTEGER NOT NULL,
    OrderDate DATE NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

/* TABLE DÉTAILS COMMANDE */
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

/* TABLE TYPES DE PRODUIT */
CREATE TABLE ProductTypes (
    ProductTypeID INT PRIMARY KEY,
    ProductTypeName NVARCHAR(450)
);

/* INSERTION DES DONNÉES */

/* INSERTION DES DONNÉES DANS PRODUITS */
INSERT INTO Products (ProductID, ProductName, ProductType, Price) VALUES 
(1, 'Widget A', 'Widget', 10.00),
(2, 'Widget B', 'Widget', 15.00),
(3, 'Gadget X', 'Gadget', 20.00),
(4, 'Gadget Y', 'Gadget', 25.00),
(5, 'Doohickey Z', 'Doohickey', 30.00);

/* INSERTION DES DONNÉES DANS CLIENTS */
INSERT INTO Customers (CustomerID, CustomerName, Email, Phone) VALUES 
(1, 'John Smith', 'john@example.com', '123-456-7890'),
(2, 'Jane Doe', 'jane.doe@example.com', '987-654-3210'),
(3, 'Alice Brown', 'alice.brown@example.com', '456-789-0123');

/* INSERTION DES DONNÉES DANS COMMANDES */
INSERT INTO Orders (OrderID, CustomerID, OrderDate) VALUES 
(101, 1, '2024-05-01'),
(102, 2, '2024-05-02'),
(103, 3, '2024-05-01');

/* INSERTION DES DONNÉES DANS DÉTAILS DE COMMANDE */
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity) VALUES 
(1, 101, 1, 2),
(2, 101, 3, 1),
(3, 102, 2, 3),
(4, 102, 4, 2),
(5, 103, 5, 1);

/* INSERTION DES DONNÉES DANS TYPES DE PRODUITS */
INSERT INTO ProductTypes (ProductTypeID, ProductTypeName) VALUES 
(1, 'Widget'),
(2, 'Gadget'),
(3, 'Doohickey');



