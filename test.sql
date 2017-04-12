SELECT airports.long_name
FROM tickets JOIN itineraries
  ON tickets.itinerary_id = itineraries.id
JOIN flights
  ON tickets.flight_id = flights.id
JOIN users
  ON itineraries.user_id = users.id
JOIN airports
  ON airports.id = flights.origin_id
  WHERE users.first_name = 'Krystel'
  AND users.last_name =  'Senger'
  AND flights.departure_time > '2012-01-01 18:27:26.97981';

flights to airports to state_id

SELECT flights.price
  FROM flights join airports
  on flights.destination_id = airports.id
  JOIN states
  ON states.id = airports.state_id
  WHERE states.name = 'California'
  ORDER BY flights.price desc
  LIMIT 5

flights - airports - states - cities

SELECT count(*) AS number_of_flights
  FROM flights JOIN airports
  ON flights.origin_id = airports.id
  JOIN states
  ON airports.state_id = states.id
  JOIN cities
  ON airports.city_id = cities.id
  WHERE states.name <> 'Delaware'
  AND cities.name = 'Smithshire';



SELECT MAX(flights.distance) AS Max_r, MIN(flights.distance) AS Min_r
  FROM flights;

states - users - itineraries - flights - cities

SELECT COUNT(flights.destination_id) as poop, cities.name
  FROM states JOIN users
  ON states.id = users.state_id
  JOIN itineraries
  ON itineraries.user_id = users.id
  JOIN tickets
  ON itineraries.id = tickets.itinerary_id
  JOIN flights
  ON flights.id = tickets.flight_id
  JOIN airports
  ON airports.id = flights.destination_id
  JOIN cities
  ON airports.city_id = cities.id
  WHERE states.name = 'California'
  OR users.state_id = states.id
  GROUP BY flights.destination_id
  ORDER BY poop desc;
