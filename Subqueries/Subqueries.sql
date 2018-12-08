/*
 Author: Jack Rothrock
*/

use world;

# Step 1
select distinct population from city
	order by population desc
    limit 10;
# Step 2
select min(population) from 
	(select distinct population from city
	order by population desc
    limit 10) sq;
    
## This has to be done, as there are 11 rows returned, as the last one has a population with the same value
select name as "city", population from city 
	where population >=
		( select min(population) from 
			(select distinct population from city
				order by population desc
				limit 10) sq);
    
    
    
 # List the bottom 5 countries in Africa based on population 
  
# step 1
select name, max(population) from (select distinct name, population from country
	where continent = "Africa"
	order by population asc
    limit 5) sq;


select  name as "country", population from country
	where population <= 
		(select max(population) from 
			(select distinct name, population from country
				where continent = "Africa"
				order by population asc
				limit 5) sq)
    and continent = "Africa";
    
    
# list the bottom 3 regions in europe based on population

# Step 1
select region, sum(population) from country
	where continent = "Europe"
	group by region
    order by sum(population) asc
    limit 3;
 
# Step 2 
(select max(sumpop) from (select region, sum(population) as sumpop from country
	where continent = "Europe"
	group by region
    order by sum(population) asc
    limit 3) sq);
    
select region, sum(population) from country
	where continent = "Europe"
    group by region
    having sum(population) <= 
		(select max(sumpop) from 
			(select region, sum(population) as sumpop from country
				where continent = "Europe"
				group by region
				order by sum(population) asc
				limit 3) sq);
    
    
# List the continents by highest population, then by regions with the highest population, then countries with highest population

select lecont.continent, lereg.region, lecountry.name, lecont.average, lereg.average, lecountry.average  from
		(select continent, avg(lifeexpectancy) average from country 
				group by continent) lecont
		join 
			(select continent, region, avg(lifeexpectancy) average from country 
				group by continent, region) lereg
		on lecont.continent = lereg.continent
        join
			(select continent, region, name, avg(lifeexpectancy) average from country 
				group by continent, region, name) lecountry
		on lereg.region = lecountry.region
        order by lecont.average desc, lereg.average desc, lecountry.average desc;