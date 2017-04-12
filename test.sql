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

  users - 
