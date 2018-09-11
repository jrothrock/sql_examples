/*
Author: Jack Rothrock
*/

use SalesShort;

#show tables;

# Select all columns from the customer table
select * from customers;

# Select the customer name, creditlimit and phone from the customer table
select customerName, Round(creditLimit,2) as creditLimit, phone from customers;

# Show all the distinct contact first names from the customer table
select distinct contactFirstName from customers;

# Show all columns from the orders table
select * from orders;

# Select ordernumber, orderdate and shipped date from the orders table
select orderNumber, orderDate, shippedDate from orders;

# Select all columns from the orders details table
select * from orderdetails;

# Show the ordernumber, quantity, price and total price from the order details table. Name the columns, ‘Order’, ‘Qty’, ‘Price’ ‘Total Price’
select ordernumber as "Order", quantityOrdered as "Qty", priceEach as "Price", (priceEach * orderLineNumber) as "Total Price" from orderdetails;

# Show the product name, product description, buyPrice, MSRP and the difference between buyPrice and MSRP from the products table. Name the difference “Potential Profit”.
select productName, productDescription, buyPrice, MSRP, (buyPrice - MSRP) as "Potential Profit" from products;

# Show all columns from the product line table
select * from productlines;

# Show all product lines (only once) from the product table
select distinct productLine from products;