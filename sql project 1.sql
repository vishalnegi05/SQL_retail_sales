#DATA ANALYSIS OR BUSINESS KEY PROBLEMS AND ANSWERS#-------


#-Q1 - write a SQL Query to retrieve all columns for sales made on "2022-11-05"-

SELECT 
    *
FROM
    retail_sales
WHERE
    sale_date = '2022-11-05';
    

#--Q2 - write a sql query to retrieve all transactions where the category is 'clothing' and the quantity sold is more than or euals to 4 in the month of NOV_2022


SELECT 
    *
FROM
    retail_sales
WHERE
    category = 'Clothing' 
    AND
    sale_date BETWEEN '2022-11-01' AND '2022-11-30'
    AND
    quantity >= 4;
    
    
    
#-Q3---WRITE A SQL QUERY TO CALCULATE THE TOTAL SALES FOR EACH CATEGORY---
    
    
SELECT 
    category, SUM(total_sale) AS net_sales,
    COUNT(*) AS total_orders
FROM
    retail_sales
GROUP BY category;


#--Q4--WRITE A SQL QUERY TO FIND THE AVERAGE AGE OF CUSTOMERS WHO PURCHASED ITEM FROM THE 'BEAUTY' CATEGORY---


SELECT 
    ROUND(AVG(age),2) AS Avg_age
FROM
    retail_sales
WHERE
    category = 'beauty';
    
    
#--Q5--WRITE A SQL QUERY TO FIND ALL TRANSACTIONS WHERE THE TOTAL_SALES IS GRATER THAN 1000----

SELECT 
    *
FROM
    retail_sales
WHERE
    total_sale > 1000;
    
#--Q6--- WRITE A SQL QUERY TO FIND THE TOTAL NUMBER OF TRANSACTIONS (TRANSACTION_ID) MADE BY EACH GENDER IN EACH CATEGORY----

SELECT 
    category,
    gender,
    COUNT(*)
FROM
    retail_sales
GROUP BY category,
		gender
ORDER BY 1;
        
#---Q7--WRITE A SQL QUERY TO CALCULATE THE AVERAGE SALES FOR EACH MONTH. FIND OUT BEST SELLING MONTH IN EACH YEAR---


SELECT* FROM
(
SELECT 
	YEAR(sale_date) AS year,
    month(sale_date) AS month,
    AVG(total_sale),
    RANK() OVER(PARTITION BY YEAR(sale_date)ORDER BY AVG(total_sale)DESC) AS Standing
FROM retail_sales
GROUP BY 1,2) AS t1
WHERE standing = 1;

#----Q8--WRITE SQL QUERY TO FND THE TOP 5 CUSTOMER BASED ON THE HIGHEST TOTAL SALES----

SELECT 
	customer_id,
    SUM(total_sale) AS total_sale 
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sale DESC
LIMIT 5;


#--Q9---WRITE A SQL QUERY TO FIND THE NUMBERS OF UNIQUE CUSTOMERS WHO PURCHASED ITEMS FROM EACH CATEGORY-------

SELECT 
	category,COUNT(DISTINCT customer_id) AS count_of_unq_customer
    FROM retail_sales
GROUP BY 1;

#----Q10--WRITE A SQL QUERY TO CREATE EACH SHIFT AND NUMBER OF ORDERS ( EXAMPLE MORNING <=12, AFTERNOON BETWEEN 12 & 17,EVENING > 17)

WITH Hourly_sales 
AS 
(
SELECT *,
	CASE
		WHEN HOUR(sale_time) <12 THEN "Morning"
        WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN "Afternoon"
        ELSE "Evening"
	END AS shift
FROM retail_sales)
SELECT COUNT(*) AS Total_orders,shift FROM  hourly_sales
GROUP BY shift



#---END OF PROJECT ---------------

	

    