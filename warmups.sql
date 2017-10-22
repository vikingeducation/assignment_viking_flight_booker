-- 1. Get a list of all users in California
SELECT users.first_name, users.last_name, state_id
FROM users
JOIN states ON (state_id=states.id)
WHERE states.name LIKE 'California';

-- 2. Get a list of all airports in Gwendolynfort
SELECT *
FROM airports
  JOIN cities
  ON airports.city_id = cities.id
WHERE cities.name LIKE 'Gwendolynfort';

-- 3. Get a list of all payment methods used on itineraries by the user with email address 'kallie.weimann@dach.biz'
SELECT payment_method
FROM itineraries
  JOIN users
    ON itineraries.user_id = users.id
WHERE email LIKE 'kallie.weimann@dach.biz';

-- 4. Get a list of prices of all flights whose origins are in Port Gerardbury Probably International Airport.
SELECT flights.price
FROM flights
  JOIN airports
    ON flights.origin_id = airports.id
WHERE airports.long_name LIKE 'Port Gerardbury Probably International Airport';

-- 5. Find a list of all Airport names and codes which connect to the airport coded ZAM.
SELECT DISTINCT long_name, code
FROM airports
  JOIN flights
    ON airports.id = flights.origin_id OR airports.id = flights.destination_id
WHERE (flights.origin_id = (SELECT id FROM airports WHERE code = 'ZAM')
  OR flights.destination_id = (SELECT id FROM airports WHERE code = 'ZAM'))
  AND code != 'ZAM';

-- 6. Get a list of all airports visited by user Sophie McGlynn after January 1, 2012. (Hint, see if you can get a list of all ticket IDs first).
SELECT airports.long_name
FROM tickets
  JOIN flights
    ON tickets.flight_id = flights.id
  JOIN itineraries
    ON tickets.itinerary_id = itineraries.id
  JOIN users
    ON itineraries.user_id = users.id
  JOIN airports
    ON airports.id = flights.origin_id OR airports.id = flights.destination_id
WHERE users.first_name LIKE 'Sophie'
  AND users.last_name LIKE 'McGlynn'
  AND (flights.departure_time > '2012-01-01 00:00:00'
      OR flights.arrival_time > '2012-01-01 00:00:00');
