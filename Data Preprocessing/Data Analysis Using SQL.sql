SELECT * FROM sales.customers;

SELECT * FROM sales.date;

SELECT * FROM sales.markets;

SELECT * FROM sales.products;

SELECT * FROM sales.transactions;


-- Rename custmer_name column in Customer table
ALTER TABLE sales.customers RENAME column custmer_name to customer_name;


-- Finding the market zones
SELECT DISTINCT sales.markets.markets_name 
FROM sales.markets;


-- Calculating the Total Revenue 
SELECT SUM(sales_amount)
FROM sales.transactions;

-- Calculating Revenue By Year
SELECT d.year AS Year, SUM(t.sales_amount) AS Revenue
FROM sales.transactions t JOIN sales.date d
ON t.order_date = d.date
GROUP BY d.year;


-- Calculating Sales Qty By Year
SELECT d.year AS Year, SUM(t.sales_qty) AS 'Sold Units'
FROM sales.transactions t JOIN sales.date d
ON t.order_date = d.date
GROUP BY d.year;

-- Calculating Revenue By Cities
SELECT m.markets_name AS City, SUM(t.sales_amount) AS Revenue
FROM sales.transactions t JOIN sales.markets m
ON t.market_code = m.markets_code
GROUP BY m.markets_name;


-- Calculating Total Sales Qty by Cities
SELECT m.markets_name AS City, SUM(t.sales_qty) AS 'Sales Qty'
FROM sales.transactions t JOIN sales.markets m
ON t.market_code = m.markets_code
GROUP BY m.markets_name;

-- Calculating Revenue By Cities on Year by Year
SELECT m.markets_name AS City, SUM(t.sales_amount) AS Revenue, d.year AS Year
FROM sales.transactions t JOIN sales.markets m
ON t.market_code = m.markets_code
JOIN sales.date d
ON t.order_date = d.date
GROUP BY m.markets_name, d.year
ORDER BY d.year ASC;


-- Calculating Total Sales Qty by Cities
SELECT m.markets_name AS City, SUM(t.sales_qty) AS 'Sales Qty'
FROM sales.transactions t JOIN sales.markets m
ON t.market_code = m.markets_code
GROUP BY m.markets_name;

-- Calculating Sales Qty By Cities on Year by Year
SELECT m.markets_name AS City, SUM(t.sales_qty) AS 'Sold Units', d.year AS Year
FROM sales.transactions t JOIN sales.markets m
ON t.market_code = m.markets_code
JOIN sales.date d
ON t.order_date = d.date
GROUP BY m.markets_name, d.year
ORDER BY d.year ASC, SUM(t.sales_qty) DESC;


-- Calculating Revenue By Cities on 2020
SELECT m.markets_name AS City, SUM(t.sales_amount) AS Revenue, d.year AS Year
FROM sales.transactions t JOIN sales.markets m
ON t.market_code = m.markets_code
JOIN sales.date d
ON t.order_date = d.date
WHERE d.year = 2020
GROUP BY m.markets_name, d.year;


-- Calculating Sales Qty By Cities on 2020
SELECT m.markets_name AS City, SUM(t.sales_qty) AS 'Sold Units', d.year AS Year
FROM sales.transactions t JOIN sales.markets m
ON t.market_code = m.markets_code
JOIN sales.date d
ON t.order_date = d.date
WHERE d.year = 2020
GROUP BY m.markets_name, d.year;


-- Calculating Revenue by Each Customer
SELECT c.customer_name AS Customer, SUM(t.sales_amount) AS Revenue
FROM sales.transactions t JOIN sales.customers c
ON t.customer_code = c.customer_code
GROUP BY c.customer_name;


-- Calculating Revenue by Each Customer on Year by Year
SELECT c.customer_name AS Customer, SUM(t.sales_amount) AS Revenue, d.year as Year
FROM sales.transactions t JOIN sales.customers c
ON t.customer_code = c.customer_code
JOIN sales.date d
ON t.order_date = d.date
GROUP BY c.customer_name, d.year
ORDER BY d.year ASC, SUM(t.sales_amount) DESC;


-- Calculating Sales Qty by Each Customer
SELECT c.customer_name AS Customer, SUM(t.sales_qty) AS 'Sold Units'
FROM sales.transactions t JOIN sales.customers c
ON t.customer_code = c.customer_code
GROUP BY c.customer_name;


-- Calculating Sales Qty by Each Customer on Year by Year
SELECT c.customer_name AS Customer, SUM(t.sales_qty) AS 'Sold Units', d.year AS Year
FROM sales.transactions t JOIN sales.customers c
ON t.customer_code = c.customer_code
JOIN sales.date d 
ON t.order_date = d.date
GROUP BY c.customer_name, d.year
ORDER BY d.year ASC,  SUM(t.sales_qty) DESC;


-- Top 5 Customers by Revenue
SELECT c.customer_name AS 'Customer Code', SUM(t.sales_amount) AS Revenue
FROM sales.transactions t JOIN sales.customers c
ON t.customer_code = c.customer_code
GROUP BY c.customer_name
ORDER BY SUM(t.sales_amount) DESC
LIMIT 5;


-- Top 5 Products by Revenue
SELECT p.product_code AS 'Product Code', SUM(t.sales_amount) AS Revenue
FROM sales.transactions t JOIN sales.products p
ON t.product_code = p.product_code
GROUP BY p.product_code
ORDER BY SUM(t.sales_amount) DESC
LIMIT 5;


-- Top Product by Revenue on Year by Year
SELECT p.product_code AS 'Product Code', SUM(t.sales_amount) AS Revenue, d.year AS Year
FROM sales.transactions t JOIN sales.products p
ON t.product_code = p.product_code
JOIN sales.date d
ON t.order_date = d.date
GROUP BY p.product_code, d.year
ORDER BY SUM(t.sales_amount) DESC, d.year ASC;