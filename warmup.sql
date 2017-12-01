---- VIKING FLIGHT BOOKER WARMUP ----

-- AIRLINES
  id
  origin_id
  destination_id
  departure_time
  arrival_time
  price
  created_at
  updated_at
  airline_id
  distance

-- USERS

id  | city_id | state_id | username | first_name | last_name |               email                |         created_at         |         updated_at

-- AIRPORTS

 id | city_id | state_id | code |                   long_name                    |         created_at         |         updated_at

-- CITIES

 id  |       name       |         created_at         |         updated_at

--itineraries
 id  | user_id | payment_method |         created_at         |         updated_at


 --flights
 id   | origin_id | destination_id |       departure_time       |        arrival_time        | price  |         created_at         |         updated_at         | airline_id | distance

--tickets
id  | itinerary_id | flight_id |         created_at         |         updated_at

-- Get a list of all users in California

SELECT username
  FROM users JOIN states ON users.state_id = states.id;

-- Get a list of all airports in Gwendolynfort

SELECT long_name
  FROM aiports JOIN cities ON airports.city_id = cities.id
  WHERE cities.name = 'Gwendolynfort';

-- Get a list of all payment methods used on itineraries by the user with email address 'kallie.weimann@dach.biz'
SELECT payment_method
  FROM users JOIN itineraries ON users.id = itineraries.user_id
  WHERE users.email = 'kallie.weimann@dach.biz';

-- Get a list of prices of all flights whose origins are in Port Gerardbury Probably International Airport.
SELECT flights.price
  FROM flights JOIN airports ON flights.origin_id = airports.id;


-- Find a list of all Airport names and codes which connect to the airport coded ZAM.
SELECT long_name, code
  FROM airports
  WHERE code='ZAM';

-- Get a list of all airports visited by user Sophie McGlynn after January 1, 2012. (Hint, see if you can get a list of all ticket IDs first).
SELECT airports.long_name
FROM flights JOIN airports ON airports.id = flights.origin_id
WHERE flights.id = (SELECT tickets.flight_id
  FROM users JOIN tickets ON users.id = tickets.id
  WHERE users.first_name='Sophie' AND users.last_name='McGlynn')
AND flights.arrival_time > '2012-01-01 00:00:00';
