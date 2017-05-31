-- Find the top 5 most expensive flights that end in California.
SELECT flights.price AS most_expensive
  FROM flights
  JOIN airports
    ON flights.destination_id = airports.id
  JOIN states
    ON airports.state_id = states.id
  WHERE states.name = 'California'
  ORDER BY most_expensive DESC
  LIMIT 5;

-- Find the shortest flight that username 'zora_johnson' took.
SELECT flights.distance AS shortest_flight
  FROM flights
  JOIN tickets
    ON flights.id = tickets.flight_id
  JOIN itineraries
    ON tickets.itinerary_id = itineraries.id
  JOIN users
    ON itineraries.user_id = users.id
  WHERE users.username = 'zora_johnson'
  ORDER BY shortest_flight ASC
  LIMIT 1;

-- Find the average flight distance for every city in California
SELECT cities.name AS city_name,
       AVG(flights.distance) AS avg_california_distance
  FROM flights
  JOIN airports
    ON flights.origin_id = airports.id
  JOIN states
    ON airports.state_id = states.id
  JOIN cities
    ON airports.city_id = cities.id
  WHERE states.name = 'California'
  GROUP BY city_name;

-- Find the 3 users who spent the most money on flights in 2013
SELECT users.username,
       SUM(flights.price) AS total_money_spent
  FROM flights
  JOIN tickets
    ON flights.id = tickets.flight_id
  JOIN itineraries
    ON itineraries.id = tickets.itinerary_id
  JOIN users
    ON users.id = itineraries.user_id
  GROUP BY 1
  ORDER BY 2 DESC
  LIMIT 3;

-- Count all flights to OR from the city of Smithshire that did not land in Delaware
SELECT COUNT(*) AS smithshire_not_to_delaware
  FROM flights
  -- airports
  JOIN airports origin
    ON flights.origin_id = origin.id
  JOIN airports destination
    ON flights.destination_id = destination.id
  -- states
  JOIN states origin_state
    ON origin.state_id = origin_state.id
  JOIN states destination_state
    ON destination.state_id = destination_state.id
  -- cities
  JOIN cities origin_city
    ON origin.city_id = origin_city.id
  JOIN cities destination_city
    ON destination.city_id = destination_city.id
  -- filter
  WHERE 'Smithshire' IN (origin_city.name, destination_city.name)
    AND destination_state.name != 'Delaware';

-- Return the range of lengths of flights in the system(the maximum, and the minimum).
SELECT MAX(flights.distance), MIN(flights.distance)
  FROM flights;
