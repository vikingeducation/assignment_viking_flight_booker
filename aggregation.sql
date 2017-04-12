Find the top 5 most expensive flights that end in California.

SELECT price, origin_id AS "ORIGIN", states.name AS "Destination"
FROM flights
JOIN airports ON flights.destination_id=airports.id
JOIN states ON airports.state_id=states.id
WHERE states.name = 'California'
ORDER BY price DESC
LIMIT 5;


Find the shortest flight that username 'zora_johnson' took.

SELECT flights.id as "Flight ID", distance, username
FROM users
JOIN itineraries ON users.id = itineraries.user_id
JOIN tickets ON itineraries.id = tickets.itinerary_id
JOIN flights ON tickets.flight_id = flights.id
WHERE username = 'zora_johnson'
ORDER BY distance
LIMIT 1;

Find the average flight distance for every city in California

SELECT AVG(distance) AS "Average flight distance"
FROM flights
JOIN airports ON flights.origin_id=airports.id
JOIN states ON airports.state_id=states.id
JOIN cities ON airports.city_id=cities.id
WHERE states.name = 'California';


Find the 3 users who spent the most money on flights in 2013

SELECT
FROM users
JOIN itineraries ON users.id = itineraries.user_id
JOIN tickets ON itineraries.id = tickets.itinerary_id
JOIN flights ON tickets.flight_id = flights.id
WHERE 


Count all flights to OR from the city of Smithshire that did not land in Delaware
Return the range of lengths of flights in the system(the maximum, and the minimum).