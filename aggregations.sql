-- Queries 2: Adding in Aggregation

-- Find the top 5 most expensive flights that end in California.
SELECT flights.price AS most_expensive
FROM flights
JOIN airports ON flights.destination_id = airports.id
JOIN states ON airports.state_id = states.id
WHERE states.name = 'California'
ORDER BY most_expensive DESC
LIMIT 5;


-- Find the shortest flight that username 'emelia' took.
SELECT flights.distance AS shortest_flight
FROM flights
JOIN tickets ON flights.id = tickets.flight_id
JOIN itineraries ON tickets.itinerary_id = itineraries.id
JOIN users ON itineraries.user_id = users.id
WHERE users.username = 'emelia'
ORDER BY shortest_flight
LIMIT 1;


-- Find the average flight distance for every city in California
SELECT cities.name AS city, AVG(flights.distance)
FROM flights
JOIN airports ON flights.origin_id = airports.id
JOIN states ON airports.state_id = states.id
JOIN cities ON airports.city_id = cities.id
WHERE states.name = 'California'
GROUP BY city;

-- Find the 3 users who spent the most money on flights in 2013
SELECT concat_ws(' ', first_name::text, last_name::text) AS spender, SUM(flights.price) 
FROM flights
JOIN tickets ON flights.id = tickets.flight_id
JOIN itineraries ON itineraries.id = tickets.itinerary_id
JOIN users ON users.id = itineraries.user_id
WHERE flights.arrival_time >= '2013-01-01' AND flights.arrival_time < '2014-01-01'
	AND flights.departure_time >= '2013-01-01' AND flights.departure_time < '2014-01-01'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 3;


-- Count all flights to OR from the city of Smithshire that did not land in Delaware
SELECT COUNT(*) 
FROM flights
JOIN airports orig ON flights.origin_id = orig.id
JOIN airports dest ON flights.destination_id = dest.id
JOIN states orig_state ON orig.state_id = orig_state.id
JOIN states dest_state ON dest.state_id = dest_state.id
JOIN cities orig_city ON orig.city_id = orig_city.id
JOIN cities dest_city ON dest.city_id = dest_city.id
WHERE orig_city.name = 'Smithshire' OR  dest_city.name = 'Smithshire'
	AND dest_state.name = 'Oregon' AND dest_state.name != 'Delaware';


-- Return the range of lengths of flights in the system(the maximum, and the minimum).
SELECT MAX(flights.distance), MIN(flights.distance)
  FROM flights;