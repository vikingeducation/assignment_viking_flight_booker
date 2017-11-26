1. Find the most popular travel destination for users who live in California.
SELECT cities.name, COUNT(*) AS dest_count
FROM users JOIN states
  ON users.state_id = states.id
JOIN airports
  ON states.id = airports.state_id
JOIN cities
  ON airports.city_id = cities.id
JOIN flights
  ON airports.id = flights.destination_id
WHERE states.name LIKE 'California'
GROUP BY cities.name
ORDER BY COUNT(*) DESC
LIMIT 10;


2. How many flights have round trips possible? In other words, we want
the count of all airports where there exists a flight FROM that airport and a
later flight TO that airport.
SELECT DISTINCT COUNT(flight1)
FROM flights flight1 JOIN flights flight2
  ON flight1.origin_id = flight2.destination_id
WHERE flight1.arrival_time < flight2.departure_time;


3. Find the cheapest flight that was taken by a user who only had one itinerary.
4. Find the average cost of a flight itinerary for users in each state in 2012.
