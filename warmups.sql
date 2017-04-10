-- Get a list of all users in California
SELECT users.*
FROM users
JOIN states
ON users.state_id = states.id
WHERE states.name = 'California';

-- Get a list of all airports in Kadeton
SELECT airports.long_name
FROM airports
JOIN cities
ON airports.city_id = cities.id
WHERE cities.name = 'Kadeton';

-- Get a list of all payment methods used on itineraries by the user with email address 'senger.krystel@marvin.io'
SELECT itineraries.*
FROM users
JOIN itineraries
ON users.id = itineraries.user_id
WHERE email = 'senger.krystel@marvin.io';

-- Get a list of prices of all flights whose origins are in Kochfurt Probably International Airport.
SELECT flights.*
FROM flights
JOIN airports
ON airports.id = flights.origin_id
WHERE airports.long_name = 'Kochfurt Probably International Airport';

-- Find a list of all Airport names and codes which connect to the airport coded LYT.
SELECT destinations.long_name, destinations.code
FROM flights
JOIN airports origins
 ON flights.origin_id = origins.id
JOIN airports destinations
 ON flights.destination_id = destinations.id
WHERE origins.code = 'LYT';

-- Get a list of all airports visited by user Krystel Senger after January 1, 2012. (Hint, see if you can get a list of all ticket IDs first).
SELECT origins.long_name, flights.departure_time
FROM flights
JOIN airports origins
  ON flights.origin_id = origins.id
JOIN airports destinations
  ON flights.destination_id = destinations.id
JOIN tickets
  ON flights.id = tickets.flight_id
JOIN itineraries
  ON tickets.itinerary_id = itineraries.id
JOIN users
  ON itineraries.user_id = users.id
WHERE users.first_name = 'Krystel'
  AND users.last_name = 'Senger'
  AND flights.departure_time > timestamp '2012-01-01';
