/*

Author: Jack Rothrock

*/

use salesshort;

#Show all customers (number and name) and their cancelled orders (order number, order date and status)

select customers.customerNumber, customers.customerName, orders.orderNumber, orders.orderDate, orders.status from customers 
	join orders on customers.customerNumber = orders.customerNumber 
    where orders.status = "cancelled";

# Show the customer number, name and number of orders. Order by number of orders (most to least)

select customers.customerNumber, customers.customerName, count(orders.orderNumber) as "number of orders" from customers 
	join orders on customers.customerNumber = orders.customerNumber 
    group by customers.customerNumber 
    order by count(orders.orderNumber) desc;

# Show the product line, text description of the product line and the number of products in the product line. Order by product line (A-Z)

select pl.productLine, pl.textDescription, count(products.productCode) as "number of products" from productlines pl 
	join products on pl.productLine = products.productLine 
    group by pl.productLine 
    order by pl.productLine;

# Show all orders (order number, order date, status) with product code, product name and quantity ordered. Order by order number and within order number by product name

select o.orderNumber, o.orderDate, o.status, od.productCode, p.productName, od.quantityOrdered from orders o 
	join orderdetails od on o.orderNumber = od.orderNumber 
    join products p on od.productCode = p.productCode 
    order by o.orderNumber, p.productName;

# Show all orders (order number, order date) with the total revenue for the order. Order by highest revenue to lowest. 

select o.orderNumber, o.orderDate, sum(od.quantityOrdered * od.priceEach) as "total order revenue" from orders o 
	join orderdetails od on o.orderNumber = od.orderNumber 
    group by o.orderNumber 
    order by sum(od.quantityOrdered * od.priceEach) desc;

# Show the total revenue by product (code and name). Show only orders that have been cancelled.  Order by total revenue (highest to lowest)

select p.productCode, p.productName, sum( od.priceEach * od.quantityOrdered) as "total revenue" from orders o 
	join orderdetails od on od.orderNumber = o.orderNumber
    join products p on p.productCode = od.productCode
    where o.status = "cancelled"
    group by p.productCode
    order by sum(od.priceEach * od.quantityOrdered) desc;
    
# Show the total revenue by customer (number and name). Show only orders with status resolved or shipped. Order by total revenue (highest to lowest)

select c.customerNumber, c.customerName, sum(od.priceEach * od.quantityOrdered) as "total revenue" from customers c 
	join orders o on o.customerNumber = c.customerNumber 
    join orderdetails od on od.orderNumber = o.orderNumber 
    group by c.customerNumber 
    order by sum(od.priceEach * od.quantityOrdered) desc;
    
# Show all orders (number and date) with the product name, quantity ordered, msrp, price each, buy price, the difference between msrp and buy price (potential profit), and the difference between price each and buy price (actual profit). Show also the percentage of actual profit compared to potential profit. Order by percentage descending.

select o.orderNumber, o.orderDate, p.productName, od.quantityOrdered, p.msrp, od.priceEach, p.buyPrice, (p.msrp - p.buyPrice) as "potentital profit", (od.priceEach - p.buyPrice) as "actual profit", ((od.priceEach - p.buyPrice)/(p.msrp - p.buyPrice)) as "percentage of potential profit" from orders o
	join orderdetails od on od.orderNumber = o.orderNumber
    join products p on p.productCode = od.productCode
    order by ((od.priceEach - p.buyPrice)/(p.msrp - p.buyPrice)) desc;
    
# Show all customers (number and name), and total quantity they ordered per product (code and name). Order by customer number and within customer number by product code
select c.customerNumber, c.customerName, sum(od.quantityOrdered) as "total quantity", p.productCode, p.productName from customers c
	join orders o on o.customerNumber = c.customerNumber
    join orderdetails od on od.orderNumber = o.orderNumber
    join products p on p.productCode = od.productcode
    group by c.customerNumber, p.productCode
    order by c.customerNumber, p.productCode;
    
# Show all United States customers (number and name), the products (code and name) the customer bought, the product line and the product text description. Order by customer number and within customer number by product code.
select c.customerNumber, c.customerName, p.productCode, p.productName, p.productLine, p.productDescription from customers c
	join orders o on o.customerNumber = c.customerNumber
    join orderdetails od on od.orderNumber = o.orderNumber
    join products p on p.productCode = od.productCode
    where c.country = "USA"
    group by c.customerNumber, p.productCode
    order by c.customerNumber, p.productCode;
    
# Show the total revenue by country. Order by highest to lowest revenue. Show only shipped orders and countries with a revenue greater than half a million. 

select c.country, sum(od.quantityOrdered * od.priceEach) as "total revenue" from customers c
	join orders o on o.customerNumber = c.customerNumber
    join orderdetails od on o.orderNumber = od.orderNumber
    where o.status = "shipped"
    group by c.country having sum(od.quantityOrdered * od.priceEach) > 500000;