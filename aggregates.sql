-- Find the top 5 most expensive flights that end in California.
SELECT COUNT(flights.id)
FROM flights
WHERE flights.destination_id IN (
      SELECT airports.id
      FROM airports
      JOIN flights ON airports.id = flights.destination_id
      WHERE airports.state_id IN (
            SELECT states.id
            FROM states
            JOIN airports ON states.id = airports.state_id
            WHERE states.name = 'California'
      )
);

-- Find the shortest flight that username 'emelia' took.
SELECT users.username, flights.id, flights.distance
FROM users
    JOIN itineraries ON itineraries.user_id = users.id
    JOIN tickets ON tickets.itinerary_id = itineraries.id
    JOIN flights ON flights.id = tickets.flight_id
WHERE users.username = 'emelia'
ORDER BY flights.distance
Limit 1;

-- Find the average flight distance for every city in California
SELECT cities.name, AVG(flights.distance)
FROM flights
    JOIN airports ON airports.id = flights.origin_id
    OR airports.id = flights.destination_id
    JOIN cities ON cities.id = airports.city_id
WHERE airports.state_id IN (
      SELECT states.id
      FROM states
      JOIN airports ON states.id = airports.state_id
      WHERE states.name = 'California'
)
GROUP BY cities.name;

-- Find the 3 users who spent the most money on flights in 2013
SELECT users.username, SUM(flights.price)
FROM users
    JOIN itineraries ON users.id = itineraries.user_id
    JOIN tickets ON itineraries.id = tickets.itinerary_id
    JOIN  flights ON tickets.flight_id = flights.id
GROUP BY users.username
ORDER BY SUM(flights.price) DESC
LIMIT 3;

-- Count all flights to OR from the city of Smithshire that did not land in Delaware
SELECT cities.name
FROM cities
WHERE cities.name = 'Smithshire';

-- -------
--     0
-- (1 row)
-- Theres no damn city Smithshire

SELECT COUNT(flights.id)
FROM flights
  JOIN airports ON flights.origin_id = airports.id
    OR flights.destination_id = airports.id
  JOIN cities ON airports.city_id = cities.id
WHERE airports.city_id IN (
  SELECT cities.id
  FROM cities
  WHERE cities.name = 'Sporermouth'
)
AND flights.destination_id IN (
  SELECT flights.destination_id
  FROM flights
    JOIN airports ON flights.origin_id = airports.id
      OR flights.destination_id = airports.id
    JOIN states ON airports.state_id = states.id
  WHERE states.name != 'Delaware'
);

-- Return the range of lengths of flights in the system(the maximum, and the minimum).
SELECT MAX(flights.distance), MIN(flights.distance)
FROM flights;
