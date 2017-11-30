-- Queries 2: Adding in Aggregation

-- Find the top 5 most expensive flights that end in California.

SELECT *
FROM flights
JOIN airports ON(destination_id = airports.id)
JOIN states ON(airports.state_id  = states.id)
WHERE states.name = 'California'
ORDER BY price DESC
LIMIT 5;

-- Find the shortest flight that username 'emelia' took.

SELECT *
FROM flights
JOIN tickets ON flights.id=tickets.flight_id
WHERE itinerary_id = 291
ORDER BY (flights.arrival_time - flights.departure_time)
LIMIT 1;

-- Find the average flight distance for every city in California

SELECT cities.name, AVG(distance)
FROM airports JOIN states ON (states.id  = state_id)
JOIN flights ON (flights.destination_id = airports.id  OR flights.origin_id = airports.id)
JOIN cities ON (cities.id  = city_id)
WHERE states.name  = 'California'
GROUP BY cities.name;

-- Find the 3 users who spent the most money on flights in 2013

--users.id -> itinearies.id -> tickets.flight_id -> flights.price
/*
SELECT username, price
FROM users
JOIN itineraries ON (users.id = itineraries.id)
JOIN tickets ON (users.itinerary_id = tickets.itinerary_id)
JOIN flights ON (tickets.flight_id = flights.id)
GROUP BY users.username
ORDER BY sum(price) DESC
LIMIT 3;
 */

SELECT users.username, sum(price)
FROM flights JOIN tickets ON(flights.id = tickets.flight_id)
JOIN itineraries ON(itineraries.id = tickets.itinerary_id)
JOIN users ON (users.id = itineraries.user_id)
GROUP BY users.username
ORDER BY sum(price) DESC
limit 3;

-- Count all flights to OR from the city of Smithshire that did not land in Delaware

SELECT COUNT(flights.id)
FROM flights
JOIN airports ON (origin_id = airports.id or destination_id = airports.id)
JOIN cities ON (cities.id = airports.city_id)
JOIN states ON(states.id = airports.state_id)
WHERE cities.name = 'Smithhaven' and states.name != 'Delaware';

--city_id -> airpots.city_id (to get airports) -> flights (connecting origin & destination)

-- Return the range of lengths of flights in the system(the maximum, and the minimum).

SELECT min(arrival_time - departure_time), max(arrival_time - departure_time)
FROM flights;
