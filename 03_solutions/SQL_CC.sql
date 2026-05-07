-- Use  Sales_Analytics  Data base 

-- SELECT + DISTINCT (Used to fetch unique values) 
-- 1. List all distinct cities where customers live. 
select distinct(city) Unique_City_List from customers;
-- 2. Retrieve distinct product categories from the Products table. SELECT + ALIAS (AS) (Used to rename columns or expressions) 
select distinct(category) as Unique_Product_Category from products;
-- 3. Display customer names and their email IDs renamed as Customer_Name and Email_ID. 
select customerName Customer_Name,email Email_ID from customers;
-- 4. Show product name, price, and (Price × 2) as DoublePrice. 
select productName Product_Name,price Price ,(price*2) as Double_Price from products;
-- 5. Show product name and price after adding a 10% tax. 
select productname Product_Name,price Original_Price,(price*1.1) Price_With_Tax from products;

-- WHERE CLAUSE WITH OPERATORS 
-- 6. Find all customers who live in Hyderabad. 
select * from customers where city='hyderabad';
-- 7. Show all products priced above 10,000. 
select * from products where price>10000;
-- 8. List all orders placed after 2025-01-12. 
select * from orders where orderdate>'2025-01-12';
-- 9. Find products whose price is NOT equal to 1500. 
select * from products where price != 1500;
-- 10. Find customers whose Email is NULL. 
select * from customers where email is null;
-- 11. List all orders where quantity is NOT NULL. 
select * from orders where quantity is not null;
-- 12. List the female customers who live in Chennai. 
select * from customers where gender='f' and city='chennai';
-- 13. Display customers who live in (‘Chennai’, ‘Bangalore’, ‘Hyderabad’).
select * from customers where city in('chennai','bangalore','hyderabad'); 
-- 14. Show products whose category is NOT IN (‘Electronics’, ‘Furniture’) 
select * from products where category not in('electronics','furniture');

-- ORDER BY & LIMIT (Questions mainly about sorting and/or limiting output) 
-- 1. List all customers ordered by their Customer Name in ascending order. 
select customerID,CustomerName from customers order by customerName;
-- 2. Display the top 3 products by price. 
select productid,productname,price  from products order by price  limit 3;
-- 3. List the top 3 most expensive products whose price is > 5,000, ordered by price DESC. 
select productid,productname,price  from products where price>5000 order by price desc limit 3;
-- 4. Show the number of customers in each city and order the result by customer count DESC. 
select city,count(*) Total_customers from customers group by city order by Total_customers desc;
-- 5. Retrieve customers in (‘Chennai’, ‘Pune’, ‘Hyderabad’) and sort by name. 
select customerName ,city from customers where city in ('chennai', 'pune','Hyderabad') order by customerName;
-- 6. Retrieve customers in given cities, display City + CustomerName, sorted by city and name. 
select city,customername from customers order by city ,customername;
-- 7. List customers whose name starts with ‘A’ and sort by CustomerID. 
select customername Customer_Name,customerid Customer_ID from customers where customername like 'a%' order by customerid;

-- AGGREGATE FUNCTIONS (Direct aggregate without GROUP BY) 
-- 8. Find the total number of customers in the Customers table. 
select count(*) as Total_Customers from customers;
-- GROUP BY AND HAVING 
-- 9. Show the number of customers in each city. 
select city City,count(*) as Total_Customers from customers group by city;
-- 10. Show the total number of customers in each gender group. 
select gender Gender ,count(*) as Total_Customers from customers group by gender;
-- 11. Display City and Customer Name grouped by city.  
select city City,group_concat(customername) Customer_Names from customers group by city;
-- 12. Show only those cities where customer count is greater than 2. 
select city City,count(customerid) Customer_Count from customers group by city having Customer_Count>2;
-- 13 Total orders per customer, but show only customers with more than 3 orders. 
select customerid Customer_ID,count(orderid) Total_Orders from orders group by customerid having Total_Orders>3;
-- 14. Product ID and total quantity sold, but only products where total quantity is between 2 and 5. 
select productid Product_ID,count(quantity) Quantities_Sold from orders group by productid having  Quantities_Sold between 2 and 5;
-- 15. Each category and its average price, but only categories where average price is greater than 5000. 
select category Category,avg(price) Average_Price from products group by category having Average_Price>5000;

-- JOIN-BASED QUESTIONS  
-- 1. List all orders along with the customer names. 
select o.*,customername CustomerName 
from orders o left join customers c on c.customerid=o.customerid;
-- 2. Show all customers and their orders using LEFT JOIN. 
select c.customerid CustomerID,customername CustomerName ,group_concat(orderid separator', ') as OrderIDList 
from customers c left join orders o on c.customerid=o.customerid group by CustomerID;
-- 3. Show salesperson name and orders assigned to them (RIGHT JOIN). 
select salespersonname SalesPerson,group_concat(orderid separator ', ')as OrdersAssigned 
from orders o right join salespersons sp on sp.salespersonid=o.salespersonid group by sp.salespersonid;
-- 4. List all orders with Customer Name, Product Name, Quantity, and Order Date (ordered by OrderID). 
select customername CustomerName,o.orderid OrderID ,productname ProductName,quantity Quantity,orderdate OrderDate 
from orders o join customers c on o.customerid=c.customerid
left join products p on p.productid=o.productid order by o.orderid; 
-- 5. Display all orders from ‘Chennai’ customers with the product details. 
select o.* ,ProductName,Category,Price,c.city City 
from orders o join products p on o.productid=p.productid
left join customers c on o.customerid=c.customerid where c.city='chennai';
-- 6. Display all customers who purchased “Laptop”.
select CustomerName Customers_Purchased_Laptop 
from customers c  join orders o on c.customerid=o.customerid 
left join products p on o.productid=p.productid where productname='laptop';

-- BUILT-IN FUNCTIONS + AGGREGATION 
-- 7. Show total sales amount (Price × Quantity) for each order. 
select orderid OrderID,o.productid ProductID,quantity Quantity,price Price,(price*quantity) as TotalSalesAmount 
from orders o left join products p on o.productid=p.productid;
-- 8. Find the top 5 customers by total purchase amount. 
select CustomerName,price*quantity as TotalPurchaseAmount 
from customers c join orders o on o.customerid=c.customerid 
left join products p on o.productid=p.productid order by TotalPurchaseAmount desc limit 5;
-- 9. Show each Salesperson’s region and the total sales value. 
select SalespersonName,Region,sum(price*quantity) as TotalSalesValue 
from salespersons sp join orders o on o.salespersonid=sp.salespersonid
left join products p on o.productid=p.productid group by region,SalespersonName;
-- 10. Find the most sold product with total quantity. 
select ProductName,sum(Quantity) TotalQuantitySold 
from orders o  join products p on o.productid=p.productid 
group by productName order by TotalQuantitySold desc limit 1;
-- 11. Show the earliest (minimum) and latest (maximum) order date. 
select min(orderdate) Earliest_Order_Date ,max(orderdate) Latest_Order_Date from orders;

-- DATE & TIME BUILT-IN FUNCTIONS 
-- (Date filtering, extracting month/week/day) 
-- 12. Find all orders placed in January 2025. 
select * from orders where year(orderdate)=2025 and month(orderdate)=1;
-- 13. List orders week-wise (show week number and total orders). 
select week(orderdate) WeekNumber,(count(orderid)) TotalOrders from orders group by WeekNumber;
-- 14. Display orders along with the day name (Monday, Tuesday, etc.). 
select o.* ,dayname(orderdate) Day  from orders o;
-- 15. Extract day name and display total sales amount and quantity per day of week (ordered Monday → Sunday). 
select dayname(orderdate) Day,count(orderid) TotalOrders,sum(price*quantity) TotalSalesAmount 
from orders o left join products p on o.productid=p.productid
group by Day order by TotalSalesAmount desc;

-- SINGLE ROW SUBQUERIES 
-- (returns only one value) 
-- 1. Find customers who live in the same city as 'Arjun Kumar'. 
select * from customers where city =(select city from customers where customername='Arjun Kumar');
-- 2. Find products that are more expensive than the average product price. 
select productname as MostExpensiveProducts from products where price > (select avg(price) from products);
-- 3. Find products belonging to the same category as 'Laptop'. 
select productname as ProductsHavingSameCategoryAsLaptop from products where category=(select category from products where productname='laptop');
-- 4. Find customers who have placed more orders than the customer with CustomerID = 5.
select customerid,count(orderid) OrderCount from orders group by customerid having OrderCount>
(select count(orderid) from orders where customerid=5);
-- 5. Find products that are priced higher than the product with ProductID = 3. 
select productname from products where price>(select price from products where productid=3);
-- 6. Find customers who placed an order on the same date as OrderID = 1. 
select customername from customers c right join orders o on o.customerid=c.customerid where orderdate=
(select orderdate from orders where orderid=1);
-- 7. Find the salesperson whose target amount is higher than the average target. 
select salespersonname from salespersons where targetamount>
(select avg(targetamount) from salespersons);

-- MULTI ROW SUBQUERIES 
-- (returns multiple values – IN, ANY, ALL) 
-- 8. Find customers who have ordered any product in the 'Electronics' category. 
select CustomerName from customers c right join orders o on c.customerid=o.customerid where productid in 
(select productid from products where category='electronics');
-- 9. Find products that were ordered by customers from Chennai. 
select distinct productname from products p right join orders o on o.productid=p.productid 
where customerid in (select customerid from customers where city='chennai');
-- 10. Find salespersons who handled orders for customers from Bangalore. 
select salespersonname from salespersons sp right join orders o on sp.salespersonid=o.salespersonid where customerid in
(select customerid from customers where city='bangalore');
-- 11. Find products whose price is greater than ALL products in the Furniture category. 
select productname from products where price > all(select price from products where category='furniture');
-- 12. Find products whose price is greater than ANY Electronics product. 
select productname from products where price > all(select price from products where category='electronics');
-- 13. Find customers who purchased products costing more than 10000. 
select distinct customername from customers c right join orders o on o.customerid=c.customerid where productid in
(select productid from products where price>10000);

-- CORRELATED SUBQUERIES 
-- (inner query depends on outer query) 
-- 14. Find customers who have placed at least one order. 
select c1.customername from customers c1 where exists (select 1 from orders o where c1.customerid=o.customerid);
-- 15. Find customers who have placed more than 2 orders. 
select c1.customername from customers c1 where (select count(o.orderid) from orders o where o.customerid=c1.customerid)>2;
select customername from customers where customerid in (select customerid  from orders group by customerid having count(orderid)>2);
-- 16. Find products that have been ordered more than once. 
select productname from products p where exists(select 1 from orders o where o.productid=p.productid);
-- 17. Find salespersons who have handled more than 3 orders. select * from orders;
select salespersonname from salespersons sp where (select count(o.orderid) from orders o where o.salespersonid=sp.salespersonid)>3;
-- 18. Find customers who have purchased products more expensive than the average product price in that category.
select customername from customers c 
join orders o on o.customerid=c.customerid
join products p1 on p1.productid=o.productid where p1.price>
(select avg(p2.price) from products p2 where p1.category=p2.category);
-- 19. Find products whose price is greater than the average price of their category. 
select productname from products p where p.price > (select avg(p1.price) from products p1 where p1.category=p.category);
-- 20. Find customers whose total orders are greater than the average number of orders placed by customers. 
select customername from customers c where (
select count(*) from orders o where o.customerid=c.customerid)>
(select avg(order_count) from(select count(*) order_count from orders o group by customerid)as overall_avg);

-- BASIC CTE QUESTIONS 
-- 1. Create a CTE to calculate the total order quantity for each customer and display customers with quantity greater than 3. 
with cte_customer_qty as(
select customername Customer,count(quantity) TotalQuantity from orders o left join customers c on o.customerid=c.customerid group by o.customerid
)select * from cte_customer_qty where TotalQuantity>3;
-- 2. Create a CTE to calculate total sales amount for each order (Price × Quantity) and display all orders.
with cte_sales_amount as(
select orderid,quantity*price TotalSales from  orders o left join products p on o.productid=p.productid )
select * from cte_sales_amount;
-- 3. Create a CTE to calculate the total sales amount for each salesperson. 
with cte_salesperson_sales as(
select salespersonname,sum(quantity*price) TotalSales from  orders o 
left join products p on o.productid=p.productid 
left join salespersons sp on sp.salespersonid=o.salespersonid  group by o.salespersonid )
select * from cte_salesperson_sales;
-- 4. Create a CTE to calculate the average product price by category. 
with cte_avg_ProductPrice_category as(
select category,avg(price) from products group by category)
select * from cte_avg_ProductPrice_category;
-- 5. Create a CTE to display customers and their total number of orders. 
with cte_customerOrders as(
select customername,count(orderid) from orders o left join customers c on o.customerid=c.customerid group by o.customerid)
select * from cte_customerOrders;
-- 6. Create a CTE to find the top 3 most sold products based on quantity. 
with cte_qty_top_products as(
select productname product,sum(quantity) TotalQuantity from orders o left join products p on o.productid=p.productid group by o.productid order by TotalQuantity desc)
select * from cte_qty_top_products limit 3;
-- 7. Create a CTE to calculate total revenue for each product. 
with products_revenue as(
select productname product,sum(quantity*price) TotalRevenue from orders o left join products p on o.productid=p.productid group by o.productid)
select * from products_revenue;
-- 8. Create a CTE to display salesperson performance (total sales vs target amount). 
with cte_salesperson_performance as(
select salespersonname,TargetAmount,sum(quantity*price) ActualSales from  orders o 
left join products p on o.productid=p.productid 
left join salespersons sp on sp.salespersonid=o.salespersonid  group by o.salespersonid )
select * from cte_salesperson_performance;
-- 9. Create a CTE to find cities that have more than 2 customers.
with cte_citywise_customers as (
select  city,count(o.customerid) TotalCustomers from orders o left join customers c on o.customerid=c.customerid group by city order by TotalCustomers desc)
select * from cte_citywise_customers where TotalCustomers>2;
-- 10. Create a CTE to calculate total sales per day.
with cte_sales_perDay as(
select orderdate,sum(quantity*price) TotalSales from  orders o left join products p on o.productid=p.productid group by orderdate)
select * from cte_sales_perDay; 
-- 11. Create a CTE to find customers whose total purchase amount is greater than the average purchase amount of all customers.
with cte_customer_totalPurcahse as(
select customername,sum(quantity*price) purchaseAmount from  orders o 
left join products p on o.productid=p.productid 
left join customers c on c.customerid=o.customerid  group by o.customerid ),
cte_avg_purchase as(
select avg(quantity*price) AvgPurchaseAmount from  orders o 
left join products p on o.productid=p.productid )
select customername,purchaseAmount from cte_customer_totalPurcahse,cte_avg_purchase where purchaseAmount>AvgPurchaseAmount;
-- 12. Create a CTE to calculate category-wise total sales amount. 
with cte_category_totalsales as(
select category,sum(quantity*price) TotalsalesAmount from  orders o 
left join products p on o.productid=p.productid group by category)
select * from cte_category_totalsales;
-- 13. Create a CTE to find products whose price is higher than the average price of their category. 
with cte_category_totalsales as(
select category,p.productid,avg(quantity*price) AvgCategoryPrice from  orders o 
left join products p on o.productid=p.productid group by category,p.productid)
select p.productname,cte.category,AvgCategoryPrice,p.price from cte_category_totalsales cte right join products p on cte.category=p.category 
where p.price> AvgCategoryPrice;
-- 14. Create a CTE to display salesperson ranking based on total sales amount. 
with cte_salesperson_ranking as(
select salespersonname,sum(quantity*price) TotalSales from  orders o 
left join products p on o.productid=p.productid 
left join salespersons sp on sp.salespersonid=o.salespersonid  group by o.salespersonid )
select salespersonname,Totalsales,dense_rank() over(order by TotalSales desc)  from cte_salesperson_ranking;
-- 15. Create a CTE to find customers who purchased more than one different product. */
with cte_customer_purchased_diff_product as(
select o.customerid,group_concat(productid) ProductList from orders o left join customers c on o.customerid=c.customerid group by o.customerid)
select customername Customer,ProductList from cte_customer_purchased_diff_product cte join customers c on cte.customerid=c.customerid 
where length(ProductList)>2;
-- WINDOW FUNCTION 
-- 1. Display each order with the total number of orders placed by that customer using a window function. 
select orderid,customerid,count(*) over(partition by customerid)as order_count from orders;
-- 2. Show each product with its price and the average price of all products. 
select productname,price,avg(price) over() as Avg_Pdt_Price from products;
-- 3. Rank all products based on price from highest to lowest using a window function. 
select productname,price,dense_rank() over(order by price desc) as Price_Ranking from products;
-- 4. Display each order with the total quantity ordered by that salesperson.
select orderid,salespersonid,sum(quantity) over(partition by salespersonid) as TotalquantitybySalesperson from orders; 
-- 5. Rank salespersons based on the total sales amount they generated. 
select  salespersonid,TotalSales,
dense_rank() over(order by TotalSales desc) SalesRank 
from (select salespersonid,sum(quantity*price) as TotalSales from orders o join products p on o.productid=p.productid group by salespersonid
) as SalesSummary ;
-- 6. Show product price ranking within each category using PARTITION BY. 
select productid,productname,price,category,dense_rank() over(partition by category order by price desc) PriceRankByCategory from products;
-- 7. Display the previous order date for each customer using LAG() function. 
select customerid,orderdate,lag(orderdate) over(partition by customerid) as PreviousOrderDate from orders;
-- 8. Display the next order date for each customer using LEAD() function. 
select customerid,orderdate,lead(orderdate) over(partition by customerid) as NextOrderDate from orders;
-- 9. Calculate the running total of sales amount by order date. 
select orderdate,sum(price*quantity) over(partition by orderdate) as RunningTotal from orders o join products p on o.productid=p.productid;
-- 10. Display the top 3 most expensive products using DENSE_RANK() 
select productid Product_ID,productname ProductName,price Price, dense_rank() over(order by price desc) as Product_Price_Rank from products limit 3;