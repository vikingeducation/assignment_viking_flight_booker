-- Get a list of all users in California
SELECT users.username
  FROM users
  JOIN states ON users.state_id = states.id
 WHERE states.name = 'California';

-- Get a list of all airports in Gwendolynfort
SELECT airports.long_name
  FROM airports
  JOIN cities ON airports.city_id = cities.id
 WHERE cities.name ='Gwendolynfort';

-- Get a list of all payment methods used on itineraries by
-- the user with email address 'kallie.weimann@dach.biz'
SELECT payment_method
  FROM itineraries
  JOIN users ON users.id = itineraries.user_id
 WHERE users.email = 'kallie.weimann@dach.biz';

-- Get a list of prices of all flights whose origins are
-- in Port Gerardbury Probably International Airport.
SELECT flights.price
  FROM flights
  JOIN airports ON airports.id = flights.origin_id
 WHERE airports.long_name = 'Port Gerardbury Probably International Airport';

-- Find a list of all Airport names and codes which
-- connect to the airport coded ZAM.
SELECT airports.long_name, airports.code, destination_id, origin_id
  FROM flights
  JOIN airports ON flights.origin_id = airports.id
 WHERE flights.destination_id = (
        SELECT airports.id
        FROM airports
        JOIN flights ON flights.destination_id = airports.id
        WHERE airports.code = 'ZAM'
        GROUP BY airports.id
 );

-- Get a list of all airports visited by user
-- Sophie McGlynn after January 1, 2012.
-- (Hint, see if you can get a list of all ticket IDs first).

SELECT users.first_name, tickets.id, airports.long_name
FROM users
    JOIN itineraries ON itineraries.user_id = users.id
    JOIN tickets ON tickets.itinerary_id = itineraries.id
    JOIN flights ON flights.id = tickets.flight_id
    JOIN airports ON airports.id = flights.origin_id
    OR airports.id = flights.destination_id
WHERE users.id = (
      SELECT users.id FROM users
      WHERE first_name = 'Sophie' AND last_name = 'McGlynn'
      AND itineraries.created_at > '2012-01-01'
);

-- hi
