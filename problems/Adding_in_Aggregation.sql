-- Find the top 5 most expensive flights that end in California.
SELECT flights.*
FROM flights JOIN airports ON flights.destination_id = airports.id
      JOIN states ON airports.state_id = states.id
WHERE states.name = 'California'
ORDER BY flights.price DESC
LIMIT 5;
-- Find the shortest flight that username 'zora_johnson' took.
SELECT flights.*
FROM users JOIN itineraries ON users.id = itineraries.user_id
    JOIN tickets ON itineraries.id = tickets.itinerary_id
    JOIN flights ON tickets.flight_id = flights.id
WHERE users.username = 'zora_johnson'
ORDER BY flights.arrival_time - flights.departure_time
LIMIT 1;
-- Find the average flight distance for every city in California
SELECT cities.name, AVG(flights.distance)
FROM flights JOIN airports ON flights.origin_id = airports.id
  JOIN states ON airports.state_id = states.id
  JOIN cities ON airports.city_id = cities.id
WHERE states.name = 'California'
GROUP BY cities.name
ORDER BY AVG(flights.distance);
-- Find the 3 users who spent the most money on flights in 2013
SELECT users.username, SUM(flights.price)
FROM flights JOIN tickets ON flights.id = tickets.flight_id
  JOIN itineraries ON tickets.itinerary_id = itineraries.id
  JOIN users ON itineraries.user_id = users.id
WHERE flights.departure_time > '2012-12-31 23:59:59.99' AND flights.departure_time < '2014-01-01 00:00:00.01'
GROUP BY users.username
ORDER BY SUM(flights.price) DESC
LIMIT 3;
-- Count all flights to OR from the city of Smithshire that did not land in Delaware
SELECT COUNT(flights.*) + (
    SELECT COUNT(flights.*)
    FROM flights JOIN airports ON flights.destination_id = airports.id
      JOIN cities ON airports.city_id = cities.id
      JOIN states ON airports.state_id = states.id
    WHERE cities.name = 'Smithshire'
    ) - (
      SELECT COUNT(flights.*)
    FROM flights JOIN airports ON flights.destination_id = airports.id OR flights.origin_id = airports.id
      JOIN cities ON airports.city_id = cities.id
      JOIN states ON airports.state_id = states.id
    WHERE cities.name = 'Smithshire' AND states.name = 'Delaware'
)
FROM flights JOIN airports ON flights.origin_id = airports.id
  JOIN cities ON airports.city_id = cities.id
  JOIN states ON airports.state_id = states.id
WHERE cities.name = 'Smithshire';
-- Return the range of lengths of flights in the system(the maximum, and the minimum).
SELECT MAX(distance), MIN(distance)
FROM flights;
