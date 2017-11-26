1. Find the top 5 most expensive flights that end in California.
SELECT flights.id AS flight_id,
    states.name AS dest_state,
    price
  FROM states JOIN airports
    ON states.id = airports.state_id
  JOIN flights
    ON airports.city_id = flights.destination_id
  WHERE states.name LIKE 'California'
  ORDER BY flights.price DESC
  LIMIT 5;


2. Find the shortest flight that username 'emelia' took.
SELECT MIN(flights.distance) as shortest_flight_distance
FROM users JOIN itineraries
  ON users.id = itineraries.user_id
JOIN tickets
  ON itineraries.id = tickets.itinerary_id
JOIN flights
  ON tickets.flight_id = flights.id
WHERE users.username LIKE 'emelia';


3. Find the average flight distance for every city in California
SELECT cities.name AS city_name,
  AVG(flights.distance)
FROM states JOIN airports
  ON states.id = airports.state_id
JOIN cities
  ON airports.city_id = cities.id
JOIN flights
  ON airports.city_id = flights.origin_id
WHERE states.name = 'California'
GROUP BY cities.id
ORDER BY cities.name;


4. Find the 3 users who spent the most money on flights in 2013
SELECT users.username AS username,
  SUM(flights.price) AS user_total_price
FROM users JOIN itineraries
  ON users.id = itineraries.user_id
JOIN tickets
  ON itineraries.id = tickets.itinerary_id
JOIN flights
  ON tickets.flight_id = flights.id
WHERE (flights.departure_time >= '2013-01-01'AND flights.departure_time <= '2013-12-31')
  AND (flights.arrival_time >= '2013-01-01' AND flights.arrival_time <= '2013-12-31')
GROUP BY users.id
ORDER BY user_total_price DESC
LIMIT 3;


5. Count all flights to OR from the city of Smithshire that did not land in Delaware

6. Return the range of lengths of flights in the system(the maximum, and the minimum).
SELECT MAX(distance), MIN(distance)
FROM flights;
