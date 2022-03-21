-- POZIOM PODSTAWOWY
-- Tworzenie tabel i dodawanie wartości 

CREATE TABLE Product (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    price DECIMAL(8,2),
    amount INT,
    date DATE
);

INSERT INTO Product VALUES 
(1, 'Skarpety', 12, 27, '2011-01-07' ),
(2, 'Majtki', 30, 22, '2011-01-20' ),
(3, 'Czapka', 14.99, 1, '2011-02-24' ),
(4, 'T-shirt', 70, 9, '2011-02-04' ),
(5, 'Spodnie', 100, 4, '2011-02-01' ),
(6, 'Bluza', 130, 2, '2011-02-12' ),
(7, 'Szalik', 60.6, 3, '2011-03-15' );

SELECT * FROM Product ORDER BY price;

-- ZADANIE 1
-- Wybierz wszystkie dane produktów z tabeli Product, których cena jest większa od 25 lub liczba sztuk jest nie mniejsza niż 5

SELECT * FROM Product
WHERE price > 25 OR amount >= 5;

-- ZADANIE 2
-- Wybierz id, nazwę i cenę produktów z tabeli Product które zawierają w nazwie literę "a" i których cena jest liczbą niecałkowitą

SELECT id, name, price FROM Product
WHERE name LIKE '%a%' AND price MOD 1 != 0;

-- ZADANIE 3
-- Wybierz nazwę, cenę i ilość produktów z tabeli Product, których ilość to 3,4,5 lub 6

SELECT name, price, amount FROM Product
WHERE amount IN (3, 4, 5, 6);

-- ZADANIE 4
-- Wybierz nazwę, cenę i datę dodania produktów z tabeli Product, których dzień dodania należy do przedziału od 1 do 10

SELECT name, price, date FROM Product
WHERE DAY(date) BETWEEN 1 AND 10;

-- ZADANIE 5
-- Oblicz średnią liczbę produktów z tabeli Product, których cena jest wyższa od 40

SELECT AVG(amount) FROM Product
WHERE price > 40;

-- ZADANIE 6
-- Wybierz id i imię 4 pierwszych klientów korzystając z klauzuli LIMIT

CREATE TABLE Customer (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50),
    date DATE
);

INSERT INTO Customer VALUES
(1, 'Adam', 'Lublin','2011-02-05'),
(2, 'Monika', 'Gdynia' ,'2011-02-19'),
(3, 'Natalia', 'Zakopane' , '2011-02-23'),
(4, 'Katarzyna', 'Lublin' ,'2011-03-08'),
(5, 'Marcin', 'Warszawa', '2011-03-21');

SELECT id, name FROM Customer LIMIT 4;

-- ZADANIE 7
-- Znajdź liczbę wszystkich produktów dodanych w lutym

SELECT SUM(amount) FROM Product
WHERE MONTH(date) = 2;

    -- BONUS: Jakie to produkty?

    SELECT name, amount FROM Product 
    WHERE MONTH(date) = 2;

-- POZIOM ZAAWANSOWANY
-- Tworzenie tabel i dodawanie wartości 

CREATE TABLE Orders (
    id INT PRIMARY KEY,
    customer_id INT,
    value DECIMAL(6,2),
    date DATE
);

INSERT INTO Orders VALUES
(1, 1, 155.4, '2011-02-24' ),
(2, 1, 121.13, '2011-01-21' ),
(3, 1, 105.1, '2011-03-02' ),
(4, 2, 1211.3, '2011-10-12' ),
(5, 2, 126.73, '2011-04-21' ),
(6, 3, 1001, '2011-07-02' ),
(7, 3, 500, '2011-08-05' ),
(8, 2, 333.33, '2011-11-11' );

CREATE TABLE Order_product (
    order_id INT,
    product_id INT,
    amount INT,
    PRIMARY KEY (order_id, product_id)
);

INSERT INTO Order_product VALUES 
(1,2,2),
(1,4,1),
(2,6,1),
(2,8,1),
(2,5,2),
(3,5,1),
(3,7,2),
(4,5,1),
(4,2,1),
(4,7,2),
(5,4,1),
(6,6,1);

SELECT * FROM Order_product;

-- ZADANIE 1
-- Podaj id klientów wraz z sumaryczną wartością ich zamówień

SELECT customer_id, SUM(value) FROM Orders GROUP BY customer_id;

    -- BONUS: Jakie mają imiona?

    SELECT Orders.customer_id, Customer.name, SUM(Orders.value) 
    FROM Orders 
    JOIN Customer ON Orders.customer_id = Customer.id
    GROUP BY customer_id;

    SELECT Orders.customer_id, Customer.name, SUM(Orders.value) 
    FROM Orders, Customer 
    WHERE Orders.customer_id = Customer.id
    GROUP BY customer_id;

-- ZADANIE 2
-- Podaj id produktów z tabeli Order_product wraz z liczbą wszystkich zamówionych sztuk, jeśli liczba ta należy do zbioru {2,4}

SELECT product_id, SUM(amount) FROM Order_product
GROUP BY product_id HAVING SUM(amount) IN (2, 4);

SELECT * FROM order_product;

    -- BONUS: Jakie to produkty?
    
    SELECT Op.product_id, P.name, SUM(Op.amount) FROM Order_product AS Op, Product AS P
    WHERE Op.product_id = P.id
    GROUP BY Op.product_id HAVING SUM(Op.amount) IN (2, 4);
    
-- ZADANIE 3
-- Podaj liczbę wszystkich produktów, które zamówił klient o id 1

SELECT SUM(amount) AS LiczbaProduktowZamwPrzezKlienta_1 FROM Orders, Order_product
WHERE Order_product.order_id = Orders.id AND Orders.customer_id = 1;

-- ZADANIE 4
-- Podaj id, nazwę i ilość zamówionych produktów w zamówieniu o id 4 korzystając z aliasów dla tabel order_product i product

-- SELECT Product.id, Product.name, Order_product.amount FROM Order_product, Product
-- WHERE Order_product.order_id = 4 AND Order_product.product_id = Product.id;

SELECT P.id, P.name, Op.amount FROM Order_product AS Op, Product AS P
WHERE  Op.product_id = P.id AND Op.order_id = 4;

-- ZADANIE 5
-- Wybierz id i nazwę produktów zamówionych w zamówieniu o id 2

SELECT P.id, P.name FROM Order_product AS Op, Product AS P
WHERE  Op.product_id = P.id AND Op.order_id = 2;

-- Alternatywnie:

SELECT id, name FROM Product 
WHERE id IN (
    SELECT product_id FROM order_product 
    WHERE order_id=2
);