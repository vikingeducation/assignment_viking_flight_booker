-- 1. Find the most popular travel destination for users who live in California.
SELECT cities.name AS city, COUNT(*) AS visits
  FROM users
  JOIN states
    ON users.state_id = states.id
  JOIN airports
    ON states.id = airports.state_id
  JOIN flights
    ON airports.id = flights.destination_id
  JOIN cities
    ON airports.city_id = cities.id
  WHERE states.name = 'California'
  GROUP BY cities.name
  ORDER BY visits DESC;

-- 2. How many flights have round trips possible? In other words, we want the count of all airports where there exists a flight FROM that airport and a later flight TO that airport.
SELECT COUNT(DISTINCT outbound_flight.origin_id)
  FROM flights AS outbound_flight
  JOIN flights AS return_flight
    ON outbound_flight.origin_id = return_flight.destination_id
  AND outbound_flight.arrival_time < return_flight.departure_time;

-- 3. Find the cheapest flight that was taken by a user who only had one itinerary.
SELECT user_id, flight_id, price
  FROM users
  JOIN itineraries
    ON users.id = itineraries.user_id
  JOIN tickets
    ON itineraries.id = tickets.itinerary_id
  JOIN flights
    ON tickets.flight_id = flights.id
  WHERE user_id IN (
      -- Users with only one itinerary
      SELECT users.id
        FROM users
        JOIN itineraries
          ON users.id = itineraries.user_id
        GROUP BY users.id
        HAVING COUNT(itineraries.id) = 1
  )
  ORDER BY price
  LIMIT 1;

-- 4. Find the average cost of a flight itinerary for users in each state in 2012.
SELECT states.name AS state, ROUND(AVG(price)) AS avg_cost
  FROM users
  JOIN itineraries
    ON users.id = itineraries.user_id
  JOIN tickets
    ON itineraries.id = tickets.itinerary_id
  JOIN flights
    ON tickets.flight_id = flights.id
  JOIN states
    ON users.state_id = states.id
  WHERE flights.departure_time BETWEEN '2012-01-01' AND '2012-12-31'
  GROUP BY state
  ORDER BY state;
