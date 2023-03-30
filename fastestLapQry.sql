use formula_db;
SELECT distinct 
  races.year,
  circuits.name AS circuit,
  results.fastestLap,
  fastest_lap.lap,
  fastest_lap.milliseconds AS avglap,
  1 as podium
FROM results
JOIN (
  SELECT raceId, MIN(milliseconds) AS min_milliseconds
  FROM laptimes
  GROUP BY raceId
) AS fastest_times ON fastest_times.raceId = results.raceId
JOIN laptimes AS fastest_lap ON fastest_lap.raceId = results.raceId
  AND fastest_lap.milliseconds = fastest_times.min_milliseconds
JOIN races ON results.raceId = races.raceId
JOIN circuits ON circuits.circuitID = races.circuitID
WHERE races.year >= 2014
  AND races.year < 2023
  AND results.milliseconds IS NOT NULL
  AND results.position IS NOT NULL
  AND fastest_lap.lap = results.fastestLap
ORDER BY races.year, circuits.name

