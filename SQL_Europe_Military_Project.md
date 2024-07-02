--Table joints--
select Country, act_military, reserve_military, paramilitary, Total, capita_total, capitaact, region
from list_of_countries inner join continents2
on list_of_countries.Country = continents2.ď»żname
where region='Europe';

select Country, pop2022, region
from army_total_world inner join continents2
on army_total_world.Country = continents2.ď»żname
where region = 'Europe'
