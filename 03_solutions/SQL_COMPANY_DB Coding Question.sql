-- Scenario Questions 
use sql_company_db;
-- 1. Find duplicate customer records from the Customers table. 
select customer_id,count(*) DuplicateRecords  from customers group by customer_id having DuplicateRecords>1;
-- 2. Replace NULL salaries with 0 in the Employees table. 
set sql_safe_updates =0;
update employees set salary=0 where salary is null;
select * from employees;
-- 3. Fetch the top 5 highest-paid employees. 
select emp_id,emp_name,salary from employees group by emp_id order by salary desc limit 5; 
-- 4. Display employees whose names start with letter A.  
select emp_name from employees where emp_name like 'a%';
-- 5. Show all orders placed between two given dates.  
select * from orders where order_date between '2025-04-01' and '2025-04-20';
-- 6. Show employee names along with department names.  
select emp_name EmployeeName,dept_name DepartmentName from employees e left join departments d on e.dept_id=d.dept_id;
-- 7. Find employees who are not assigned to any department.  
select emp_name EmployeeName,dept_name DepartmentName from employees e left join departments d on e.dept_id=d.dept_id where dept_name is null;
-- 8. Show all departments even if no employees are assigned.
select dept_name DepartmentName ,group_concat(emp_name) EmployeeList 
from departments d left join employees e on e.dept_id=d.dept_id group by d.dept_id;  
-- 9. Find records present in one table but missing in another table.  
select c.* from customers c left join orders o on c.customerid=o.customerid where o.customerid is null;
-- 10. Show customers who placed orders and customers who did not place orders. 
select  distinct(customer_name) OrderedCustomers from customers where customer_id  in (select customer_id from orders);
select customer_name from customers where customer_id not in (select customer_id from orders);
-- 11. Calculate total sales month-wise from the Sales table.  
select monthname(order_date) MonthName,sum(amount) TotalSales from sales group by MonthName;
-- 12. Find average salary department-wise.  
select dept_name,avg(salary) AvgSalary from departments d left join employees e on d.dept_id=e.dept_id group by d.dept_id;
-- 13. Find which department has the maximum number of employees.  
select distinct dept_id,count(emp_id) over(partition by dept_id) EmployeeCount from employees where dept_id is not null order by EmployeeCount desc;
select dept_name,count(emp_id) EmployeeCount from departments d left join employees e on d.dept_id=e.dept_id group by d.dept_id order by EmployeeCount desc;
-- 14. Find the second highest salary in the Employees table.  
select emp_name ,salary,dense_rank() over(order by salary desc) as SalaryRank from employees ;
-- 15. Find duplicate emails in the Customers table.
select email,count(email) DuplicateEmailCount from customers group by email having DuplicateEmailCount>1  ;
-- 16. Compare this month sales with last month sales.
-- Step 1: Aggregate sales by year and month  
WITH MonthlySales AS (
    SELECT 
        YEAR(orderdate) as SalesYear,
        MONTH(orderdate) as SalesMonth,
        MONTHNAME(orderdate) as MonthName,
        SUM(quantity * price) AS CurrentMonthSales
    FROM orders o 
    JOIN products p ON o.productid = p.productid
    GROUP BY YEAR(orderdate), MONTH(orderdate), MONTHNAME(orderdate)
)
-- Step 2: Use LAG to compare with the previous row
SELECT 
    MonthName,
    CurrentMonthSales,
    LAG(CurrentMonthSales) OVER (ORDER BY SalesYear, SalesMonth) AS LastMonthSales,
    (CurrentMonthSales - LAG(CurrentMonthSales) OVER (ORDER BY SalesYear, SalesMonth)) AS Difference
FROM MonthlySales;

-- 17. Find top 3 products by revenue.
select product_name Product ,sum(price*quantity) as Revenue 
from products p left join orders o on o.product_id=p.product_id 
group by p.product_id order by Revenue desc limit 3 ;   
-- 18. Find which city has the highest number of customers. 
select city,count(customer_id) CustomerCount from customers group by city order by  CustomerCount desc limit 1;
-- 19. Find customers who purchased more than 5 times.  
select customer_name,count(order_id) PurchaseCount from orders o right join customers c 
on o.customer_id=c.customer_id group by c.customer_id having PurchaseCount >5;
-- 20. Find inactive customers who have not ordered in the last 6 months.  
select customer_id InactiveCustomers from orders  where order_date < 
(select date_sub(max(order_date),interval 6 month) from orders);

-- Window Function Scenarios 
-- 21. Rank employees based on salary.  
select emp_name Employee,dense_rank() over(order by salary desc) as SalaryRank from employees;
-- 22. Calculate running total of sales by date.  
select sale_id,order_date,amount,sum(amount) over(partition by order_date) RunningTotal from sales;
-- 23. Show previous month sales using LAG() function.  
-- 24. Find top performer in each sales region.  
select emp_name,region,dense_rank() over(partition by region order by sales desc) as SalesRank from salesteam order by SalesRank limit 4;
-- 25. Assign row numbers to duplicate customer records.
select c.*,row_number() over(partition by customer_name) RowNumber from customers c;  
-- 26. Create an index to improve employee name search performance. 
select * from employees where emp_name like '%John%';
 create index emp_name_index on employees(emp_name);
 select * from employees where emp_name like '%riya%';
-- 27. Improve query performance on large sales table using indexing.  
select * from orders where customer_id =1 and order_date>'2025-06-01';
create index idx_sales_customer_date on orders(customer_id,order_date);
select * from orders where customer_id =1 and order_date>'2025-06-01';
-- 28. Use CTE to fetch employees with salary greater than 50,000.  
with cte_emp_salary as(
select emp_name,salary from employees)
select * from cte_emp_salary where salary >50000;
-- 29. Create an index on customer email for faster lookup. 
 create index idx_cust_email on customers(email);
-- 30. Extract today’s sales report automatically.  
select * from sales where order_date=curdate();
-- 31. Generate total sales report from the Sales table.
select count(sale_id)TotalOrders,sum(amount)TotalSales,avg(amount) AvgSales,max(amount) HigestSale,min(amount) LowestSale from sales;  
-- 32. Remove duplicate customer records keeping one record.  
select customer_name, email, COUNT(*) DuplicateCount from customers
group by customer_name, email having COUNT(*) > 1;
set sql_safe_updates=0;
delete c1 from customers c1 join customers c2 on 
c1.customer_name = c2.customer_name and c1.email = c2.email and c1.customer_id > c2.customer_id;
-- 33. Join Customers, Orders, and Products tables.  
select order_id,customer_name,product_name,quantity,order_date from orders o 
 join customers c on o.customer_id=c.customer_id 
left join products p on o.product_id=p.product_id;
-- 34. Generate monthly sales report.  
select year(order_date) SaleYear,monthname(order_date) SaleMonth,sum(amount) MonthlySales from sales group by SaleYear,SaleMonth;
-- 35. Find highest-selling product based on number of orders. 
select product_name,count(order_id) OrderCount 
from orders o left join products p on o.product_id=p.product_id 
group by o.product_id order by OrderCount desc limit 1;