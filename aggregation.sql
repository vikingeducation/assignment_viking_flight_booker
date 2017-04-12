-- Queries 2: Adding in Aggregation

-- Find the top 5 most expensive flights that end in California.
SELECT flights.id, flights.price
FROM flights
JOIN airports
ON flights.destination_id = airports.id
JOIN states
ON states.id = airports.state_id AND states.name = 'California'
ORDER BY flights.price DESC
LIMIT 5;

-- Find the shortest flight that username 'zora_johnson' took.
SELECT users.first_name, users.last_name, users.username, flights.id as flight_id, flights.distance
FROM users
JOIN itineraries
ON itineraries.user_id = users.id
JOIN tickets
ON tickets.itinerary_id = itineraries.id
JOIN flights
ON flights.id = tickets.flight_id
WHERE username = 'zora_johnson'
ORDER BY distance ASC
LIMIT 1;

-- Find the average flight distance for every city in California
-- Note: I assume this means just every flight that starts in California. If it means every flight that both starts and stops in California, the query will be different.
SELECT AVG(distance) as flight_distance, cities.name as city_name, states.name
FROM flights
JOIN airports
ON flights.origin_id = airports.id
JOIN states
ON airports.state_id = states.id
JOIN cities
ON airports.city_id = cities.id
WHERE states.name = 'California'
GROUP BY city_name, states.name
order by city_name;

-- Find the 3 users who spent the most money on flights in 2013
SELECT users.first_name, users.last_name, SUM(price) as total_spent
from USERS
JOIN itineraries
ON itineraries.user_id = users.id
JOIN tickets
ON tickets.itinerary_id = itineraries.id
JOIN flights
ON flights.id = tickets.flight_id
WHERE flights.departure_time BETWEEN '2013-01-01'::date AND '2013-12-31'::date
GROUP BY users.last_name, users.first_name
ORDER BY total_spent DESC
LIMIT 3;

-- Count all flights to OR from the city of Smithshire that did not land in Delaware
-- View:
SELECT
  flights.id as flight_id,
  A.id as origin,
  B.id as destination,
  origin_states.name as origin_state,
  origin.name as origin_city,
  destination.name as destination_city,
  destination_states.name as destination_state
FROM flights
JOIN airports A
ON A.id = flights.origin_id
JOIN states origin_states
ON A.state_id = origin_states.id
JOIN airports B
on B.id = flights.destination_id
JOIN states destination_states
ON B.state_id = destination_states.id AND destination_states.name <> 'Delaware'
JOIN cities origin
ON A.city_id = origin.id
JOIN cities destination
ON B.city_id = destination.id
AND
(origin.name = 'Smithshire' OR
  destination.name = 'Smithshire');

-- Count:
SELECT
  count(*) as flight_count
FROM flights
JOIN airports A
ON A.id = flights.origin_id
JOIN states origin_states
ON A.state_id = origin_states.id
JOIN airports B
on B.id = flights.destination_id
JOIN states destination_states
ON B.state_id = destination_states.id AND destination_states.name <> 'Delaware'
JOIN cities origin
ON A.city_id = origin.id
JOIN cities destination
ON B.city_id = destination.id
AND
(origin.name = 'Smithshire' OR
  destination.name = 'Smithshire');


-- Return the range of lengths of flights in the system(the maximum, and the minimum).
select MIN(distance) as min, MAX(distance) as max, MAX(distance) - MIN(distance) as range
from flights;










