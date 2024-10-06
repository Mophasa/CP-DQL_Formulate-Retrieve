/* QUESTION 1 : Récupérez tous les produits. */
SELECT * FROM Products;


/* QUESTION 2 : Récupérez tous les clients. */
SELECT * FROM Customers;


/* QUESTION 3 : Récupérez toutes les commandes. */
SELECT * FROM Orders;


/* QUESTION 4 : Récupérez toutes les commandes. */
SELECT * FROM OrderDetails;


/* QUESTION 5 : Récupérez tous les types de produits. */
SELECT * FROM ProductTypes;


/* QUESTION 6 : Récupérez les noms des produits qui ont été commandés par au moins un client, ainsi que la quantité totale de chaque produit commandé. */
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


/* QUESTION 7 : Récupérez les noms des clients qui ont passé une commande chaque jour de la semaine, ainsi que le nombre total de commandes passées par chaque client. */
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


/* QUESTION 8 : Récupérez les noms des clients qui ont passé le plus de commandes, ainsi que le nombre total de commandes passées par chaque client. */
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


/* QUESTION 9 : Récupérez les noms des produits qui ont été le plus commandés, ainsi que la quantité totale de chaque produit commandé. */
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


/* QUESTION 10 : Récupérez les noms des clients qui ont passé une commande pour au moins un widget. */
SELECT DISTINCT c.CustomerName
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
WHERE p.ProductType = 'Widget';


/* QUESTION 11 : Récupérez les noms des clients qui ont passé une commande pour au moins un widget et au moins un gadget, ainsi que le coût total des widgets et gadgets commandés par chaque client. */
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


/* QUESTION 12 : Récupérez les noms des clients qui ont passé une commande pour au moins un gadget, ainsi que le coût total des gadgets commandés par chaque client. */
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


/* QUESTION 13 : Récupérez les noms des clients qui ont passé une commande pour au moins un doohickey, ainsi que le coût total des doohickeys commandés par chaque client. */
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


/* QUESTION 14 : Récupérez les noms des clients qui ont passé une commande tous les jours de la semaine, ainsi que le nombre total de commandes passées par chaque client. */
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
    d.OrderDays = 7
GROUP BY 
    c.CustomerName;


/* QUESTION 15 : Récupérez le nombre total de widgets et de gadgets commandés par chaque client, ainsi que le coût total des commandes. */
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








