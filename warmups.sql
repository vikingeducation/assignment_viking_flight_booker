-- 1. Get a list of all users in California
SELECT * 
    FROM users
    JOIN states
      ON users.state_id = states.id
   WHERE states.name = 'California'
;

-- 2. Get a list of all airports in Morarberg
SELECT * 
    FROM airports
    JOIN cities
      ON airports.city_id = cities.id
   WHERE cities.name = 'Morarberg'
;

-- 3. Get a list of all payment methods used on itineraries by the user with email address 'gutkowski_delia@wuckert.com'
SELECT DISTINCT payment_method
    FROM itineraries
    JOIN users
      ON itineraries.user_id = users.id
  WHERE users.email = 'gutkowski_delia@wuckert.com'
;

-- 4. Get a list of prices of all flights whose origins are in Gibsonside Probably International Airport.
SELECT price
    FROM flights
    JOIN airports
      ON flights.origin_id = airports.id
  WHERE airports.long_name = 'Gibsonside Probably International Airport'
;

-- 5. Find a list of all Airport names and codes which connect to the airport coded FFH.
SELECT long_name
    FROM flights
    JOIN airports
      ON flights.origin_id = airports.id
   WHERE flights.destination_id = (
          SELECT id
              FROM airports
             WHERE code = 'FFH')
;

-- 6. Get a list of all airports visited by user Delia Gutkowski after January 1, 2012. (Hint, see if you can get a list of all ticket IDs first).
SELECT long_name, first_name, last_name, itineraries.id, arrival_time
    FROM users
    JOIN itineraries
      ON itineraries.user_id = users.id
    JOIN tickets
      ON itineraries.id = tickets.itinerary_id
    JOIN flights
      ON tickets.flight_id = flights.id
    JOIN airports
      ON flights.destination_id = airports.id
   WHERE first_name = 'Delia'
     AND last_name = 'Gutkowski'
     AND arrival_time > '2012-01-01'
;