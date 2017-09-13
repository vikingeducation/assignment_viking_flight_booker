-- Get a list of all users in California
SELECT CONCAT(users.first_name, ' ', users.last_name) AS name
FROM users JOIN states ON users.state_id = states.id
WHERE states.name = 'California';
-- Get a list of all airports in Minnesota
SELECT airports.long_name
FROM airports JOIN states ON airports.state_id = states.id
WHERE states.name = 'Minnesota';
-- Get a list of all payment methods used on itineraries by the user with email address 'senger.krystel@marvin.io'
SELECT itineraries.payment_method
FROM itineraries JOIN users ON itineraries.user_id = users.id
WHERE users.email = 'senger.krystel@marvin.io';
-- Get a list of prices of all flights whose origins are in Kochfurt Probably International Airport.
SELECT flights.price
FROM flights JOIN airports ON flights.origin_id = airports.id
WHERE airports.long_name = 'Kochfurt Probably International Airport';
-- Find a list of all Airport names and codes which connect to the airport coded LYT.
SELECT airports.long_name, airports.code
FROM airports JOIN flights ON airports.id = flights.origin_id
WHERE flights.destination_id = (
  SELECT id
  FROM airports
  WHERE code = 'LYT');
-- Get a list of all airports visited by user Krystel Senger after January 1, 2012. (Hint, see if you can get a list of all ticket IDs first).
SELECT airports.*
FROM  itineraries JOIN users ON itineraries.user_id = users.id
      JOIN tickets ON itineraries.id = tickets.itinerary_id
      JOIN flights ON tickets.flight_id = flights.id
      JOIN airports ON flights.origin_id = airports.id
WHERE users.first_name = 'Krystel'
      AND users.last_name = 'Sengar'
      AND flights.departure_time > '2012-01-01 00:00:00';
