1. Get a list of all users in California
SELECT * FROM Users
  WHERE state_id = 215;


2. Get a list of all airports in Gwendolynfort
SELECT airports.long_name FROM airports
  WHERE city_id = 863;


3. Get a list of all payment methods used on itineraries by the user
    with email address 'kallie.weimann@dach.biz'
SELECT users.email, itineraries.payment_method
  FROM users JOIN itineraries
  ON users.id = itineraries.user_id
  WHERE email ILIKE 'kallie.weimann@dach.biz';


4. Get a list of prices of all flights whose origins are in Port Gerardbury
    Probably International Airport.
SELECT airports.long_name, flights.price
  FROM airports JOIN flights
  ON airports.id = flights.origin_id
  WHERE airports.long_name LIKE 'Port Gerardbury Probably International Airport';


5. Find a list of all Airport names and codes which connect to the airport coded ZAM.
SELECT airports.long_name, airports.code
  FROM airports JOIN flights
  ON airports.id = flights.origin_id
  WHERE flights.destination_id = (
    SELECT airports.id FROM airports
      WHERE airports.code LIKE 'ZAM'
  );


6. Get a list of all airports visited by user Sophie McGlynn after January 1, 2012.
    (Hint, see if you can get a list of all ticket IDs first).
