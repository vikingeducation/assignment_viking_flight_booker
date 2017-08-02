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

SELECT flight_id
FROM flights
WHERE flights.destination_id = 'california'
