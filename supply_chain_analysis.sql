CREATE database supply_chain_analysis;

USE supply_chain_analysis;
LOAD DATA LOCAL INFILE 'C:/Users/digital/Documents/SUPPLY CHAIN ANALYSIS PROJECT/supply_chain_cleaned_dataset.csv'
INTO TABLE supply_chain_analysis.supply_chain_cleaned_dataset
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

SHOW VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 1;
LOAD DATA LOCAL INFILE 'C:/Users/digital/Documents/SUPPLY CHAIN ANALYSIS PROJECT/supply_chain_cleaned_dataset.csv'
INTO TABLE supply_chain_analysis.supply_chain_cleaned_dataset
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

SELECT @@local_infile;
SELECT COUNT(*)


FROM supply_chain_analysis.supply_chain_cleaned_dataset;
DESCRIBE supply_chain_analysis.supply_chain_cleaned_dataset;
select * from supply_chain_analysis.supply_chain_cleaned_dataset;


-- PART 1 : OVERALL BUSINESS PERFORMANCE

-- Q1. WHAT ARE THE DIFFERENT DELIVERY STATUSES, AND HOW MANY ORDERS ARE IN EACH STATUS?
select `delivery status`, count(*) as "total orders"
from supply_chain_analysis.supply_chain_cleaned_dataset
group by `delivery status`
order by "total orders" DESC;

-- Q2. HOW MANY TOTAL ORDERS ARE PRESENT IN THE DATASET?
SELECT COUNT(`order id`) AS "total orders"
FROM supply_chain_analysis.supply_chain_cleaned_dataset;

-- Q3. HOW MANY UNIQUE CUSTOMERS ARE THERE?
SELECT COUNT(DISTINCT `Customer Id`) AS unique_customers
FROM supply_chain_analysis.supply_chain_cleaned_dataset;

-- Q4. WHAT IS THE TOTAL SALES/REVENUE GENERATED? 
SELECT ROUND(SUM(`Sales per customer`), 2) AS "Total_Sales"
FROM supply_chain_analysis.supply_chain_cleaned_dataset;


-- Q5. WHAT IS THE AVERAGE SALES PER CUSTOMER?
SELECT ROUND(AVG(`Sales per customer`), 2) AS "Average Sales per Customer"
FROM supply_chain_analysis.supply_chain_cleaned_dataset;

-- Q6. WHAT IS THE TOTAL PROFIT GENERATED?
SELECT ROUND(SUM(`benefit per order`), 2) AS "Total_Profit"
FROM supply_chain_analysis.supply_chain_cleaned_dataset;


-- Q7. WHAT IS THE AVERAGE BENEFIT/PROFIT PER ORDER?
SELECT ROUND(AVG(`benefit per order`), 2) AS "Averge benefit per order"
FROM supply_chain_analysis.supply_chain_cleaned_dataset;

-- PART 2: PRODUCT & CATEGORY ANALYSIS
select * from supply_chain_analysis.supply_chain_cleaned_dataset;

-- Q8. WHICH PRODUCT CATEGORY GENERATES THE HIGHEST SALES?
SELECT `Category name`,round(SUM(`sales per customer`), 2) AS "Total_Sales"
FROM supply_chain_analysis.supply_chain_cleaned_dataset
GROUP BY `category name`
ORDER BY round(SUM(`sales per customer`), 2) DESC;

-- Q9. WHICH PRODUCT CATEGORY GENERATES THE HIGHEST BENEFIT/REVENUE?
SELECT `product name`,round(SUM(`benefit per order`), 2) AS "Total Benefit/Revenue"
FROM supply_chain_analysis.supply_chain_cleaned_dataset
GROUP BY  `product name`
ORDER BY round(SUM(`benefit per order`), 2) DESC;

-- Q10. WHAT ARE THE TOP 10 PRODUCTS BY SALES?
SELECT `product name`, ROUND(SUM(`sales per customer`), 2) AS "Total_Sales"
FROM supply_chain_analysis.supply_chain_cleaned_dataset
GROUP BY  `product name`
ORDER BY ROUND(SUM(`sales per customer`), 2) DESC LIMIT 10;

-- Q11. WHAT ARE THE TOP 10 PRODUCTS BY PROFIT?
SELECT `product name`, ROUND(SUM(`benefit per order`), 2) AS "Total_Profit"
FROM supply_chain_analysis.supply_chain_cleaned_dataset
GROUP BY  `product name`
ORDER BY ROUND(SUM(`benefit per order`), 2) DESC LIMIT 10;

-- Q12. WHICH PRODUCTS HAVE THE HIGHEST QUANTITY SOLD?
SELECT `product name`, ROUND(SUM(`order item quantity`), 2) AS "Quantity_Sold"
FROM supply_chain_analysis.supply_chain_cleaned_dataset
GROUP BY `product name`
ORDER BY ROUND(SUM(`order item quantity`), 2) DESC;

-- PART 3: CUSTOMER ANALYSIS
select * from supply_chain_analysis.supply_chain_cleaned_dataset;

-- Q13. WHAT ARE THE TOP 10 CUSTOMERS BASED ON TOTAL SALES?
SELECT `customer id`, ROUND(SUM(`sales per customer`), 2) AS "Total_sales"
FROM supply_chain_analysis.supply_chain_cleaned_dataset
GROUP BY `customer id`
ORDER BY ROUND(SUM(`sales per customer`), 2) DESC 
LIMIT 10;

-- Q14. WHICH CUSTOMER SEGMENT GENERATES THE MOST SALES?
SELECT `customer segment`, ROUND(SUM(`sales per customer`), 2) AS "Total_sales"
FROM supply_chain_analysis.supply_chain_cleaned_dataset
GROUP BY `customer segment`
ORDER BY ROUND(SUM(`sales per customer`), 2) DESC LIMIT 10;


 -- Q15. HOW MANY CUSTOMERS BELONG TO EACH CUSTOMER SEGMENT?
 SELECT `customer segment`, COUNT(DISTINCT `customer id`) AS "No. of customers"
 FROM supply_chain_analysis.supply_chain_cleaned_dataset
 GROUP BY `customer segment`
 ORDER BY COUNT(*) DESC;

-- Q16. WHAT IS THE AVERAGE SALES PER CUSTOMER FOR EACH CUSTOMER SEGMENT?
 SELECT `customer segment`, ROUND(AVG(`sales per customer`),2) AS Average_Sales
 FROM supply_chain_analysis.supply_chain_cleaned_dataset
 GROUP BY `customer segment`
 ORDER BY Average_Sales DESC;

-- PART 4: SHIPPING AND DELIVERY ANALYSIS
select * from supply_chain_analysis.supply_chain_cleaned_dataset;
 
 -- Q17. WHAT IS THE AVERAGE ACTUAL SHIPPING TIME?
 SELECT ROUND(AVG(`Days for shipping (real)`), 2) AS Average_Actual_shipping_time
 FROM supply_chain_analysis.supply_chain_cleaned_dataset;
 
 -- Q18. WHAT IS THE AVERAGE SCHEDULED SHIPPING TIME?
  SELECT ROUND(AVG(`Days for shipment (scheduled)`), 2) AS Average_scheduled_shipping_time
 FROM supply_chain_analysis.supply_chain_cleaned_dataset;
 
 -- Q19. WHICH SHIPPING MODE IS USED THE MOST?
 SELECT `shipping mode`,(COUNT(`shipping mode`)) AS total_orders
 FROM supply_chain_analysis.supply_chain_cleaned_dataset
GROUP BY `shipping mode`
ORDER BY total_orders DESC;


 -- Q20. WHICH SHIPPING MODE HAS THE HIGHEST AVERAGE SHIPPING TIME?
 SELECT `shipping mode`, ROUND(AVG(`days for shipping (real)`),2) AS Average_Shipping_Time
 FROM supply_chain_analysis.supply_chain_cleaned_dataset
 GROUP BY `shipping mode`
 ORDER BY Average_Shipping_Time DESC;
 
-- Q21. HOW MANY ORDERS WHERE DEIVERED LATE?
 SELECT `delivery status`, COUNT(*) AS Number_of_Deliveries
 FROM supply_chain_analysis.supply_chain_cleaned_dataset
 WHERE `delivery status` = "Late Delivery";
 
 -- Q22. WHICH SHIPPING MODE HAS THE HIGHEST NUMBER OF DELVERIES?
SELECT `shipping mode`, COUNT(*) AS Number_of_Deliveries
FROM supply_chain_analysis.supply_chain_cleaned_dataset
GROUP BY `shipping mode`
ORDER BY Number_of_Deliveries DESC;

-- PART 5: REGIONAL ANALYSIS
select * from supply_chain_analysis.supply_chain_cleaned_dataset;

-- Q23. WHICH COUNTRY GENERATES THE HIGHEST SALES?
SELECT `order country`, ROUND(SUM(`sales per customer`),2) AS Sales
FROM supply_chain_analysis.supply_chain_cleaned_dataset
GROUP BY `order country`
ORDER BY Sales DESC
LIMIT 10;

-- Q24. WHICH REGION GENERATES THE HIGHEST SALES?
SELECT `order region`, ROUND(SUM(`sales per customer`),2) AS Sales
FROM supply_chain_analysis.supply_chain_cleaned_dataset
GROUP BY `order region`
ORDER BY Sales DESC
LIMIT 10;

-- Q25. WHICH STATE GENERATES THE HIGHEST SALES?
SELECT `order state`, ROUND(SUM(`sales per customer`),0) AS Sales
FROM supply_chain_analysis.supply_chain_cleaned_dataset
GROUP BY `order state`
ORDER BY Sales DESC
LIMIT 10;

-- Q26. WHICH CITY GENERTAES THE HIGHEST SALES?
SELECT `order city`, ROUND(SUM(`sales per customer`),0) AS Sales
FROM supply_chain_analysis.supply_chain_cleaned_dataset
GROUP BY `order city`
ORDER BY Sales DESC
LIMIT 10;

-- PART 6: CUSTOMER/PRODUCT INSIGHTS
select * from supply_chain_analysis.supply_chain_cleaned_dataset;

-- Q27. WHAT ARE TOP 3 PRODUCTS IN EACH CATEGORY BASED ON SALES?
WITH product_sales AS(
SELECT `category name`, `product name`, ROUND(SUM(`sales per customer`), 2) AS Sales
FROM supply_chain_analysis.supply_chain_cleaned_dataset
GROUP BY `category name`, `product name`
),
ranked_product AS(
SELECT `category name`, `product name`, Sales,
		ROW_NUMBER() OVER (PARTITION BY `category name` ORDER BY Sales DESC) AS product_rank
        FROM product_sales
)
SELECT `category name`, `product name`, Sales, product_rank
FROM ranked_product
WHERE product_rank <= 3
ORDER BY `category name`, product_rank;

-- Q28. FIND THE HIHGEST-SELLING PRODUCT IN EACH CATEGORY
WITH product_sales AS (
    SELECT `category name`,`product name`,
        ROUND(SUM(`sales per customer`), 2) AS total_sales
    FROM supply_chain_analysis.supply_chain_cleaned_dataset
    GROUP BY `category name`, `product name`
),
ranked_products AS (
    SELECT `category name`,`product name`,total_sales,
        ROW_NUMBER() OVER (PARTITION BY `category name`ORDER BY total_sales DESC) AS product_rank
    FROM product_sales
)
SELECT `category name`,`product name`,total_sales
FROM ranked_products
WHERE product_rank = 1
ORDER BY total_sales DESC;

-- Q29. RANK THE REGIONS BASED ON TOTAL SALES
SELECT `order region`, ROUND(SUM(`sales per customer`),2) AS Total_Sales,
		RANK() OVER (ORDER BY SUM(`sales per customer`) DESC) AS region_rank
FROM supply_chain_analysis.supply_chain_cleaned_dataset
GROUP BY `order region`
ORDER BY region_rank;

-- Q30. FIND CUSTOMERS WHOSE SALES ARE HIGHER THEN THE AVERAGE CUSTOMER SALES
SELECT `Customer Id`,ROUND(SUM(`Sales per customer`), 2) AS total_sales
FROM supply_chain_analysis.supply_chain_cleaned_dataset
GROUP BY `Customer Id`
HAVING SUM(`Sales per customer`) > (
    SELECT AVG(customer_sales)
    FROM (SELECT `Customer Id`,SUM(`Sales per customer`) AS customer_sales
        FROM supply_chain_analysis.supply_chain_cleaned_dataset
        GROUP BY `Customer Id`) AS customer_totals)
ORDER BY total_sales DESC;

 
 -- PART 7: BUSINESS INSIGHTS
  SELECT * FROM supply_chain_analysis.supply_chain_cleaned_dataset;
 
 -- Q31. WHICH AREAS HAVE HIGH SALES BUT LOW PROFIT?
 SELECT `Order Region`,
    ROUND(SUM(`Sales per customer`), 2) AS total_sales,
    ROUND(SUM(`Benefit per order`), 2) AS total_profit,
    ROUND(SUM(`Benefit per order`) / SUM(`Sales per customer`) * 100, 2) AS profit_margin
FROM supply_chain_analysis.supply_chain_cleaned_dataset
GROUP BY `Order Region`
HAVING SUM(`Sales per customer`) > (
    SELECT AVG(region_sales)
    FROM (SELECT SUM(`Sales per customer`) AS region_sales
         FROM supply_chain_analysis.supply_chain_cleaned_dataset
         GROUP BY `Order Region`) AS region_totals)
ORDER BY total_sales DESC;


 -- Q32. WHICH PRODUCTS HAVE HIGH SALES BUT LOW PROFIT MARGIN?
  SELECT `product name`,
    ROUND(SUM(`Sales per customer`), 2) AS total_sales,
    ROUND(SUM(`Benefit per order`), 2) AS total_profit,
    ROUND(SUM(`Benefit per order`) / SUM(`Sales per customer`) * 100, 2) AS profit_margin
FROM supply_chain_analysis.supply_chain_cleaned_dataset
GROUP BY `product name`
HAVING SUM(`Sales per customer`) > (
    SELECT AVG(product_sales)
    FROM (SELECT SUM(`Sales per customer`) AS product_sales
         FROM supply_chain_analysis.supply_chain_cleaned_dataset
         GROUP BY `product name`) AS product_totals)
ORDER BY total_sales DESC;
 
 -- Q33. DOES LATE DELIVERIES APPEAR TO BE ASSOCIATED WITH LOWER SALES/PROFIT?
 SELECT `delivery status`, count(*) AS Total_deliveries,
		ROUND(AVG(`sales per customer`),2) AS Average_sales,
        ROUND(AVG(`benefit per order`),2) AS Average_profit
FROM supply_chain_analysis.supply_chain_cleaned_dataset
GROUP BY `delivery status`
ORDER BY Average_sales, Average_profit;
 -- Late deliveries are associated with slightly lower average sales and profit per order in this 
 -- dataset, although the difference is relatively small
 
 -- Q34. WHICH CUSTOMER SEGMENT IS THE MOST VALUABLE?
 SELECT`Customer Segment`,
    COUNT(DISTINCT `Customer Id`) AS total_customers,
    ROUND(SUM(`Sales per customer`), 2) AS total_sales,
    ROUND(SUM(`Benefit per order`), 2) AS total_profit,
    ROUND(SUM(`Benefit per order`) / SUM(`Sales per customer`) * 100,2) AS profit_margin
FROM supply_chain_analysis.supply_chain_cleaned_dataset
GROUP BY `Customer Segment`
ORDER BY total_profit DESC;
 -- The Consumer segment is the most valuable customer segment, generating the highest sales and 
 -- total profit while also having the highest profit margin among the three segments.

 -- Q35. WHICH COMBINATION OF CATEGORY + REGION GENERATES THE MOST SALES?
 SELECT `category name`, `order region`,
		ROUND(SUM(`sales per customer`),2) AS Total_Sales
FROM supply_chain_analysis.supply_chain_cleaned_dataset
GROUP BY `category name`, `order region`
ORDER BY Total_Sales DESC
limit 10;
 -- The Fishing category in Central America generates the highest sales among all 
 -- Category + Region combinations, with total sales of approximately 1.02 million
 
 
 -- Q36. WHAT ARE THE BIGGEST POTENTIAL AREAS FOR IMPROVING SUPPLY- CHAIN PERFORMANCE?

-- We can summarize the biggest potential improvement areas as:
-- 1. Reduce late deliveries and improve delivery reliability.
-- 2. Investigate high-sales regions with relatively low profit margins.
-- 3. Improve the profitability of high-sales, low-margin products.
-- 4. Identify and replicate successful category-region combinations.
 
 
 








































































