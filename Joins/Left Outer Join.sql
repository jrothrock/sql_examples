/*
Author: Jack Rothrock
*/

use salesshort;

#Show all customers (number and name) without any orders

select c.customerNumber, c.customerName from customers c
	left join orders o on o.customerNumber = c.customerNumber
    where o.orderNumber is null;
    
# How many products don't have an order?
select * from products p
	left join orderdetails od on od.productCode = p.productCode
    where od.orderNumber is null;

# Show all productlines (product line and description) that don’t have products

select pl.productLine, pl.textDescription from productlines pl
	left join products p on p.productLine = pl.productLine
    where p.productLine is null;
    
# How many customers don’t have orders?

select * from customers c
	left join orders o on o.customerNumber = c.customerNumber
    where o.customerNumber is null;
    
# Create a list with customername or productvendor, the product code and quantity sold (for the customers) and quantityinstock for the vendors. Create a new column customer/vendor depending on where the information comes from. Order by productcode (A-Z) and quantity (highest qty to lowest) 

select c.customerName, od.productCode, sum(od.quantityOrdered) as quantity, "customer" as source from customers c
	left join orders o on o.customerNumber = c.customerNumber
    left join orderdetails od on od.orderNumber = o.orderNumber
    group by od.productCode
union
select p.productVendor, p.productCode, sum(od.quantityOrdered) as quantity, "vendor" as source from products p
	left join orderdetails od on od.productCode = p.productCode
    group by p.productCode
    order by productCode, quantity;