-- 1. Get a list of all users in California
SELECT *
  FROM users
  JOIN states
    ON users.state_id = states.id
  WHERE states.name = 'California';

-- 2. Get a list of all airports in Gwendolynfort
SELECT *
  FROM airports
  JOIN cities
    ON airports.city_id = cities.id
  WHERE cities.name = 'Gwendolynfort';

-- 3. Get a list of all payment methods used on itineraries by the user with email address 'kallie.weimann@dach.biz'
SELECT payment_method
  FROM itineraries
  JOIN users
    ON itineraries.user_id = users.id
  WHERE users.email = 'kallie.weimann@dach.biz';

-- 4. Get a list of prices of all flights whose origins are in Port Gerardbury Probably International Airport.
SELECT price
  FROM flights
  JOIN airports
    ON flights.origin_id = airports.id
  WHERE airports.long_name = 'Port Gerardbury Probably International Airport';

-- 5. Find a list of all Airport names and codes which connect to the airport coded ZAM.
SELECT code, long_name
  FROM airports
  JOIN flights
    ON airports.id = flights.origin_id
  WHERE destination_id = (
      SELECT id
        FROM airports
        WHERE code = 'ZAM');

-- 6. Get a list of all airports visited by user Sophie McGlynn after January 1, 2012.
SELECT tickets.flight_id, origin_airport.long_name AS origin, destination_airport.long_name AS destination
  FROM users
  JOIN itineraries
    ON users.id = itineraries.user_id
  JOIN tickets
    ON itineraries.id = tickets.itinerary_id
  JOIN flights
    ON tickets.flight_id = flights.id
  JOIN airports AS origin_airport
    ON flights.origin_id = origin_airport.id
  JOIN airports AS destination_airport
    ON flights.destination_id = destination_airport.id
  WHERE users.first_name = 'Sophie'
    AND users.last_name = 'McGlynn'
    AND flights.departure_time > '2012-01-01 00:00:00';
