-- 1. Some question that asks you to query the database
SELECT * FROM flights;


1. Get a list of all users in California
  select users.first_name, users.last_name
  from users join states on users.state_id = states.id
  where states.name = 'California';

2. Get a list of all airports in Kadeton
  select airports.long_name
  from airports join cities on airports.city_id = cities.id
  where cities.name = 'Kadeton';

3. Get a list of all payment methods used on itineraries by the user with email address 'senger.krystel@marvin.io'
select itineraries.payment_method
from itineraries join users on itineraries.user_id = users.id
where email = 'senger.krystel@marvin.io';


4. Get a list of prices of all flights whose origins are in Kochfurt Probably International Airport.
select flights.price
from flights join airports on flights.origin_id = airports.id
where airports.long_name = 'Kochfurt Probably International Airport';

5. Find a list of all Airport names and codes which connect to the airport coded LYT.
select airports.long_name, airports.code
from airports join flights on airports.id = flights.origin_id
where flights.destination_id = (select airports.id
  from airports
  where code = 'LYT');

6. Get a list of all airports visited by user Krystel Senger after January 1, 2012. (Hint, see if you can get a list of all ticket IDs first).
select airports.long_name
from ((((airports join flights on airports.id = flights.origin_id) join tickets on flights.id = tickets.flight_id) join itineraries on tickets.itinerary_id = itineraries.id) join users on itineraries.user_id =users.id)
where user.first_name = 'Krystel' AND user.last_name = 'Senger' AND created_at > '2012-01-01';
