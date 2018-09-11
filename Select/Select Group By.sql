/*
Author: Jack Rothrock
*/

use salesshort;

# How many customers does the company have?

select count(distinct customerName) as "Number of customers" from customers;

# How many German customers does the company have? 

select count(distinct customername) as "Germany customers" from customers where country = "Germany";

# How many customers does the company have in each country? Order by most to least customers. 

select country, count(distinct customername) from customers group by country order by count(distinct customername) desc;

# What is the average MSRP across all products? 

select avg(msrp) as "Average MSRP" from products;

# What is the total revenue of the company? 

select sum(priceEach * quantityOrdered) as "Total Revenue" from orderdetails;

# How many products does each product line have? Order by most to least. 

select productline, count(*) as "total" from products group by productline order by count(*) desc;

# How many products does each product line have? Show only the product lines with more than 10 products. Order by most to least. 

select productline, count(*) as "Total" from products group by productline having count(*) > 10 order by count(*) desc;

# Show the total revenue by order number. Order by highest to lowest revenue. 

select orderNumber, (priceEach * quantityOrdered) "total revenue" from orderdetails group by orderNumber order by (priceEach * quantityOrdered) desc;

# How many orders have been cancelled?

select count(*) as "Cancelled orders" from orders where status = "Cancelled";

# Show the total quantity in stock value by product vendor. Order by highest to lowest value.

select productVendor, sum(quantityInStock) "total quantity in stock" from products group by productVendor order by sum(quantityInStock) desc;

# How many customers have no sales representative?

select count(*) as "Number of customers with no sales representative" from customers where salesRepEmployeeNumber is null;

# Show the total revenue by productCode. Show only products with more than 50000 in revenue. Order by highest to lowest revenue. 

select productCode, sum(priceEach * quantityOrdered) as "Total revenue" from orderdetails group by productCode having sum(priceEach * quantityOrdered) > 50000 order by sum(priceEach * quantityOrdered) desc;

# How many customers does the company have in each city with a credit limit over 100000? Order by most to least, show only cities with more than 1 customer. 

select city, count(*) as "Number of customers with credit limit over 100000" from customers where creditlimit > 100000 group by city having count(*) > 0 order by count(*) desc;

# How many customers does each sales representative have in each city? Order by most to least for each sales representative.

select salesRepEmployeeNumber, city, count(*) from customers where salesRepEmployeeNumber is not null group by salesRepEmployeeNumber, city order by count(*) desc;

# Show the number of products for each product scale. Order by product scale.

select productScale, count(*) as "number of products" from products group by productScale order by productScale;