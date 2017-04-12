assignment_viking_flight_booker
===============================

Querying an example airline database





1. SELECT * FROM users WHERE users.state_id = 1265;
2. SELECT * FROM airports WHERE airports.city_id = 29392;
3. SELECT payment_method FROM itineraries JOIN users ON itineraries.user_id = users.id WHERE users.email = 'senger.krystel@marvin.io';
4. SELECT price FROM flights JOIN airports ON flights.origin_id = airports.city_id WHERE airports.long_name LIKE '%Kochfurt%';
5. SELECT DISTINCT airports.long_name
FROM airports WHERE airports.code = 'LYT';

Get a list of all airports visited by user Krystel Senger after January 1, 2012.

6.
tickets to flights gives you airports
tickets to itineraries for user id

SELECT *
FROM tickets JOIN itineraries
  ON tickets.itinerary_id = itineraries.id
JOIN flights
  ON tickets.flight_id = flights.id
JOIN users
  ON itineraries.user_id = users.id
JOIN airports
  ON
