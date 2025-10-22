/* 
Retail Sales Data Analysis & Cleaning
Author: Ali Kamal Abu Salah
Date: October 2025
Tools: SQL
Description: Data cleaning and exploration for retail sales dataset
*/

-- SQL Retail Sales Analysis - p1 
Create Database sql_project_p2;

--(A)- Create Table 
drop table if exists retail_sales;
CREATE TABLE retail_sales 
            (
                transaction_id INT PRIMARY KEY,
                sale_date DATE,
                sale_time TIME,
                customer_id INT,
                gender VARCHAR(15),
                age INT,
                category VARCHAR(15),
                quantity INT,
                price_per_unit Float,
                cogs Float,
                total_sale Float
);

-- (B)- Exploration Data
SELECT * FROM retail_sales
limit 10 ;

-- Number of records, clients, and categories
SELECT 
    COUNT(*) AS total_records,
    COUNT(DISTINCT customer_id) AS unique_customers,
    COUNT(DISTINCT category) AS unique_categories
FROM retail_sales;

-- Number of null missing price_per_unit, quantity, and total_sale
SELECT 
    SUM(CASE WHEN price_per_unit IS NULL THEN 1 ELSE 0 END) AS missing_price,
    SUM(CASE WHEN quantity IS NULL THEN 1 ELSE 0 END) AS missing_quantity,
    SUM(CASE WHEN total_sale IS NULL THEN 1 ELSE 0 END) AS missing_total_sale
FROM retail_sales;


SELECT 
      COUNT(DISTINCT customer_id) AS unique_customers 
FROM retail_sales;

-- Unique values
SELECT DISTINCT category 
FROM retail_sales;


-- Delete invalid records
Delete FROM retail_sales
WHERE transaction_id IS NULL 
   OR sale_date IS NULL 
   OR price_per_unit IS NULL;


--(C)- Descriptive Analysis

-- 1-Total sales and profits
SELECT 
    ROUND(SUM(total_sale)::numeric, 2) AS total_revenue,
    ROUND(SUM(total_sale - cogs)::numeric, 2) AS total_profit,
    ROUND(AVG(total_sale)::numeric, 2) AS avg_sale_value
FROM retail_sales;

--2-Sales by type
SELECT category, SUM(price_per_unit * quantity) AS category_sales
FROM retail_sales
GROUP BY category
ORDER BY category_sales Asc;

--3- Monthly sales
SELECT 
    DATE_TRUNC('month', sale_date) AS month,
    ROUND(SUM(total_sale)::numeric, 2) AS monthly_sales
FROM retail_sales
WHERE total_sale IS NOT NULL
GROUP BY DATE_TRUNC('month', sale_date)
ORDER BY month;

-- 4- Daily sales 
SELECT sale_date, SUM(price_per_unit * quantity) AS daily_sales
FROM retail_sales
GROUP BY sale_date
ORDER BY sale_date;

--(D)- Deep Insights
-- 1- Sales by category
-- 
SELECT 
    category,
    SUM(total_sale) AS total_sales,
    SUM(total_sale - cogs) AS profit,
    ROUND(AVG(total_sale)::numeric, 2) AS avg_transaction_value
FROM retail_sales
GROUP BY category
ORDER BY total_sales DESC;

-- 2- Top Customers
-- Objective: Identify the most valuable customers
SELECT 
    customer_id,
    COUNT(transaction_id) AS transactions,
    ROUND(SUM(total_sale)::numeric, 2) AS total_spent
FROM retail_sales
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 10;

-- 3- Gender Analysis
-- Objective: Is there a difference between male and female spending?
SELECT 
    gender,
    SUM(total_sale) AS total_sales,
    COUNT(DISTINCT customer_id) AS num_customers,
    ROUND(AVG(total_sale)::numeric, 2) AS avg_sale
FROM retail_sales
GROUP BY gender;

--4- Sales distribution by age group
SELECT 
    CASE 
        WHEN age BETWEEN 10 AND 19 THEN '10s'
        WHEN age BETWEEN 20 AND 29 THEN '20s'
        WHEN age BETWEEN 30 AND 39 THEN '30s'
        WHEN age BETWEEN 40 AND 49 THEN '40s'
        WHEN age BETWEEN 50 AND 59 THEN '50s'
        ELSE '60+'
    END AS age_group,
    SUM(total_sale) AS total_sales,
    COUNT(*) AS transactions
FROM retail_sales
GROUP BY 
    CASE 
        WHEN age BETWEEN 10 AND 19 THEN '10s'
        WHEN age BETWEEN 20 AND 29 THEN '20s'
        WHEN age BETWEEN 30 AND 39 THEN '30s'
        WHEN age BETWEEN 40 AND 49 THEN '40s'
        WHEN age BETWEEN 50 AND 59 THEN '50s'
        ELSE '60+'
    END
ORDER BY total_sales DESC;

--(E)-Time Analysis
-- 1- Sales by hour
-- Knowing peak shopping hours (Peak Hours)
SELECT 
    EXTRACT(HOUR FROM sale_time) AS hour_of_day,
    SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY EXTRACT(HOUR FROM sale_time)
ORDER BY total_sales DESC;

--(F)- Key Performance Indicators (KPIs) 
-- 1- Calculating the profitability rate
SELECT 
    ROUND((SUM(total_sale - cogs)::numeric / SUM(total_sale)::numeric) * 100, 2) AS profit_margin_percent
FROM retail_sales;

-- 2- Number of operations per category
SELECT 
    category,
    COUNT(transaction_id) AS num_transactions,
    ROUND((SUM(total_sale)::numeric / COUNT(transaction_id)), 2) AS avg_per_transaction
FROM retail_sales
GROUP BY category
ORDER BY avg_per_transaction DESC;

--(G)- Additional analyses 
-- 1 - New customers versus old customers
-- Objective:Understanding customer loyalty
SELECT 
    customer_id,
    MIN(sale_date) AS first_purchase,
    MAX(sale_date) AS last_purchase,
    (MAX(sale_date) - MIN(sale_date)) AS active_days,
    SUM(total_sale) AS total_spent
FROM retail_sales
GROUP BY customer_id
ORDER BY total_spent DESC;
