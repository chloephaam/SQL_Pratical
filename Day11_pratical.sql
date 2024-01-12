
select t2.continent as continent,
floor(avg(t1.population))
from city as t1
left join country as t2
on t1.CountryCode=t2.Code
where continent is not NULL
group by t2.continent
