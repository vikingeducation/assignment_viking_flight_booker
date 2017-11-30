-- Get a list of all users in California

SELECT *
FROM users
WHERE state_id=215

-- Get a list of all airports in Gwendolynfort

SELECT *
FROM airports
WHERE city_id=863;

-- Get a list of all payment methods used on itineraries by the user with email address 'kallie.weimann@dach.biz'

SELECT *
FROM itineraries
WHERE user_id=429;

-- Get a list of prices of all flights whose origins are in Port Gerardbury Probably International Airport.

SELECT *
FROM flights
WHERE origin_id=1

-- Find a list of all Airport names and codes which connect to the airport coded ZAM.

SELECT * FROM airports WHERE code='ZAM';

-- Get a list of all airports visited by user Sophie McGlynn after January 1, 2012. (Hint, see if you can get a list of all ticket IDs first).

SELECT long_name FROM flights JOIN tickets ON flights.id=tickets.flight_id JOIN airports ON (origin_id = airports.id  OR destination_id = airports.id) WHERE itinerary_id = 291;
