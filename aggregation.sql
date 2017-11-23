-- 1. Find the top 5 most expensive flights that end in California.
SELECT flights.id, price
  FROM flights
  JOIN airports
    ON flights.destination_id = airports.id
  JOIN states
    ON airports.state_id = states.id
  WHERE states.name = 'California'
  ORDER BY price DESC
  LIMIT 5;

-- 2. Find the shortest flight that username 'emelia' took.
SELECT MIN(distance)
  FROM users
  JOIN itineraries
    ON users.id = itineraries.user_id
  JOIN tickets
    ON itineraries.id = tickets.itinerary_id
  JOIN flights
    ON tickets.flight_id = flights.id
  WHERE username = 'emelia';

-- 3. Find the average flight distance for every city in California
SELECT cities.name, ROUND(AVG(flights.distance)) AS avg_distance
  FROM flights
  JOIN airports
    ON ((flights.origin_id = airports.id) OR (flights.destination_id = airports.id))
  JOIN states
    ON airports.state_id = states.id
  JOIN cities
    ON airports.city_id = cities.id
  WHERE states.name = 'California'
  GROUP BY cities.name;

-- 4. Find the 3 users who spent the most money on flights in 2013
SELECT username, SUM(price) AS total_spending
  FROM users
  JOIN itineraries
    ON users.id = itineraries.user_id
  JOIN tickets
    ON itineraries.id = tickets.itinerary_id
  JOIN flights
    ON tickets.flight_id = flights.id
  WHERE tickets.created_at BETWEEN '2013-01-01' AND '2013-12-31'
  GROUP BY username
  ORDER BY total_spending DESC
  LIMIT 3;

-- 5. Count all flights to OR from the city of Smithshire that did not land in Delaware
SELECT COUNT(*)
  FROM flights
  JOIN airports
    ON ((flights.origin_id = airports.id) OR (flights.destination_id = airports.id))
  JOIN states
    ON airports.state_id = states.id
  JOIN cities
    ON airports.city_id = cities.id
  WHERE cities.name = 'Smithshire'
    AND flights.destination_id NOT IN (
      -- All flights which landed in Delaware
      SELECT flights.destination_id
        FROM flights
        JOIN airports
          ON flights.destination_id = airports.id
        JOIN states
          ON airports.state_id = states.id
        WHERE states.name = 'Delaware'
    );

-- 6. Return the range of lengths of flights in the system(the maximum, and the minimum).
SELECT MAX(distance) AS max_dist,
       MIN(distance) AS min_dist,
       MAX(arrival_time - departure_time) AS max_airtime,
       MIN(arrival_time - departure_time) AS min_airtime
  FROM flights;
