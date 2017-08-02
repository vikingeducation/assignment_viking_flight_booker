-- airports, users, cities, states, flights,


-- 1. Get a list of all users in California
SELECT *
FROM users
JOIN states ON (users.state_id = states.id)
WHERE states.name = 'California';

-- 2.Get a list of all airports in Kadeton


SELECT *
FROM airports
JOIN cities ON (cities.id = airports.city_id)
WHERE name = 'Kadenview';

3.

-- hansen.lawson@marvin.io

SELECT payment_method;
FROM itineraries;
JOIN users ON (itineraries.user_id = users.id);
WHERE users.email = 'hansen.lawson@marvin.io';

SELECT price
FROM flights JOIN airports ON (flights.origin_id = airports.city_id)
WHERE airports.long_name = 'Kochview Probably International Airport'

SELECT airports.long_name,
airports.code
FROM airports JOIN flights ON (flights.destination_id = airports.id)
WHERE airports.code = 'ZAM';

SELECT airports.long_name
FROM airports JOIN flights on (airports.id = flights.destination_id)
JOIN tickets on (tickets.flight_id = flights.id)
JOIN itineraries on (tickets.itinerary_id = itineraries.id)
JOIN users on (itineraries.user_id = users.id)
WHERE users.email = 'hansen.lawson@marvin.io' AND flights.departure_time >= '2012-01-01 16:10:28.273072';

SELECT flights.id,
flights.price
FROM flights JOIN airports ON (flights.destination_id = airports.id)
JOIN states ON (states.id = airports.state_id)
WHERE states.name = 'California'
ORDER BY flights.price DESC
limit 5

SELECT flights.id,
flights.distance
FROM flights JOIN tickets ON (flights.id = tickets.flight_id)
JOIN itineraries ON (itineraries.id = tickets.itinerary_id)
JOIN users ON (users.id = itineraries.user_id)
WHERE users.email = 'hansen.lawson@marvin.io'
ORDER BY flights.distance DESC
limit 1

SELECT AVG(flights.distance)
FROM flights JOIN airports ON (flights.origin_id = airports.id)
JOIN states ON (states.id = airports.state_id)
WHERE states.name = 'California'

SELECT users.username,
SUM(flights.price) as totalPrice
FROM flights JOIN tickets ON (flights.id = tickets.flight_id)
JOIN itineraries ON (itineraries.id = tickets.itinerary_id)
JOIN users ON (users.id = itineraries.user_id)
GROUP BY users.username
ORDER BY totalPrice DESC
limit 5

SELECT COUNT(flights.id)
FROM flights JOIN airports ON (flights.destination_id = airports.id)
JOIN states ON (airports.state_id = state.id) AS DestState
JOIN airports ON (flights.origin_id = airports.id)
WHERE DestState.state_id != 'Delaware'
