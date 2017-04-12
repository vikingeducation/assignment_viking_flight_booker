Get a list of all users in California

    SELECT username as "Users in California"
    FROM users
    JOIN states ON users.state_id = states.ID
    WHERE states.name = 'California';


Get a list of all airports in Kadeton

    SELECT long_name as "Airports in Kadeton"
    FROM airports
    JOIN cities ON airports.city_id = cities.id
    WHERE cities.name = 'Kadeton';

Get a list of all payment methods used on itineraries by the user with email address 'senger.krystel@marvin.io'

  SELECT DISTINCT payment_method as "Payment method"
  FROM users
  JOIN itineraries ON users.id = itineraries.user_id
  WHERE email='senger.krystel@marvin.io';

Get a list of prices of all flights whose origins are in Kochfurt Probably International Airport.

  SELECT flights.price as "Prices"
  FROM flights
  JOIN airports ON flights.origin_id = airports.id
  WHERE long_name = 'Kochfurt Probably International Airport';

Find a list of all Airport names and codes which connect to the airport coded LYT.

  SELECT destination_id, code
  FROM airports
  JOIN flights ON airports.id = flights.origin_id;
  WHERE code = 'LYT';



Get a list of all airports visited by user Krystel Senger after January 1, 2012. (Hint, see if you can get a list of all ticket IDs first).