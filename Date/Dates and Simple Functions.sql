/*
Author: Jack Rothrock
*/

use salesshort;

# Show the customernumber, name, contact last and first name in one column with a , in the middle and the days between order date and shipped date for all shipped orders. Order by longest to shortest time

select concat(c.customerNumber, ", ", c.customerName, ", ", c.contactLastName, ", ", c.contactFirstName) as "contact", datediff(o.shippedDate, o.orderDate) as "time between order and shipment" from customers c
	join orders o on c.customerNumber = o.customerNumber
    where o.status = "shipped"
    order by datediff(o.orderDate, o.shippedDate);

# Show the total revenue for each day of the week based on shipped date. Order by most to least revenue

select dayname(o.shippedDate) as "Shipped Day", format(sum(od.quantityOrdered * od.priceEach), 2, "c") as "Total Revenue" from orders o
	join orderdetails od on od.orderNumber = o.orderNumber
    where o.status = "shipped"
    group by dayname(o.shippedDate)
    order by sum(od.quantityOrdered * od.priceEach) desc;

# Show the total revenue for each day of the week based on shipped date. Order by weekday (Sunday to Saturday)

select dayname(o.shippedDate) as "Shipped Day", format(sum(od.quantityOrdered * od.priceEach), 2, "c") as "Total Revenue" from orders o
	join orderdetails od on od.orderNumber = o.orderNumber
    where o.status = "shipped"
    group by dayname(o.shippedDate)
    order by dayofweek(o.shippedDate) asc;
    
# Show the total revenue for each month (format YY-MM, find a function that formats it correctly even if the month has just one digit)  based on shipped date. Order by newest to oldest year/month

select date_format(o.shippedDate, "%y-%m") as "YY-MM", format(sum(od.priceEach * od.quantityOrdered), 2, 'c') as "total revenue" from orders o 
	join orderdetails od on od.orderNumber = o.orderNumber
    where o.status = "shipped"
    group by date_format(o.shippedDate, "%y-%m")
    order by year(o.shippedDate), month(o.orderdate);
