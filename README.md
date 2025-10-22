# Retail Sales Analysis SQL Project

## Project Overview
**Project Title:** Retail Sales Analysis  
**Author:** Ali Kamal Abu Salah  
**Date:** October 2025  
**Level:** Beginner  
**Database:** `p1_retail_db` (pgAdmin4)  

This project demonstrates a **complete workflow of retail sales analysis using SQL**, including data cleaning, exploration, descriptive and deep analysis, and calculation of business KPIs.

---

## Project Description
The dataset contains transactional retail sales information, including:

- `transaction_id`, `sale_date`, `sale_time`  
- `customer_id`, `gender`, `age`  
- `category`, `quantity`, `price_per_unit`, `cogs`, `total_sale`

The main goals:

1. Clean and preprocess raw data.  
2. Explore sales patterns and customer behavior.  
3. Generate descriptive and deep insights.  
4. Calculate KPIs for decision-making.  
5. Analyze trends over time and customer loyalty.

---

## Tools & Technologies
- **SQL** (PostgreSQL)  
- **pgAdmin4**  
- Data cleaning, exploration, and analysis techniques  

---

## Analysis Objectives
1. **Data Cleaning & Preparation**
   - Remove missing or invalid values (`NULL` or incorrect transactions).
   - Ensure data accuracy before starting the analysis.

2. **Exploratory Data Analysis (EDA)**
   - Understand the dataset: total transactions, unique customers, and product categories.
   - Identify initial patterns and key characteristics of the data.

3. **Sales Analysis by Category**
   - Identify top-selling and least-selling products.
   - Analyze revenue and profit per product category.

4. **Customer Behavior Analysis**
   - Identify top customers based on total spending.
   - Explore spending patterns by gender and age groups.
   - Analyze customer loyalty (new vs. returning customers).

5. **Time-based Analysis**
   - Determine peak sales hours, days, and months.
   - Discover seasonal and daily purchase patterns.

6. **Key Performance Indicators (KPIs)**
   - Calculate profit margins.
   - Determine average transaction value per category.
   - Count transactions per category and identify the most profitable ones.

7. **Provide Actionable Insights**
   - Support data-driven business decisions.
   - Help management improve sales and increase profitability.

---

## Data Cleaning & Preprocessing
- Count total records, unique customers, and product categories  
- Handle missing values for `price_per_unit`, `quantity`, and `total_sale`  
- Delete invalid records with null transaction IDs, sale dates, or prices  

---

## Exploratory Data Analysis (EDA)
- View sample records  
- Identify null values and unique values for categories  
- Understand basic structure of dataset  

---

## Descriptive Analysis
- **Total revenue, total profits, and average transaction value**  
- **Sales by category**  
- **Monthly and daily sales trends**  

---

## Deep Insights
1. **Category Analysis:** Total sales, profits, and average transaction value  
2. **Top Customers:** Most valuable customers by total spending  
3. **Gender Analysis:** Spending patterns by gender  
4. **Sales by Age Group:** Purchase distribution across age ranges  

---

## Time-based Analysis
- **Peak Hours:** Determine busiest shopping hours  
- **Monthly & Daily Trends:** Understand seasonality and patterns  

---

## Key Performance Indicators (KPIs)
- **Profit Margin:** `(total_sales - total_cogs) / total_sales`  
- **Average transaction value per category**  
- **Number of transactions per category**

---

## Customer Loyalty & Additional Analysis
- Identify new vs. returning customers  
- Analyze customer lifecycle and total spending  

---

## Example SQL Queries
```sql
-- Total revenue and profit
SELECT ROUND(SUM(total_sale)::numeric, 2) AS total_revenue,
       ROUND(SUM(total_sale - cogs)::numeric, 2) AS total_profit
FROM retail_sales;

-- Top 10 customers by total spending
SELECT customer_id, COUNT(transaction_id) AS transactions,
       ROUND(SUM(total_sale)::numeric, 2) AS total_spent
FROM retail_sales
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 10;

-- Sales by hour of the day
SELECT EXTRACT(HOUR FROM sale_time) AS hour_of_day,
       SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY EXTRACT(HOUR FROM sale_time)
ORDER BY total_sales DESC;
```

---

## How to Use
1. Clone the repository  
2. Load the dataset from `data/retail_sales.csv` into PostgreSQL (`p1_retail_db`)  
3. Execute `scripts/retail_sales_analysis.sql` in **pgAdmin4**  
4. Explore insights, KPIs, and results  

---

## Results
Optional screenshots or exported tables can be found in `results/screenshots/`.

---

## Conclusion
This project demonstrates a **complete end-to-end SQL workflow for retail sales analysis**, from raw data cleaning to actionable business insights, providing a solid foundation in SQL and data analytics.


