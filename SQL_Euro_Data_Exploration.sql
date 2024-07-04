
--GENERAL EURO DATA
--Select data that we are going to use

select year, winner, final, matches, goals, red_cards
from dbo.euro_summary
order by 1,2;

--Looking at total amount of goals scored, matches played and red cards distributed throughout euro history

select sum(goals) as Total_goals, sum(matches) as Total_matches, sum(red_cards) as Total_red_cards
from dbo.euro_summary;

--Looking at Countries that won Euro tournament more than once

select winner, count(*) as Victories
from dbo.euro_summary
group by winner
having count(*)>1
order by Victories
desc

--Let's add results of final matches to the euro_summary table
ALTER TABLE dbo.euro_summary
add results varchar(50)

update dbo.euro_summary
set results = '2-1'
where year=1960

update dbo.euro_summary
set results = '2-1'
where year=1964

update dbo.euro_summary
set results = '1-1(2-0)'
where year=1968

update dbo.euro_summary
set results = '3-0'
where year=1972

update dbo.euro_summary
set results = '2-2 (k.5-3)'
where year=1976

update dbo.euro_summary
set results = '1-2'
where year=1980

update dbo.euro_summary
set results = '2-0'
where year=1984

update dbo.euro_summary
set results = '0-2'
where year=1988

update dbo.euro_summary
set results = '2-0'
where year=1992

update dbo.euro_summary
set results = '1-2(Golden Goal)'
where year=1996

update dbo.euro_summary
set results = '2-1(Golden Goal)'
where year=2000

update dbo.euro_summary
set results = '0-1'
where year=2004

update dbo.euro_summary
set results = '0-1'
where year=2008

update dbo.euro_summary
set results = '4-0'
where year=2012

update dbo.euro_summary
set results = '0-0(dogr.1-0)'
where year=2016

update dbo.euro_summary
set results = '1-1(k.3-2)'
where year=2020

--Looking at final matches that did not end after 90 minutes

select year, winner, final, results
from dbo.euro_summary
where not results like '___'
order by 1
asc

--Looking at max goals, average attendance and red cars throughout euro history

select max(goals) as Max_goals, avg(red_cards) as Avg_red_cards, avg(attendance) as Avg_attendance
from dbo.euro_summary

--EURO LINEUPS
--Select data that we are going to use without nulls

select country_code, name, jersey_number, position_field, year, height, weight
from dbo.euro_lineups
where country_code is not null and position_field is not null and height is not null and weight is not null
order by year
asc


-- Let's see Average age and height of players in each Euro tournaments by Country 

select year,country_code, avg(height) as Avg_height, avg(year-year(birth_date)) as Age
from dbo.euro_lineups
where country_code is not null
group by year, country_code
order by year, country_code
desc
-- Let's see who weighted over 100 kg

select name, max(weight) as Max_Weight 
from dbo.euro_lineups
group by name
having max(weight)>100

--Let's see if Cristiano Ronaldo's weight has changed over the years

select name, max(weight), year
from dbo.euro_lineups
where name = 'Cristiano Ronaldo'
group by year,name


-- Let's break down players into field players and goalkeepers

select country_code, name, jersey_number, year, height, weight,
CASE
WHEN position_field = 'GOALKEEPER' THEN 'Goalkeeper'
WHEN position_field = 'FORWARD' or position_field = 'DEFENDER' or position_field = 'MIDFIELDER' THEN 'Field Player'
END 'Pos_type'
from dbo.euro_lineups
where position_field is not null
order by 1,2;


--Creating view to store data for later visualisations

CREATE VIEW EURO_DATA AS
select l.country_code,l.name,(l.year-year(l.birth_date)) as Age, l.position_field, l.jersey_number, l.year, l.height, l.weight, c.name as Coach
from dbo.euro_lineups l INNER JOIN dbo.euro_coaches c
on l.country_code=c.country_code
and l.year=c.year
where l.country_code is not null
AND position_field is not null
AND height is not null
AND weight is not null












