SHOW TABLES;

DESCRIBE customers;
SELECT COUNT(CustomerID) FROM customers;
SELECT * FROM customers LIMIT 10;

DESCRIBE products;
SELECT COUNT(ProductID) FROM products;
SELECT * FROM products;

-- 1. Write a query to get Product name and quantity/unit. Go to the editor

SELECT ProductName, QuantityPerUnit FROM products;

-- 2. Write a query to get current Product list (Product ID and name). Go to the editor

SELECT ProductID, ProductName FROM products
WHERE Discontinued = 0;

-- 3. Write a query to get discontinued Product list (Product ID and name). Go to the editor

SELECT ProductID, ProductName FROM products
WHERE Discontinued = 1;

-- 4. Write a query to get most expense and least expensive Product list (name and unit price). Go to the editor

SELECT ProductName, UnitPrice FROM products
ORDER BY UnitPrice DESC LIMIT 1;

SELECT ProductName, UnitPrice FROM products
ORDER BY UnitPrice ASC LIMIT 1;

-- 5. Write a query to get Product list (id, name, unit price) where current products cost less than $20. Go to the editor

SELECT ProductID, ProductName, UnitPrice FROM products
WHERE UnitPrice < 20;
-- ORDER BY UnitPrice DESC;

-- 6. Write a query to get Product list (id, name, unit price) where products cost between $15 and $25. Go to the editor

SELECT ProductID, ProductName, UnitPrice FROM products
WHERE UnitPrice BETWEEN 15 AND 25;
-- ORDER BY UnitPrice DESC;

-- 7. Write a query to get Product list (name, unit price) of above average price. Go to the editor

-- SELECT AVG(UnitPrice) FROM products;

SELECT ProductID, ProductName, UnitPrice FROM products
WHERE UnitPrice > (SELECT AVG(UnitPrice) FROM products);

-- 8. Write a query to get Product list (name, unit price) of ten most expensive products. Go to the editor

SELECT ProductName, UnitPrice FROM products
ORDER BY UnitPrice DESC LIMIT 10;

-- 9. Write a query to count current and discontinued products. Go to the editor

SELECT COUNT(ProductID) FROM products
GROUP BY Discontinued;

-- 10. Write a query to get Product list (name, units on order , units in stock) of stock is less than the quantity on order. Go to the editor

SELECT ProductName, UnitsOnOrder, UnitsInStock FROM products
WHERE ((Discontinued=False) AND (UnitsInStock< UnitsOnOrder));

-- Order Subtotals
-- For each order, calculate a subtotal for each Order (identified by OrderID). This is a simple query using GROUP BY to aggregate data for each order.

DESCRIBE `order details`;

SELECT OrderID, FORMAT(SUM(UnitPrice * Quantity * (1-Discount)), 2) AS Subtotal
FROM `order details`
GROUP BY OrderID;

-- Employee Sales by Country
-- For each employee, get their sales amount, broken down by country name.

SHOW TABLES;
SELECT * FROM employees;

-- SELECT emp.LastName, emp.FirstName, sum() FROM employees emp, orders ord;