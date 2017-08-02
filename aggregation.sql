-- 1. Find the top 5 most expensive flights that end in California.
SELECT flights.id, flights.price
FROM flights JOIN airports
ON (flights.destination_id = airports.id)
JOIN states ON (airports.state_id = states.id)
WHERE states.name = 'California' ORDER BY flights.price DESC LIMIT 5;

-- 2. Find the shortest flight that username 'zora_johnson' took.
SELECT flights.id, flights.arrival_time - flights.departure_time as duration
FROM users JOIN itineraries ON (users.id = itineraries.user_id)
JOIN tickets ON (itineraries.id = tickets.itinerary_id)
JOIN flights ON (tickets.flight_id = flights.id)
WHERE users.id = (
    SELECT id FROM users
    WHERE users.first_name = SPLIT_PART('Kailee Little', ' ', 1)
    AND users.last_name = SPLIT_PART('Kailee Little', ' ', 2)
)
ORDER BY duration LIMIT 1;

-- 3. Find the average flight distance for every city in California
SELECT SUM(flights.arrival_time - flights.departure_time) / COUNT(*) as average
FROM flights JOIN airports
ON ((flights.origin_id = airports.id) OR (flights.destination_id = airports.id))
JOIN states ON (airports.state_id = states.id)
WHERE states.name = 'California';

-- 4. Find the 3 users who spent the most money on flights in 2013
SELECT users.first_name || ' ' || users.last_name as name,
SUM(flights.price) as total FROM users
JOIN itineraries ON (users.id = itineraries.user_id)
JOIN tickets ON (itineraries.id = tickets.itinerary_id)
JOIN flights ON (tickets.flight_id = flights.id)
WHERE flights.arrival_time BETWEEN '2013-01-01'::date AND '2013-12-12 23:59:59'::date
GROUP BY name ORDER BY total DESC LIMIT 3;

-- 5. Count all flights to OR from the city of Smithshire that did not land in Delaware
SELECT COUNT(*) as flights_total
FROM flights JOIN airports
ON ((flights.origin_id = airports.id) OR (flights.destination_id = airports.id))
JOIN cities ON (airports.city_id = cities.id) JOIN states ON (states.id = airports.state_id)
WHERE states.name <> 'Delaware' AND cities.name = 'Port Jennings';

-- 6. Return the range of lengths of flights in the system(the maximum, and the minimum).
SELECT MAX(arrival_time - departure_time) AS max_duration,
  MIN(arrival_time - departure_time)
  AS min_duration FROM flights;

-- Queries Advanced
-- 1. Find the most popular travel destination for users who live in California.
SELECT * FROM flights JOIN tickets ON (flights.id = tickets.flight_id)
  JOIN itinerary ON (tickets.itinerary_id = itinerary.id)
  JOIN users ON (users.id = itinerary.user_id)
  WHERE user_id IN (SELECT users.id FROM users
  JOIN states ON (users.state_id = states.id)
  WHERE states.name = 'California';
