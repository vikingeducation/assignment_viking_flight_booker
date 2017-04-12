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
SELECT airports.long_name
FROM tickets JOIN itineraries
  ON tickets.itinerary_id = itineraries.id
JOIN flights
  ON tickets.flight_id = flights.id
JOIN users
  ON itineraries.user_id = users.id
JOIN airports
  ON airports.id = flights.origin_id
  WHERE users.first_name = 'Krystel'
  AND users.last_name =  'Senger'
  AND flights.departure_time > '2012-01-01 18:27:26.97981';

  QUERIES 2
  1.
  SELECT flights.price
    FROM flights join airports
    on flights.destination_id = airports.id
    JOIN states
    ON states.id = airports.state_id
    WHERE states.name = 'California'
    ORDER BY flights.price desc
    LIMIT 5;


  2. flights -> itineraries -> users
  SELECT flights.distance
  FROM flights JOIN tickets
    ON tickets.flight_id = flights.id
  JOIN itineraries
    ON tickets.itinerary_id = itineraries.id
  JOIN users
    ON itineraries.user_id = users.id
  WHERE users.username = 'zora_johnson'
  ORDER BY flights.distance
  LIMIT 1;

  3. airports -> state_id (california)
     flights -> airports
SELECT (SUM(distance)/COUNT(* )) AS avg
FROM airports JOIN states
  ON airports.state_id = states.id
JOIN flights
  ON flights.origin_id = airports.id
WHERE states.name = 'California'
LIMIT 5;

4. users -> tickets -> itineraties -> flights -> .price
SELECT SUM(flights.price) AS price, users.first_name
FROM users JOIN itineraries
  ON users.id = itineraries.user_id
JOIN tickets
  ON itineraries.id = tickets.itinerary_id
JOIN flights
  ON tickets.flight_id = flights.id
GROUP BY users.first_name
ORDER BY price desc
LIMIT 3;

5. flights -> airports -> cities

SELECT flights
