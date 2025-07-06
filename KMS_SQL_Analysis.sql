Create database KMS_DB
USE KMS_DB

SELECT * FROM [KMS Sql Case Study]

--1. Which product category had the highest sales? 
SELECT TOP 1 Product_Category,SUM(Sales) AS Highest_Sales From [KMS Sql Case Study]
Group BY Product_Category
ORDER BY Highest_Sales Desc

--2. What are the Top 3 and Bottom 3 regions in terms of sales? 
SELECT TOP 3 Region,SUM(Sales) AS Total_Sales FROM [KMS Sql Case Study]
GROUP BY Region
ORDER BY Total_Sales Desc

SELECT TOP 3 Region,SUM(Sales) AS Total_Sales FROM [KMS Sql Case Study]
GROUP BY Region
ORDER BY Total_Sales ASC

--3. What were the total sales of appliances in Ontario? 
SELECT SUM(Sales) AS Total_Sales  FROM [KMS Sql Case Study]
WHERE Region ='Ontario' AND Product_Sub_Category='Appliances'

SELECT SUM(Sales) AS Total_Sales,Product_Sub_Category,Region FROM[KMS Sql Case Study]
GROUP BY Product_Sub_Category,Region
HAVING Product_Sub_Category='Appliances' AND Region='Ontario'

--4 Advise the management of KMS on what to do to increase the revenue from the bottom 10 customers 

SELECT TOP 10 Customer_Name, SUM(Sales) AS Total_Sales FROM [KMS Sql Case Study]
GROUP BY Customer_Name
ORDER BY Total_Sales asc

--Increase discount percentage
--Create more awareness for promo

--5 KMS incurred the most shipping cost using which shipping method?
SELECT TOP 1 SUM(Shipping_Cost) AS Total_Cost,Ship_Mode FROM [KMS Sql Case Study]
GROUP BY Ship_Mode
ORDER BY Total_Cost DESC

--6. Who are the most valuable customers, and what products or services do they typically purchase?
SELECT TOP 5 Customer_Name,Product_Category , SUM(Sales) AS Total_Sales FROM [KMS Sql Case Study]
GROUP BY Customer_Name,Product_Category
ORDER BY Total_Sales DESC


--7. Which small business customer had the highest sales? 
SELECT top 1 Customer_Name,Customer_Segment, sum(Sales) AS Total_Sales FROM [KMS Sql Case Study]
GROUP BY Customer_Name,Customer_Segment
HAVING Customer_Segment ='Small Business'
ORDER BY Total_Sales desc

SELECT Customer_Name,Sales FROM [KMS Sql Case Study]
WHERE Sales=(SELECT MAX(Sales) FROM [KMS Sql Case Study]
WHERE Customer_Segment ='Small Business')

SELECT COUNT(*) FROM [KMS Sql Case Study]
WHERE CUSTOMER_NAME='DENNIS KANE'
--8. Which Corporate Customer placed the most number of orders in 2009 – 2012? NEED CORRECTION
SELECT Customer_Name,Count(Order_ID) AS Orders FROM [KMS Sql Case Study]
WHERE Customer_Segment='Corporate' AND Year(Order_Date) BETWEEN 2009 AND 2012
GROUP BY Customer_Name
ORDER BY Orders DESC

--9. Which consumer customer was the most profitable one? 
SELECT Customer_Name, Profit From [KMS Sql Case Study]
WHERE Customer_Segment='Consumer' AND Profit=(
SELECT MAX(Profit) FROM [KMS Sql Case Study])

SELECT TOP 1 Customer_Name,sum(Profit) AS Total_Profit FROM [KMS Sql Case Study]
GROUP BY Customer_Name
ORDER BY Total_Profit desc
           


--10. Which customer returned items, and what segment do they belong to? 
SELECT DISTINCT Customer_Name,Customer_segment FROM [KMS Sql Case Study]
WHERE Order_ID=ANY(SELECT Order_ID FROM Order_Status)

SELECT DISTINCT K.Customer_Name,K.Customer_segment FROM [KMS Sql Case Study] AS K
INNER JOIN Order_Status AS OS ON OS.Order_ID=K.Order_ID

SELECT Customer_Name,Customer_segment FROM [KMS Sql Case Study],Order_Status

--11. If the delivery truck is the most economical but the slowest shipping method and 
--Express Air is the fastest but the most expensive one, do you think the company 
--appropriately spent shipping costs based on the Order Priority? Explain your answer 
SELECT Order_Priority,Ship_Mode,COUNT(*) AS No_Of_Priority,SUM(Sales-Profit) as estimated_shipping_cost,
AVG(DATEDIFF(day, [Order_Date], [Ship_Date])) AS AvgShipDays
FROM [KMS Sql Case Study]
GROUP BY Order_Priority,Ship_Mode
ORDER BY Order_Priority asc
-- The company did not appropriately spend on shipping based on order priority.
-- It overpaid for low-priority shipments.
--It underutilized the fastest method for critical needs.
--It missed cost-saving opportunities for medium and low priorities.
--To correct this, the company should match urgency to shipping speed and cost more strategically.







