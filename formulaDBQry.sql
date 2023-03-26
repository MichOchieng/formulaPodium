use formula_db;
-- alter table results
-- add avglap decimal(10,2) generated always as (results.milliseconds / results.laps) virtual;
select 
	results.laps, 
    results.milliseconds, 
    results.avglap,
    constructors.name as constructor,
    races.year,
    circuits.name as circuit,
case 
	when results.position <= 3 and results.position > 0 then 1
    else 0
end as podium
from results 
	join races on results.raceId = races.raceId
    join circuits on circuits.circuitID = races.circuitID
    join constructors on results.constructorId = constructors.constructorId
where 
	races.year >= 2014 and 
    races.year < 2023 and
    results.milliseconds is not null and
    results.position is not null
order by circuits.name, races.year
