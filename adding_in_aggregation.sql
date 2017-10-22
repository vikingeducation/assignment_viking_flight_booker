-- 1. Find the top 5 most expensive flights that end in California.
SELECT flights.id AS "Flight ID", flights.price AS "Price"
FROM flights
  JOIN airports
    ON flights.destination_id = airports.id
  JOIN states
    ON airports.state_id = states.id
WHERE states.name LIKE 'California'
ORDER BY flights.price DESC
LIMIT 5;

-- 2. Find the shortest flight that username 'emelia' took.
SELECT flights.id AS "Flight ID", (arrival_time - departure_time) AS duration
FROM flights
  JOIN tickets
    ON flights.id = tickets.flight_id
  JOIN itineraries
    ON tickets.itinerary_id = itineraries.id
  JOIN users
    ON itineraries.user_id = users.id
WHERE users.username = 'emelia'
ORDER BY (arrival_time - departure_time)
LIMIT 1;

-- 3. Find the average flight distance for every city in California
SELECT cities.name, ROUND(AVG(flights.distance)) AS avg_flight_distance
FROM cities
  JOIN airports
    ON cities.id = airports.city_id
  JOIN states
    ON airports.state_id = states.id
  JOIN flights
    ON airports.id = flights.origin_id OR airports.id = flights.destination_id
WHERE states.name = 'California'
GROUP BY cities.name;

-- 4. Find the 3 users who spent the most money on flights in 2013
SELECT users.first_name, users.last_name, ROUND(SUM(flights.price)) AS total_spent
FROM users
  JOIN itineraries
    ON users.id = itineraries.user_id
  JOIN tickets
    ON itineraries.id = tickets.itinerary_id
  JOIN flights
    ON tickets.flight_id = flights.id
WHERE EXTRACT(YEAR FROM flights.departure_time) = 2013
GROUP BY users.last_name, users.first_name
ORDER BY 3 DESC
LIMIT 3;

-- 5. Count all flights to OR from the city of Smithhaven that did not land in Delaware
SELECT COUNT(*)/2
FROM flights
  JOIN airports
    ON airports.id = flights.origin_id OR airports.id = flights.destination_id
WHERE (flights.origin_id = (SELECT id FROM cities WHERE name LIKE 'Smithhaven')
OR flights.destination_id = (SELECT id FROM cities WHERE name LIKE 'Smithhaven'))
AND (SELECT id FROM states WHERE name LIKE 'Delaware') != airports.state_id;

-- 6. Return the range of lengths of flights in the system(the maximum, and the minimum).
SELECT MIN(arrival_time - departure_time), MAX(arrival_time - departure_time)
FROM flights;
