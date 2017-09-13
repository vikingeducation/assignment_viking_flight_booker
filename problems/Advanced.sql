-- Find the most popular travel destination for users who live in California.
SELECT cities.name AS "city", states.name as "state", COUNT(cities.name) AS "count_of_trips"
FROM users JOIN itineraries ON users.id = itineraries.user_id
  JOIN tickets ON itineraries.id = tickets.itinerary_id
  JOIN flights ON tickets.flight_id = flights.id
  JOIN airports ON flights.destination_id = airports.id
  JOIN states ON airports.state_id = states.id
  JOIN cities ON airports.city_id = cities.id
WHERE users.state_id = (SELECT states.id
    FROM states
    WHERE states.name = 'California')
GROUP BY cities.name, states.name;
-- How many flights have round trips possible? In other words, we want the count of all airports where there exists a flight FROM that airport and a later flight TO that airport.
SELECT COUNT(*)
FROM flights AS outside_flights
WHERE EXISTS (
  SELECT *
  FROM flights
  WHERE destination_id = outside_flights.origin_id AND departure_time > outside_flights.arrival_time
);
-- Find the cheapest flight that was taken by a user who only had one itinerary.
SELECT flights.price, users.id, COUNT(users.id)
FROM users JOIN itineraries ON users.id = itineraries.user_id
  JOIN tickets ON itineraries.id = tickets.itinerary_id
  JOIN flights ON tickets.flight_id = flights.id
GROUP BY users.id, flights.price
ORDER BY COUNT(users.id), flights.price, users.id
LIMIT 1;
-- Find the average cost of a flight itinerary for users in each state in 2012.
SELECT states.name, AVG(flights.price)
FROM users JOIN itineraries ON users.id = itineraries.user_id
  JOIN tickets ON itineraries.id = tickets.itinerary_id
  JOIN flights ON tickets.flight_id = flights.id
  JOIN states ON users.state_id = states.id
WHERE flights.departure_time > '2011-12-31 23:59:59' AND flights.arrival_time < '2013-01-01 00:00:01'
GROUP BY states.name;
-- Bonus: You're a tourist. It's May 6, 2013. Book the cheapest set of flights over the next six weeks that connect Oregon, Pennsylvania and Arkansas, but do not take any flights over 400 miles in distance. Note: This can be ~50 lines long but doesn't require any subqueries.
