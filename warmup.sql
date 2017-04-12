-- Get a list of all users in California
SELECT username
FROM states
JOIN users ON states.id=users.state_id
WHERE states.name = 'California';


-- Get a list of all airports in Kadeton

SELECT airports.long_name
FROM airports
JOIN cities ON airports.city_id=cities.id
WHERE cities.name='Kadeton';

--  Kadeton Probably International Airport

-- Get a list of all payment methods used on itineraries by the user with email address 'senger.krystel@marvin.io'

SELECT DISTINCT itineraries.payment_method
FROM itineraries
JOIN users ON itineraries.user_id=users.id
WHERE users.email='senger.krystel@marvin.io';

--  MasterCard
--  Cash

-- Get a list of prices of all flights whose origins are in Kochfurt Probably International Airport.

SELECT flights.price
FROM flights
JOIN airports ON flights.origin_id=airports.id
WHERE airports.long_name='Kochfurt Probably International Airport';

--  price
-- --------
--  341.25
--  781.37
--  716.91
-- (3 rows)

-- Find a list of all Airport names and codes which connect to the airport coded LYT.


-- Get a list of all airports visited by user Krystel Senger after January 1, 2012. (Hint, see if you can get a list of all ticket IDs first).