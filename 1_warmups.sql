-- Get a list of all users in California

SELECT *
FROM users
WHERE state_id=215

-- Get a list of all airports in Gwendolynfort

select *
from airports
where city_id=863;

-- Get a list of all payment methods used on itineraries by the user with email address 'kallie.weimann@dach.biz'

select *
from itineraries
where user_id=429;

-- Get a list of prices of all flights whose origins are in Port Gerardbury Probably International Airport.

select *
from flights
where origin_id=1

-- Find a list of all Airport names and codes which connect to the airport coded ZAM.

SELECT * FROM airports WHERE code='ZAM';

-- Get a list of all airports visited by user Sophie McGlynn after January 1, 2012. (Hint, see if you can get a list of all ticket IDs first).

select long_name from flights JOIN tickets ON flights.id=tickets.flight_id JOIN airports ON (origin_id = airports.id  OR destination_id = airports.id) where itinerary_id = 291;
