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

---Get a list of prices of all flights whose origins are in Kochfurt Probably International Airport.
SELECT *
FROM airports
WHERE long_name = 'Kochfurt Probably International Airport'
--returns nothing

--answer
SELECT price, airports.long_name
FROM airports JOIN flights on flights.origin_id = airports.id
WHERE airports.long_name = 'Brooksfurt Probably International Airport';


--Find a list of all Airport names and codes which connect to the airport coded LYT
SELECT *
FROM airports
WHERE code = 'NDL';

SELECT long_name, code
FROM flights
JOIN airports AS destination ON flights.destination_id = destination.id
WHERE destination.code = 'NDL';


JOIN airports source ON flight.origin_id = source.id
--Get a list of all airports visited by user Krystel Senger after January 1, 2012. (Hint, see if you can get a list of all ticket IDs first).

CREATE TABLE tickets (
    id integer NOT NULL,
    itinerary_id integer,
    flight_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);
SELECT * FROM tickets JOIN flights LIMIT 10

--use ticket to grab flight to grab user_id
SELECT *
FROM users
JOIN tickets ON tickets.user_id = id
JOIN itineraries ON itineraries.user_id = tickets.itinerary_id
WHERE users.first_name = 'Krystel'
AND users.last_name = 'Senger'

SELECT *
FROM tickets
JOIN itineraries ON itineraries.id = tickets.itinerary_id
JOIN users ON itineraries.user_id = users.id
WHERE users.first_name = 'Krystel'
AND users.last_name = 'Senger'



SELECT * FROM tickets JOIN itineraries ON itineraries.user_id = tickets.itinerary_id LIMIT 10
SELECT * FROM tickets
SELECT * FROM flights
SELECT * FROM users
SELECT * FROM itineraries
--SCRAP CODE

SELECT * FROM users
WHERE username ILIKE '%kry%';
SELECT price, airports.long_name
FROM airports JOIN flights on flights.origin_id = airports.id
WHERE airports.long_name = 'Brooksfurt Probably International Airport';


SELECT *
FROM itineraries
LIMIT 10;

SELECT *
FROM users
WHERE id = 427;
