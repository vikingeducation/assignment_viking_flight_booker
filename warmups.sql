1. Get a list of all users in California

SELECT *
FROM users
JOIN states ON (users.state_id = states.id)
WHERE states.name = 'California';

2. Get a list of all airports in Minnesota

SELECT *
FROM airports
JOIN states ON (airports.state_id = states.id)
WHERE states.name='Minnesota';

3. Get a list of all payment methods used on itineraries by the user with email address 'senger.krystel@marvin.io'

BROKEN

SELECT DISTINCT payment_method
FROM itineraries
JOIN users ON (itineraries.user_id = users.id)
WHERE users.email = 'hansen.lawson@marvin.io';

4. Get a list of prices of all flights whose origins are in Kochfurt Probably International Airport.

BROKEN

SELECT price
FROM flights
JOIN airports ON (flights.origin_id = airports.id)
WHERE airports.long_name = 'Koeppfurt Probably International Airport';

5. Find a list of all Airport names and codes which connect to the airport coded LYT.

BROKEN

SELECT DISTINCT airports.long_name, airports.code
FROM airports JOIN flights ON (airports.id = flights.destination_id)
WHERE airports.code = 'LYZ';

6. Get a list of all airports visited by user Krystel Senger after January 1, 2012. (Hint, see if you can get a list of all ticket IDs first).

BROKEN

SELECT flights.origin_id, flights.destination_id, airports.long_name
FROM flights JOIN airports ON (flights.destination_id = airports.id)
WHERE flights.id IN (
  SELECT tickets.flight_id
  FROM tickets JOIN itineraries ON (tickets.itinerary_id = itineraries.id)
  WHERE itineraries.user_id =
    (SELECT users.id
    FROM users
    WHERE users.first_name = 'Sophie' AND users.last_name = 'McGlynn'));
