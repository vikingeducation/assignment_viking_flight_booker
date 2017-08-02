-- 1. Get a list of all users in California
SELECT (first_name || ' ' || last_name) AS user
FROM users JOIN states
ON (users.state_id = states.id);

-- 2. Get a list of all airports in Jenniferview
SELECT long_name
FROM cities JOIN airports
ON (cities.id = city_id)
WHERE name = 'Jenniferview';

-- 3. Get a list of all payment methods used on itineraries by the user with email address 'raynor.tiara@haneeffertz.biz '
SELECT DISTINCT payment_method
FROM users JOIN itineraries
ON (users.id = itineraries.user_id)
WHERE email = 'raynor.tiara@haneeffertz.biz';

-- 4. Get a list of prices of all flights whose origins are in Kochfurt Probably International Airport
SELECT price FROM flights JOIN cities
ON (flights.origin_id = cities.id)
WHERE cities.name = 'Leschland';

-- 5. Find a list of all Airport names and codes which connect to the airport coded ZAM.
SELECT airports.long_name, airports.code
FROM airports JOIN flights
ON (airports.id = flights.origin_id)
WHERE flights.destination_id = (
    SELECT id FROM airports
    WHERE code = 'ZAM' LIMIT 1
);

-- 6. Get a list of all airports visited by user Krystel Senger after January 1, 2012. (Hint, see if you can get a list of all ticket IDs first).
SELECT DISTINCT airports.long_name
  FROM users JOIN itineraries ON (users.id = itineraries.id)
  JOIN tickets ON (itineraries.id = tickets.itinerary_id)
  JOIN flights ON (tickets.flight_id = flights.id)
  JOIN airports ON (flights.origin_id = airports.id) OR (flights.destination_id = airports.id)
  WHERE users.id = (SELECT id FROM users WHERE users.first_name = SPLIT_PART('Sophie McGlynn', ' ', 1)
  AND users.last_name = SPLIT_PART('Sophie McGlynn', ' ', 2))
  AND flights.arrival_time > '2012-01-01'::DATE ORDER BY airports.long_name;
