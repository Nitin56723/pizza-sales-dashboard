/*
STEP 1: CREATE THE DATABASE
Run this command FIRST, while connected to your default 'postgres' database.
*/

CREATE DATABASE pizza_db;

/*
STEP 2: CREATE THE TABLES
Disconnect from 'postgres' and connect to your new 'pizza_db' BEFORE running this.
*/

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    date DATE,
    time TIME
);

CREATE TABLE order_details (
    order_details_id INT PRIMARY KEY,
    order_id INT,
    pizza_id VARCHAR(50),
    quantity INT
);

CREATE TABLE pizzas (
    pizza_id VARCHAR(50) PRIMARY KEY,
    pizza_type_id VARCHAR(50),
    size VARCHAR(5),
    price REAL
);

CREATE TABLE pizza_types (
    pizza_type_id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(50),
    ingredients TEXT
);

/*
STEP 3: LOAD DATA INTO TABLES
Make sure you are still connected to 'pizza_db' before running these.
IMPORTANT: You MUST change the file paths to match your local computer.
*/

COPY orders
FROM 'C:\data\pizza_sales\orders.csv'
DELIMITER ','
CSV HEADER;

COPY order_details
FROM 'C:\data\pizza_sales\order_details.csv'
DELIMITER ','
CSV HEADER;

COPY pizzas
FROM 'C:\data\pizza_sales\pizzas.csv'
DELIMITER ','
CSV HEADER;

COPY pizza_types
FROM 'C:\data\pizza_sales\pizza_types.csv'
DELIMITER ','
CSV HEADER;


/*
STEP 4: EXAMPLE ANALYSIS QUERIES
These are the queries used for the dashboard. You can run them as needed.
*/

-- Busiest Hours of the Day:
SELECT
    EXTRACT(HOUR FROM time) AS "Hour",
    COUNT(order_id) AS "Total Orders"
FROM
    orders
GROUP BY
    "Hour"
ORDER BY
    "Hour" ASC;


-- Top 5 Best-Selling Pizzas:
SELECT
    pt.name,
    SUM(od.quantity) as total_sold
FROM
    order_details AS od
JOIN
    pizzas AS p ON od.pizza_id = p.pizza_id
JOIN
    pizza_types AS pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY
    pt.name
ORDER BY
    total_sold DESC
LIMIT 5;