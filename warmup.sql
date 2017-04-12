-- Here are some queries we'd like you to answer using this database:

-- Get a list of all users in California
SELECT * 
FROM users
JOIN states
ON users.state_id = states.id AND states.name = 'California';

-- Get a list of all airports in Kadeton
SELECT *
FROM airports
JOIN cities
ON airports.city_id = cities.id AND cities.name = 'Kadeton';

-- Get a list of all payment methods used on itineraries by the user with email address 'senger.krystel@marvin.io'
SELECT itineraries.id, payment_method 
FROM itineraries
JOIN users
ON itineraries.user_id = users.id AND users.email = 'senger.krystel@marvin.io';

-- Get a list of prices of all flights whose origins are in Kochfurt Probably International Airport.
SELECT flights.id, flights.price
FROM flights
JOIN airports
ON flights.origin_id = airports.id AND airports.long_name = 'Kochfurt Probably International Airport';

-- Find a list of all Airport names and codes which connect to the airport coded LYT.
SELECT long_name, code
FROM airports
WHERE code = 'LYT';

-- Get a list of all airports visited by user Krystel Senger after January 1, 2012. (Hint, see if you can get a list of all ticket IDs first).
SELECT users.first_name, users.last_name, A.long_name as Origin, B.long_name as Destination, flights.departure_time as flight_date
FROM users
JOIN itineraries
ON itineraries.user_id = users.id
JOIN tickets
ON tickets.itinerary_id = itineraries.id
JOIN flights
ON flights.id = tickets.flight_id
JOIN airports A
ON flights.origin_id = A.id
JOIN airports B
ON flights.destination_id = B.id
WHERE users.first_name = 'Krystel' 
  AND users.last_name = 'Senger'
  AND flights.departure_time > '2012-01-01'::date;


