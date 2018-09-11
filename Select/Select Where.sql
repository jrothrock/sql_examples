/*

Author: Jack Rothrock

*/


use salesshort;

# Show the customer number, customer name, city and country for all customers from Germany. Order by customer name (A-Z)

select customerNumber, customerName, city, country from customers where country = "Germany" order by customerName asc;

# Show all products that have “Harley” in their name. Order by productline (A-Z) and within product line by quantity in stock (lowest to highest)

select * from products where productName like "%Harley%" order by productline asc, quantityInStock asc;

# Show productcode, productname and margin (msrp – buyPrice). Show only products with margins greater than 50. Order by highest to lowest margin. 

select productcode, productname, (msrp - buyPrice) as margin from products where (msrp - buyPrice) > 50 order by margin desc;

# Show all the orders that have a comment

select * from orders where comments is not null;

# Show all the orders that have not been shipped.

select * from orders where shippedDate is null;

# Show all products ordered by MSRP. Show only the first ten rows. 

select * from products order by msrp limit 10;

# Show all customers (customer name, contact first and last name, credit limit) where the first name of the contact has 5 characters. Order by last name (A-Z)

select customerName, contactFirstName, contactLastName, creditLimit from customers where contactFirstName like "_____" order by contactLastName asc;

# Show all products (name, line, description) where the scale is 1:10. Order by line (A-Z) and within line by name

select productName, productLine, productDescription from products where productscale = "1:10" order by productLine asc, productLine;

# Show all order details where the total price is greater than 500 and lower than 1000. Order by total price descending. 

select *, (priceEach * quantityOrdered) as "total price" from orderdetails where (priceEach * quantityOrdered) between 500 and 1000 order by (priceEach * quantityOrdered) desc;

# Show all customers from USA with a credit limit greater than 100000

select * from customers  where country = "USA" and creditLimit > 100000;
