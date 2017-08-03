--Get a list of all users in California

SELECT username
FROM users JOIN states ON states.id=users.state_id
WHERE states.name = 'California'

--Get a list of all airports in Kadeton
SELECT long_name
FROM airports JOIN cities ON cities.id = airports.city_id
WHERE cities.name = 'Kadeton'

SELECT *
FROM airports JOIN cities ON cities.id = airports.city_id
WHERE cities.name = 'New Jeffrey'

--there is no city called Kadeton
SELECT *
FROM cities
WHERE name ILIKE 'k%'

--Get a list of all payment methods used on itineraries by the user with email address 'senger.krystel@marvin.io'
--no one with that email??
--'senger.krystel@marvin.io'
SELECT *
FROM users
WHERE email ILIKE 'senger%'
LIMIT 10

--so I used this dude
SELECT payment_method, username, itineraries.id AS flightNumber
FROM users JOIN itineraries ON user_id = users.id
WHERE email = 'kertzmann_brandon@schmeler.biz'
LIMIT 10;

---Get a list of prices of all flights whose origins are in Brooksfurt Probably International Airport.

--answer
SELECT price, airports.long_name
FROM airports JOIN flights on flights.origin_id = airports.id
WHERE airports.long_name = 'Brooksfurt Probably International Airport';


--Find a list of all Airport names and codes which connect to the airport coded LYT

SELECT origin.long_name AS origin, origin.code AS origin_code, destination.code AS destination_code FROM flights
  JOIN airports origin ON origin.id = flights.origin_id
  JOIN airports destination ON destination.id = flights.destination_id
  WHERE destination.code = 'NDL';


--Get a list of all airports visited by user Sophie McGlynn after January 1, 2012. (Hint, see if you can get a list of all ticket IDs first).


SELECT originAirport.long_name, destinationAirport.long_name
FROM tickets
JOIN itineraries ON itineraries.id = tickets.itinerary_id
JOIN users ON itineraries.user_id = users.id
JOIN flights ON tickets.flight_id = flights.id
JOIN airports AS originAirport ON flights.origin_id = originAirport.id
JOIN airports AS destinationAirport ON flights.destination_id = destinationAirport.id
WHERE users.first_name = 'Sophie'
AND users.last_name = 'McGlynn'
AND flights.departure_time > '2012-01-01 00:00:00';

--Queries 2: Aggregation
--Find the top 5 most expensive flights that end in California.
SELECT price, flights.id, states.name
FROM airports JOIN flights on flights.destination_id = airports.id
Join states ON airports.state_id
 = states.id
WHERE states.name = 'California'
ORDER BY flights.price DESC
LIMIT 5

--3: Find the shortest flight that username 'zora_johnson' took.

SELECT flights.id, flights.distance
FROM flights
JOIn tickets ON flights.id = tickets.flight_id
JOIN itineraries ON tickets.itinerary_id = itineraries.id
JOIN users ON users.id = itineraries.user_id
WHERE users.first_name = 'Sophie'
  AND users.last_name = 'McGlynn'
ORDER BY flights.distance
LIMIT 1;