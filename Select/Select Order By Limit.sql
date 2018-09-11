# Create a report with the country name, LocalName and HeadofState ordered by country name ascending

use world;

# Create a report with the country name, LocalName and HeadofState ordered by country name ascending
select name, localname, headofstate from country order by name asc;

# Create a report with the population density by country descending

select (population / surfacearea) as "population density" from country order by name desc;

#Create a report with the country name and difference in GNP ordered by the country with the highest GNP gain on top

select name, (gnp - gnpold) as difference from country order by difference desc;

#Create a report with continent, region, country, population ordered by continent (A-Z) and within continent by population (highest to lowest)

select name, region, continent, population from country order by name desc, population desc;

# Create a report with the country name and difference in GNP ordered by the country with the highest GNP gain on top. Show only the first 5 rows

select name, (gnp - gnpold) as difference from country order by difference desc limit 5;
