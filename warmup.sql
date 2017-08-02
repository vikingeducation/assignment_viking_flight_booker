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
WHERE cities.name = 'Kadeton'

--there is no city called Kadeton
--SELECT *
--FROM cities
--WHERE name ILIKE 'k%'

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
SELECT airports.long_name, code
FROM airports
WHERE code LIKE 'LYT'
LIMIT 5


--SCRAP CODE
SELECT price, airports.long_name
FROM airports JOIN flights on flights.origin_id = airports.id
WHERE airports.long_name = 'Brooksfurt Probably International Airport';


SELECT *
FROM itineraries
LIMIT 10;

SELECT *
FROM users
WHERE id = 427;
