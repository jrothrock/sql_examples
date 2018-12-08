use jaro6612projecttest;

##########
# Marketing
##########

# Which 5 customers have the oldest accounts?
select u.first as 'First Name', u.last as 'Last Name', c.created_at as 'Account Creation Date'from Customer c
	join user u on c.id = u.Customer_id
    group by c.id 
    having c.created_at <=
        (select max(sq1.created_at) from
			(select distinct c.created_at from Customer c
				group by c.id
				order by c.created_at asc 
                limit 5) sq1)
    order by c.created_at asc;
 
# Which state has the most customers?
select state, count(c.id) as 'Total Customers in State'from Customer c
	group by c.state
    having  count(c.id) >=
		(select count(c.id) as TotalState from Customer c
			group by c.state
			order by count(state) desc
			limit 1);
    
# Which vendor has the highest sales?
select v.name, sum(b.price * cod.quantity) as "Total Sales" from vendor v
    join beer b on b.vendor_id = v.id
    join customer_order_details cod on cod.beer_id = b.id
    group by v.id
    having sum(b.price * cod.quantity) >= 
		(select sum(b.price * cod.quantity) from vendor v
			join beer b on b.vendor_id = v.id
			join customer_order_details cod on cod.beer_id = b.id
			group by v.id
			order by  sum(b.price * cod.quantity) desc
            limit 1);
 
 
 ##########
 # Project Management
 ##########
    
 # Which beer type has the most sales?
select beer.type, sum(beer.price*cod.quantity) as 'gross_sales' from beer
	join customer_order_details cod on beer.id = cod.beer_id
    group by beer.type
    having sum(beer.price*cod.quantity) >= 
		(select sum(beer.price*cod.quantity) as 'gross_sales' from beer
			join customer_order_details cod on beer.id = cod.beer_id
			group by beer.type
			order by gross_sales desc
            limit 1);

# Which beer size has the most sales?
select beer.size, sum(beer.price*cod.quantity) as 'gross_sales'  from beer
	join customer_order_details cod on beer.id = cod.beer_id
    group by beer.size
    having sum(beer.price*cod.quantity) >=
		(select sum(beer.price*cod.quantity) as 'gross_sales'  from beer
			join customer_order_details cod on beer.id = cod.beer_id
			group by beer.size
			order by gross_sales desc
            limit 1);
    
# Which active beer has sold the most in the least amount of time?
select beer.id, beer.name, sum(beer.price*inv_od.quantity) as 'gross_sales', datediff(now(), beer.created_at) as 'days_on_market', 
sum(beer.price*inv_od.quantity)/datediff(now(), beer.created_at) as 'avg_sales_per_day' from beer
	join inventory_purchase_order_details inv_od on beer.id = inv_od.beer_id
    where active = 1
    group by beer.id
    having avg_sales_per_day >= (
		select sum(beer.price*inv_od.quantity)/datediff(now(), beer.created_at) as 'avg_sales_per_day' from beer
			join inventory_purchase_order_details inv_od on beer.id = inv_od.beer_id
			where active = 1
			group by beer.id
			order by avg_sales_per_day desc
			limit 1);
    
##########
# Sales   
##########

# Which vendor has the highest sales?
select v.name, sum(cod.quantity * b.price) as "Total Sales" from vendor v
	join beer b on b.vendor_id = v.id
	join customer_order_details cod on cod.beer_id = b.id
	group by v.id
	having sum(cod.quantity * b.price) >=
		(select sum(cod.quantity * b.price) as "Total Sales" from vendor v
			join beer b on b.vendor_id = v.id
			join customer_order_details cod on cod.beer_id = b.id
			group by v.id
			order by sum(cod.quantity * b.price) desc
			limit 1);

# Which country has the highest sales?
select v.country, sum(cod.quantity * b.price) as "Total Sales" from vendor v
	join beer b on b.vendor_id = v.id
	join customer_order_details cod on cod.beer_id = b.id
	group by v.country
	having sum(cod.quantity * b.price)  >=
		(select sum(cod.quantity * b.price) as "Total Sales" from vendor v
			join beer b on b.vendor_id = v.id
			join customer_order_details cod on cod.beer_id = b.id
			group by v.country
			order by sum(cod.quantity * b.price) desc
			limit 1);

# Which microbrewer has the longest-offered, active beer?
select v.name as 'Vendor', b.name as 'Beer',  b.created_at from beer b
	join vendor v on b.vendor_id = v.id
    where b.active = 1 and b.created_at <= 
		(select b.created_at from beer b
			join vendor v on b.vendor_id = v.id
			where b.active = 1
			order by b.created_at asc
			limit 1);