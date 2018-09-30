/*

Author: Jack Rothrock

*/

use salesshort;

# Which country is ‘Rovelli Gifts’ in? 
# Show all customers (incl. ‘Rovelli Gifts’) from that country. 
# Show customer number, customer name, city and country. Order by customer name (A-Z).

select c1.customerNumber, c1.customerName, c1.city, c1.country from customers c
	join customers c1 on c1.country = c.country
    where c.customerName = "Rovelli Gifts"
    order by c1.customerName;
    
# Determine the vendor for ‘1968 Ford Mustang’ and show the other products for that vendor (not ‘1968 Ford Mustang’). 
# Show product code, product name, productline. Order by product code (A-Z).

select p1.productCode, p1.productName, p1.productline, p1.productVendor from products p
	join products p1 on p1.productVendor = p.productVendor and p1.productName <> p.productName
	where p.productName = "1968 Ford Mustang";

# Which products did ‘Boards & Toys Co.’ buy? 
# Show the other customers ( not ‘Boards & Toys Co.’ who bought those products. 
# Show customer number, customer name, product code and product name. Order by product code (A-Z).

select c1.customerNumber, c1.customerName, p.productCode, p.productName from customers c
	join orders o on c.customerNumber = o.customerNumber
    join orderdetails od on od.orderNumber = o.orderNumber
    join products p on od.productCode = p.productCode
    join orderdetails od1 on od1.productCode = od.productCode and od1.orderNumber <> o.orderNumber
    join orders o1 on od1.orderNumber = o1.orderNumber
    join customers c1 on c1.customerNumber = o1.customerNumber
	where c.customerName = "Boards & Toys Co."
    order by p.productCode;