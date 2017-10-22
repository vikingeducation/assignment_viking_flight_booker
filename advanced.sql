-- 1. Find the most popular travel destination for users who live in California.
SELECT cities.name, COUNT(cities.name) AS "Visit Count"
FROM cities
  JOIN flights
    ON cities.id = flights.destination_id
  JOIN tickets
    ON flights.id = tickets.flight_id
  JOIN itineraries
    ON tickets.itinerary_id = itineraries.id
WHERE itineraries.user_id IN (SELECT users.id
                               FROM users
                                JOIN states
                                  ON (users.state_id=states.id)
                               WHERE states.name = 'California')
GROUP BY cities.name
ORDER BY 2 DESC
LIMIT 1;

-- 2. How many flights have round trips possible? In other words, we want the count of all airports where there exists a flight FROM that airport and a later flight TO that airport.
SELECT outside_flights.origin_id, outside_flights.destination_id
 FROM flights AS outside_flights
 WHERE EXISTS (
   SELECT *
   FROM flights
   WHERE destination_id = outside_flights.origin_id
     AND origin_id = outside_flights.destination_id
     AND departure_time > outside_flights.arrival_time
 );

-- 3. Find the cheapest flight that was taken by a user who only had one itinerary.
SELECT flights.id AS "Flight ID", MIN(flights.price) AS "Price"
FROM users
  JOIN itineraries ON users.id = itineraries.user_id
  JOIN tickets ON tickets.itinerary_id = itineraries.id
  JOIN flights ON tickets.flight_id = flights.id
WHERE itineraries.user_id IN (
  SELECT user_id
  FROM itineraries
  GROUP BY user_id
  HAVING COUNT(user_id) = 1
)
GROUP BY flights.id
ORDER BY 2
LIMIT 1;

-- 4. Find the average cost of a flight itinerary for users in each state in 2012
SELECT states.name, ROUND(AVG(flights.price)) AS "Average Price"
FROM states
  JOIN airports ON states.id = airports.state_id
  JOIN flights ON airports.id = flights.origin_id OR airports.id = flights.destination_id
WHERE EXTRACT(YEAR FROM flights.departure_time) = 2012
GROUP BY states.name;
